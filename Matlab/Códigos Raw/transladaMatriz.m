function Matriz = transladaMatriz(vetorXYZ)
    % Fun��o que translada a matriz
    Matriz = [1 0 0 0; 0 1 0 0; 0 0 1 0; vetorXYZ 1]';
end

