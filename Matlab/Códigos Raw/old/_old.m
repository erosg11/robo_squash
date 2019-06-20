clear all;
clc;
tic

% Robô RK 6 R900 - 2 %
%----Parâmetros Iniciais----%
l1 = 0.400;
e1 = 0.025;
l2 = 0.455;
l3 = 0.420;
e2 = 0.025;
l4 = 0.090;
lc_raquete = [l4+0.22 0 0.075];
raio_max_raquete = 0.11;

%input do usuário
teta_selecionado = 90; %valor em graus
r_raquete = 0.055;

            %FAZ-SE NECESSÁRIO VERIFICAR SE OS INPUTS ESTÃO DENTRO DO RANGE!!!!

qRange = [-170 170; -190 45; -120 156; -185 185; -120 120; -350 350]; %range dado pelo fabricante(todos estão normalizados)
moduloAceleracao = 0.1; % modulo da aceleração p/ quinta ordem
tempoTotalSegmento = 3; % tempo em segundos
taxaAmostragem = 0.2; %taxa de amostragem
fatorDePrecisao = 0.001; %Precisao do movimento em metros
angulos(1,:) = [0 0 0 0 0 0]; % posicao inicial do braço robótico

            % ESSES PARAMETROS PRECISAM SER MODIFICADOS PARA A TAREFA CORRETA
            
alpha = 30; % rotação eixo z
beta = 45; % rotação eixo x

%Seleciona o tipo de parametrização desejada, 'cubica', 'quinta_ordem' ou
%'reta_parabola'
[matrizPosicao, matrizVelocidade, matrizAceleracao, qtdPontos] = selecionaParametrizacao('cubica', tempoTotalSegmento, taxaAmostragem, moduloAceleracao);

%---- Cinemática da posicação---%
%----Variáveis Simbólicas----%
syms q1 q2 q3 q4 q5 q6;
q = [q1 q2 q3 q4 q5 q6];

%----Entrando com as matrizes de rotação e translação----%
%---Para resolver os problemas de q1,q2 e q3---%
R10 = rotacionaMatriz('z', q(1));
D10 = transladaMatriz([e1 0 l1]);
T10 = R10*D10;

R21 = rotacionaMatriz('y', q(2));
D21 = transladaMatriz([l2 0 0]);
T21 = R21*D21;

R32 = rotacionaMatriz('y', q(3));
D32 = transladaMatriz([l3 0 e2]);
T32 = R32*D32;

T31 = T21*T32;
T30 = T10*T31;

% equacionamento da ferramenta
D76 = transladaMatriz(lc_raquete);
T76 = D76;

R87 = rotacionaMatriz('z', teta_selecionado);
D87 = transladaMatriz([r_raquete 0 0]);
T87 = R87*D87;

T86 = T76*T87;

%---Para resolver os problemas de q4's,q5's e q6's---%
R43 = rotacionaMatriz('x', q(4));
D43 = transladaMatriz([0 0 0]);
T43 = R43*D43;

R54 = rotacionaMatriz('y', q(5));
D54 = transladaMatriz([0 0 0]);
T54 = R54*D54;

R65 = rotacionaMatriz('x', q(6));
D65 = transladaMatriz([0 0 0]);
T65 = R65*D65;

