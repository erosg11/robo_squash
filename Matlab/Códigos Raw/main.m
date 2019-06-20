clear;
clc;
tic

% Roda os parâmetros iniciais
run parametros_iniciais.m;

[matrizPosicao, matrizVelocidade, matrizAceleracao, qtdPontos] = selecionaParametrizacao(tipoDeparametrizacao, tempoTotalSegmento, taxaAmostragem, moduloAceleracao);

%---- Cinemática da posicação---%
%----Variáveis Simbólicas----%
q = sym('q',[1 6]);

%----Entrando com as matrizes de rotação e translação----%
%---Para resolver os problemas de q1,q2 e q3---%
R10 = rotacionaMatriz('z', q(1));
D10 = transladaMatriz([e1 0 l1]);
T10 = R10*D10;

R21 = rotacionaMatriz('y', q(2));
D21 = transladaMatriz([l2 0 0]);
T21 = R21*D21;
T20 = T10*T21;

R32 = rotacionaMatriz('y', q(3));
D32 = transladaMatriz([l3 0 e2]);
T32 = R32*D32;
T30 = T20*T32;

%---Para resolver os problemas de q4's,q5's e q6's---%
R43 = rotacionaMatriz('x', q(4));
D43 = transladaMatriz([0 0 0]);
T43 = R43*D43;
T40 = T30*T43;

R54 = rotacionaMatriz('y', q(5));
D54 = transladaMatriz([0 0 0]);
T54 = R54*D54;
T50 = T40*T54;

R65 = rotacionaMatriz('x', q(6));
D65 = transladaMatriz([0 0 0]);
T65 = R65*D65;
T60 = T50*T65;

T63 = T43*T54*T65;

% equacionamento da ferramenta
T76 = transladaMatriz(lc_raquete+[x_raquete y_raquete 0]);
T70 = T60*T76;

P37 = [-T76(1:3,4)' 1]';

% Prealocando memória
matrizPosicaoJuntas = zeros(length(matrizPosicao),6);
matrizVelocidadeJuntas = zeros(length(matrizPosicao),6);
matrizAceleracaoJuntas = zeros(length(matrizPosicao),6);
torque = zeros(length(matrizPosicao),6);
angulos = zeros(length(matrizPosicao)+1,6);
P70 = zeros(length(matrizPosicao),4);

%encontrando os jacobianos
run calculaParametros.m;

for i = 1:length(matrizPosicao)
    T70 = transladaMatriz(matrizPosicao(i,1:3));
    
    P70(i,:) = [T70(1:3,4)', matrizPosicao(i,4)];
    P30 = T70*P37; % Posição do centro de rotação com Relação ao referencial inercial
    
    %--- Encontrando os Valores de q1,q2,q3----%
    % Calculando q1's
    q1 = atan(P30(2)/P30(1));
    if double(q1) > 0
        q1s = [q1, q1-pi];
    else
        q1s = [q1, q1+pi];
    end
    
    q2s = [];
    q3s = [];
    for j = 1:2
        % Calculando q2's
        a = (P30(1)-e1*cos(q1s(j)))/cos(q1s(j));
        b = P30(3)-l1;
        
        A = b;
        B = -a;
        C = (a^2+l2^2+b^2-(l3^2+e2^2))/(2*l2);
        q2s = [q2s, corrigeErroAproximacao(calculateBaskSolution(A,B,C), fatorDePrecisao)];
        
        % Calculando q3's
        a = (P30(2)-e1*sin(q1s(j)))/sin(q1s(j));   
        
        A = e2;
        B = l3;
        C = (l2^2+l3^2+e2^2-(a^2+b^2))/(2*l2);        
        q3s = [q3s, corrigeErroAproximacao(calculateBaskSolution(A,B,C), fatorDePrecisao)];
    end
    
    % Verificação da cinemática inversa
    qPossiveis = [];
    qPrecisos = [];
    for k = 1:2
        for l = 1+4*(k-1):4*k
            for m = 1+4*(k-1):4*k
                q1 = q1s(k);
                q2 = q2s(l);
                q3 = q3s(m);
                
                T30num = double(subs(T30));
                T63num = T30num\T70/T76;
                
                % Calculando q4, q5 e q6
                q4 = atan(-T63num(2,1)/T63num(3,1));
                q5 = acos(T63num(1,1));
                q6 = atan(T63num(1,2)/T63num(1,3));
                
                if angulos(i,4) - (q4+180) > angulos(i,4) - (q4-180)
                    q4s = [q4, q4-180];
                else
                    q4s = [q4, q4+180];
                end
                q5s = [q5, -q5];
                q6s = [q6, -q6];
                
                %Encontrando soluções
                T70num = double(subs(T30*T63*T76));
                diferencaPosicoes =  T70num(1:3,4)' - T70(1:3,4)';
                
                % Filtrando soluções que não são precisas ou não estão na
                % posição desejada
                if(norm(diferencaPosicoes) < fatorDePrecisao && isreal(T70num(1:3,4)') == 1)
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
        maisProximo = 2*pi;
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
    
    %Calculando as velocidades
    V = [T70(1:3,1:3)*matrizVelocidade(i,:)'; 0; 0; 0];
    JLAc = double(subs(JLAc,q,matrizPosicaoJuntas(i,:)));
    matrizVelocidadeJuntas(i,:) = JLAc\V;
    
    %Calculando as acelerações
    A = [T70(1:3,1:3)*matrizAceleracao(i,:)'; 0; 0; 0];
    matrizAceleracaoJuntas(i,:) = JLAc\(A - double(subs(dJLAc,[q dq'],[matrizPosicaoJuntas(i,:) matrizVelocidadeJuntas(i,:)]))*matrizVelocidadeJuntas(i,:)');
    
    %Calculando os torques
    T1 = double(subs(ddLdqpdt,[q_L' dq_L' ddq_L'],[matrizPosicaoJuntas(i,:) matrizVelocidadeJuntas(i,:) matrizAceleracaoJuntas(i,:)]));
    T2 = - double(subs(dLdq,[q dq'],[matrizPosicaoJuntas(i,:) matrizVelocidadeJuntas(i,:)]));
    T3 = double(subs(dEddqp,[q dq'],[matrizPosicaoJuntas(i,:) matrizVelocidadeJuntas(i,:)]));
    torque(i,:) = double(T1+T2+T3)
end

%Plot do plano inclinado e dos pontos parametrizados da letra E.
plotTrajetoria(P70);

%Plot dos Gráficos relacionados a posição, velocidade e aceleração da
%ferramenta no plano
plotCinematicoFerramenta(matrizPosicao(:,1:3),matrizVelocidade,matrizAceleracao,tempoPlot);

%Plot dos Gráficos relacionados a posição, velocidade e aceleração na
%junta
plotCinematicoJuntas(matrizPosicaoJuntas*toAngule,matrizVelocidadeJuntas*toAngule,matrizAceleracaoJuntas*toAngule,tempoPlot);

%Plot dos torques de cada uma das juntas
plotDinamicoJuntas(torque,tempoPlot);

toc