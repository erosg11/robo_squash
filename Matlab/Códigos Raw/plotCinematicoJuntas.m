function plotCinematicoJuntas(matrizPosicaoJuntas,matrizVelocidadeJuntas,matrizAceleracaoJuntas,tempoTotal)
% Função que plota os gráficos da Cinemática das juntas
    passo = (tempoTotal)/length(matrizPosicaoJuntas);
    t = 0+passo:passo:tempoTotal;
    
    figure
    handle = plot(t,matrizPosicaoJuntas(:,1),t,matrizPosicaoJuntas(:,2),t,matrizPosicaoJuntas(:,3),t,matrizPosicaoJuntas(:,4),t,matrizPosicaoJuntas(:,5),t,matrizPosicaoJuntas(:,6));
    set(handle,'LineWidth',5);
    legend('q1','q2','q3','q4','q5','q6');
    title('Posições das juntas.');
    ylabel('Posição (º)');
    xlabel('Tempo (segundos)');
    
    figure
    handle = plot(t,matrizVelocidadeJuntas(:,1),t,matrizVelocidadeJuntas(:,2),t,matrizVelocidadeJuntas(:,3),t,matrizVelocidadeJuntas(:,4),t,matrizVelocidadeJuntas(:,5),t,matrizVelocidadeJuntas(:,6));
    set(handle,'LineWidth',5);
    legend('q1','q2','q3','q4','q5','q6');
    title('Velocidades Angulares das juntas.');
    ylabel('Velocidade Angular (º/s)');
    xlabel('Tempo (segundos)');

    figure
    handle = plot(t,matrizAceleracaoJuntas(:,1),t,matrizAceleracaoJuntas(:,2),t,matrizAceleracaoJuntas(:,3),t,matrizAceleracaoJuntas(:,4),t,matrizAceleracaoJuntas(:,5),t,matrizAceleracaoJuntas(:,6));
    set(handle,'LineWidth',5);
    legend('q1','q2','q3','q4','q5','q6');
    title('Acelerações Angulares das juntas.');
    ylabel('Aceleração Angular (º/s²)');
    xlabel('Tempo (segundos)');
end