T63 = T43*T54*T65;
T38 = inv(T86);
%P38 = [T38(1:3,4)' 1]'; % Posição da ponta do instrumento em relação ao referencial 3
P38 = [-(lc_raquete+[r_raquete*cosd(teta_selecionado) r_raquete*sind(teta_selecionado) 0]) 1]';

%encontrando os jacobianos
run calculaJacobianosSimbolicos.m;

for i = 1:length(matrizPosicao)
    D3_80 = transladaMatriz(matrizPosicao(i,1:3));
    T80 = D3_80;
    
    P80(i,:) = [T80(1:3,4)', matrizPosicao(i,4)];
    P30 = T80*P38; % Posição do centro de rotação com Relação ao referencial inercial
    
    %--- Encontrando os Valores de q1,q2,q3----%
    q1s = [];
    q2s = [];
    q3s = [];
    
    % Calculando q1's
    q1 = atand(P30(2)/P30(1));
    if double(q1) > 0
        q1s = [q1, q1-180];
    else
        q1s = [q1, q1+180];
    end
    
    for j = 1:2
        % Calculando q2's
        a = (P30(2)-e1*sind(q1s(j)))/sind(q1s(j));
        b = P30(3)-l1;
        
        A = b;
        B = -a;
        C = (a^2+b^2+l2^2-(l3^2+e2^2)/(2*l2));
        
        q2s = [q2s, calculateBaskSolution(A,B,C)];
        
        % Calculando q3's
        A = e2;
        B = l3;
        C = (l2^2+l3^2+e2^2-(a^2+b^2))/(2*l2);
        
        q3s = [q3s, calculateBaskSolution(A,B,C)];        
    end
    
    % Verificação da cinemática inversa
    qPossiveis = [];
    qPrecisos = [];
    for k = 1:2
        for l = 1+4*(k-1):4*k
            for m = 1+2*(k-1):2*k
                q1 = q1s(k);
                q2 = q2s(l);
                q3 = q3s(m);
                
                T30num = double(subs(T30));
                T63num = T30num\T80/T86;
                
                % Calculando q4, q5 e q6
                q4 = atand(-T63num(2,1)/T63num(3,1));
                q5 = acosd(T63num(1,1));
                q6 = atand(T63num(1,2)/T63num(1,3));
                
                if angulos(i,4) - (q4+180) > angulos(i,4) - (q4-180)
                    q4s = [q4, q4-180];
                else
                    q4s = [q4, q4+180];
                end
                q5s = [q5, -q5];
                q6s = [q6, -q6];
                
                %Encontrando soluções
                T80num = double(subs(T30*T63*T86));
                diferencaPosicoes =  T80num(1:3,4)' - T80(1:3,4)';
                
                % Filtrando soluções que não são precisas ou não estão na
                % posição desejada
                [T80num(1:3,4)'; T80(1:3,4)']
                if(norm(diferencaPosicoes) < fatorDePrecisao && isreal(T80num(1:3,4)') == 1)
                    for n = 1:2
                        for o = 1:2
                            for p = 1:2
                                q4 = q4s(p);
                                q5 = q5s(o);
                                q6 = q6s(n);
                                
                                qNum = double(subs(q));
                                qPrecisos = [qPrecisos; qNum];
                                % Filtrando apenas soluções dentro do range
                                if verificaVolumeControle(qRange, qNum) == 0
                                    qPossiveis = [qPossiveis; qNum];
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    if length(qPrecisos) == 0
        error("Não foram encontradas soluções para o ponto " + i + ". Programa finalizado, ajuste os parâmetros.")
    elseif length(qPossiveis) == 0
        qPrecisos
        error("Para o ponto " + i + ", não foram encontradas soluções dentro do Range.");
    else
        maisProximo = 360;  
        % Filtrando soluções que, comparados com o valor anterior, são mais
        % próximas do valor atual do angulo
        for k = 1:length(qPossiveis(:,1))
            normaDiferenca = norm(angulos(i,:)-qPossiveis(k,:));
            if normaDiferenca < maisProximo
                maisProximo = normaDiferenca;
                qSelecionado = qPossiveis(k,:);
            end
        end
        matrizPosicaoJuntas(i,:) = qSelecionado;
        angulos(i+1,:) = qSelecionado;
    end    
    
%     %Calculando as velocidades    
%     q1 = matrizPosicaoJuntas(i,1);
%     q2 = matrizPosicaoJuntas(i,2);
%     q3 = matrizPosicaoJuntas(i,3);
%     q4 = matrizPosicaoJuntas(i,4);
%     q5 = matrizPosicaoJuntas(i,5);
%     q6 = matrizPosicaoJuntas(i,6);
%     V = [T70(1:3,1:3)*matrizVelocidade(i,:)'; 0; 0; 0];
%     matrizVelocidadeJuntas(i,:) = double(subs(JLA))\V;
%     
%     %Calculando as acelerações    
%     dq1 = matrizVelocidadeJuntas(i,1);
%     dq2 = matrizVelocidadeJuntas(i,2);
%     dq3 = matrizVelocidadeJuntas(i,3);
%     dq4 = matrizVelocidadeJuntas(i,4);
%     dq5 = matrizVelocidadeJuntas(i,5);
%     dq6 = matrizVelocidadeJuntas(i,6);
%     
%     A = [T70(1:3,1:3)*matrizAceleracao(i,:)'; 0; 0; 0];
%     matrizAceleracaoJuntas(i,:) = double(subs(JLA))\(A - double(subs(dJLA))*matrizVelocidadeJuntas(i,:)');
end

%Plot do plano inclinado e dos pontos parametrizados da letra E.
planoInclinado(P80(qtdPontos+1,1:3),P80(2*qtdPontos+1,1:3),P80(3*qtdPontos+1,1:3),P80);

%Plot dos Gráficos relacionados a posição, velocidade e aceleração da
% %ferramenta no plano
% plotCinematicoFerramenta(matrizPosicao(:,1:3),matrizVelocidade,matrizAceleracao,tempoTotalSegmento*8);
% 
% %Plot dos Gráficos relacionados a posição, velocidade e aceleração na
% %junta
% plotCinematicoJuntas(matrizPosicaoJuntas,matrizVelocidadeJuntas,matrizAceleracaoJuntas,tempoTotalSegmento*8);

toc
