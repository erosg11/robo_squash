function dotPlot(matriz)
    % Faz o Plot dos pontos de uma matriz
    for i = 1:length(matriz)
        if matriz(i,4) == 0
            % Pontos do plano
            h = scatter3(matriz(i,1),matriz(i,2),matriz(i,3),'filled','blue');
            h.SizeData = 100;
        else
            % Pontos fora do plano
            h = scatter3(matriz(i,1),matriz(i,2),matriz(i,3),'filled','red');
            h.SizeData = 30;
        end
    end
end

