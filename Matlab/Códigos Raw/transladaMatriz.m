function Matriz = transladaMatriz(vetorXYZ)
    % Função que translada a matriz
    Matriz = [1 0 0 0; 0 1 0 0; 0 0 1 0; vetorXYZ 1]';
end

