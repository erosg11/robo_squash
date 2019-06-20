function plotCinematicoJuntas(matrizPosicaoJuntas,matrizVelocidadeJuntas,matrizAceleracaoJuntas,tempoTotal)
% Fun��o que plota os gr�ficos da Cinem�tica das juntas
    passo = (tempoTotal)/length(matrizPosicaoJuntas);
    t = 0+passo:passo:tempoTotal;
    
    figure
    handle = plot(t,matrizPosicaoJuntas(:,1),t,matrizPosicaoJuntas(:,2),t,matrizPosicaoJuntas(:,3),t,matrizPosicaoJuntas(:,4),t,matrizPosicaoJuntas(:,5),t,matrizPosicaoJuntas(:,6));
    set(handle,'LineWidth',5);
    legend('q1','q2','q3','q4','q5','q6');
    title('Posi��es das juntas.');
    ylabel('Posi��o (�)');
    xlabel('Tempo (segundos)');
    
    figure
    handle = plot(t,matrizVelocidadeJuntas(:,1),t,matrizVelocidadeJuntas(:,2),t,matrizVelocidadeJuntas(:,3),t,matrizVelocidadeJuntas(:,4),t,matrizVelocidadeJuntas(:,5),t,matrizVelocidadeJuntas(:,6));
    set(handle,'LineWidth',5);
    legend('q1','q2','q3','q4','q5','q6');
    title('Velocidades Angulares das juntas.');
    ylabel('Velocidade Angular (�/s)');
    xlabel('Tempo (segundos)');

    figure
    handle = plot(t,matrizAceleracaoJuntas(:,1),t,matrizAceleracaoJuntas(:,2),t,matrizAceleracaoJuntas(:,3),t,matrizAceleracaoJuntas(:,4),t,matrizAceleracaoJuntas(:,5),t,matrizAceleracaoJuntas(:,6));
    set(handle,'LineWidth',5);
    legend('q1','q2','q3','q4','q5','q6');
    title('Acelera��es Angulares das juntas.');
    ylabel('Acelera��o Angular (�/s�)');
    xlabel('Tempo (segundos)');
end

