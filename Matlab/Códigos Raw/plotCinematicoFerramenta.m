function plotCinematicoFerramenta(matrizPosicao,matrizVelocidade,matrizAceleracao,tempoTotal)
% Função que plota os gráficos da cinemática da ferramenta
    passo = (tempoTotal)/length(matrizPosicao);
    t = 0+passo:passo:tempoTotal;
    
    figure
    handle = plot(t,matrizPosicao(:,1),t,matrizPosicao(:,2),t,matrizPosicao(:,3));
    set(handle,'LineWidth',5);
    legend('x','y','z');
    title('Posição da Ponta da Ferramenta no referencial do Plano.');
    ylabel('Posição (metros)');
    xlabel('Tempo (segundos)');
    
    figure
    handle = plot(t,matrizVelocidade(:,1),t,matrizVelocidade(:,2),t,matrizVelocidade(:,3));
    set(handle,'LineWidth',5);
    legend('x','y','z');
    title('Velocidade da Ponta da Ferramenta no referencial do Plano.');
    ylabel('Velocidade (metros/s)');
    xlabel('Tempo (segundos)');
    
    figure
    handle = plot(t,matrizAceleracao(:,1),t,matrizAceleracao(:,2),t,matrizAceleracao(:,3));
    set(handle,'LineWidth',5);
    legend('x','y','z');
    title('Aceleração da Ponta da Ferramenta no referencial do Plano.');
    ylabel('Aceleração (metros/s²)');
    xlabel('Tempo (segundos)');
end

