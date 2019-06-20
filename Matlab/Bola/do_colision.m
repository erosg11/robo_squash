function [ speed ] = do_colision( speed, axis, regeration )
%do_colision
%   Calcula a velocidade da bolinha após a colisão considerando a
%   regeneração
%   Parâmetros:
%   speed: Velocidade da bolinha antes da colisão
%   axis: Eixo em que ocorre a colisão
%   regeneração: Taxa de regeneração da bolinha
%   Retorna:
%   speed: Velocidade após a colisão


speed(axis) = - regeration * speed(axis);

end

