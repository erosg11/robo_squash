function [ position, speed ] = run_until( position, speed, g, t, d, n, m )
%run_until
%   Fun��o que calcula a posi��o e velocidade da bolinha no tempo t
%   Par�metros:
%   position: Posi��o atual da bolinha
%   speed: Velocidade atual da bolinha
%   g: Gravidade
%   t: Tempo desejado
%   d: Di�metro da bolinha
%   n: Viscosidade do ar
%   m: Massa da bolinha
%   Retorna:
%   position: Posi��o da bolinha ap�s o tempo t
%   speed: Velocidade da bolinha ap�s o tempo t

position = [
    (m*speed(1) + 3*pi*d*n*position(1))/(3*pi*d*n) - ...
    (m*speed(1)*exp(-(3*pi*d*n*t)/m))/(3*pi*d*n);
    (m*speed(2) + 3*pi*d*n*position(2))/(3*pi*d*n) - ...
    (m*speed(2)*exp(-(3*pi*d*n*t)/m))/(3*pi*d*n);
    (g*m^2 + 3*pi*d*n*(m*speed(3) + 3*pi*d*n*position(3)) - ...
    3*pi*d*g*m*n*t)/(9*pi^2*d^2*n^2) - (exp(-(3*pi*d*n*t)/m)* ...
    (g*m^2 + 3*pi*d*n*speed(3)*m))/(9*pi^2*d^2*n^2);
    ];

speed(3) = (exp(-(3*pi*d*n*t)/m)*(g*m^2 + 3*pi*d*n*speed(3)*m))/ ...
    (3*pi*d*m*n) - (g*m)/(3*pi*d*n);

end

