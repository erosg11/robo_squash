function plotTrajetoria(P80)
% Fun��o que plota a trajet�ria
    figure(1)
    hold on
    grid on;
    xlabel('x(metros)');
    ylabel('y(metros)');
    zlabel('z(metros)');
    title('Plano Inclinado');
    xlim([0 2]);
    ylim([0 2]);
    zlim([0 2]);
    view(-23,17);
    dotPlot(P80);
    hold off
end

