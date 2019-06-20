function [ speed ] = do_colision( speed, axis, regeration )
%do_colision
%   Calcula a velocidade da bolinha ap�s a colis�o considerando a
%   regenera��o
%   Par�metros:
%   speed: Velocidade da bolinha antes da colis�o
%   axis: Eixo em que ocorre a colis�o
%   regenera��o: Taxa de regenera��o da bolinha
%   Retorna:
%   speed: Velocidade ap�s a colis�o


speed(axis) = - regeration * speed(axis);

end

