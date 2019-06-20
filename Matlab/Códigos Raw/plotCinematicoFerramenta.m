function plotCinematicoFerramenta(matrizPosicao,matrizVelocidade,matrizAceleracao,tempoTotal)
% Fun��o que plota os gr�ficos da cinem�tica da ferramenta
    passo = (tempoTotal)/length(matrizPosicao);
    t = 0+passo:passo:tempoTotal;
    
    figure
    handle = plot(t,matrizPosicao(:,1),t,matrizPosicao(:,2),t,matrizPosicao(:,3));
    set(handle,'LineWidth',5);
    legend('x','y','z');
    title('Posi��o da Ponta da Ferramenta no referencial do Plano.');
    ylabel('Posi��o (metros)');
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
    title('Acelera��o da Ponta da Ferramenta no referencial do Plano.');
    ylabel('Acelera��o (metros/s�)');
    xlabel('Tempo (segundos)');
end

