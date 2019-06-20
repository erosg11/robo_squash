function Matriz = rotacionaMatriz(eixoRotacao, q)
%função que rotaciona nos respectivos eixos
switch eixoRotacao
    case 'x'
        Matriz = [1 0 0 0; 0 cos(q) -sin(q) 0; 0 sin(q) cos(q) 0; 0 0 0 1];
    case 'y'
        Matriz = [cos(q) 0 sin(q) 0; 0 1 0 0; -sin(q) 0 cos(q) 0; 0 0 0 1];
    case 'z'
        Matriz = [cos(q) -sin(q) 0 0; sin(q) cos(q) 0 0; 0 0 1 0; 0 0 0 1];
end