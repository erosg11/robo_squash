function plotDinamicoJuntas(torque,tempoTotal)
% Função que plota os gráficos da Dinâmica das juntas
    passo = (tempoTotal)/length(torque);
    t = 0+passo:passo:tempoTotal;
    
    figure
    handle = plot(t,torque(:,1),t,torque(:,2),t,torque(:,3),t,torque(:,4),t,torque(:,5),t,torque(:,6));
    set(handle,'LineWidth',5);
    legend('T1','T2','T3','T4','T5','T6');
    title('Torque nas juntas.');
    ylabel('Torque (N.m)');
    xlabel('Tempo (segundos)');
end

