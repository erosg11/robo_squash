function [ position, speed, axis, t ] = run_until_colision( position, speed, g, limits, d, n, m )
%run_until_colision
%Determina quando ocorrerá uma colisão com o chão, ou contra alguma parede
% Parâmetros:
% Position: Vetor com posições nos eixos x, y e z
% Speed: Velocidade nos mesmos eixos
% g: Aceleração da gravidade
% Limits: matriz com os limites nos eixos x e y, maior, menor
% d: Diâmetro da bola
% n: Viscosidade do ar
% m: Massa da bola

% Sabendo que a força de arrasto pode ser calculada como:
% m * (-s'') = 3 * pi * n * d * s'
% Calculamos o resultado da EDO
% E no caso do eixo z, nós temos além disso:
% m * (g - s'') = 3 * pi * n * d * s'

% Não temos uma forma intuitiva de calcular a fução inversa (t(s))
% Então somos obrigados a resolver de forma numérica usando a função solve

syms t
assume(t > 0)

if sign(speed(1)) == 1
    limit_x = limits(1,1);
else
    limit_x = limits(1,2);
end

x = (m*speed(1) + 3*pi*d*n*position(1))/(3*pi*d*n) - ...
    (m*speed(1)*exp(-(3*pi*d*n*t)/m))/(3*pi*d*n);

t_x = solve(x == limit_x, t);

if sign(speed(2)) == 1
    limit_y = limits(2,1);
else
    limit_y = limits(2,2);
end

y = (m*speed(2) + 3*pi*d*n*position(2))/(3*pi*d*n) - ...
    (m*speed(2)*exp(-(3*pi*d*n*t)/m))/(3*pi*d*n);

t_y = solve(y == limit_y, t);

z =  (3*pi*d*n*(m*speed(3) + 3*pi*d*n*position(3)) - ...
    (aceleration(3) - g)*m^2 + 3*pi*d*(aceleration(3) - g)*m*n*t)/ ...
    (9*pi^2*d^2*n^2) + (exp(-(3*pi*d*n*t)/m)* ...
    ((aceleration(3) -g)*m^2 - 3*pi*d*n*speed(3)*m))/(9*pi^2*d^2*n^2);

t_z = solve(z == 0, t);

size_x = length(t_x);
size_y = length(t_y);
size_z = length(t_z);

axis_array = [
    ones(size_x, 1);
    ones(size_y, 1) * 2;
    ones(size_z, 1) * 3;
    ];

[t, axis] = min(double([t_x; t_y; t_z]));

axis = axis_array(axis);

[position, speed] = run_until(position, speed, g, t, d, n, m);

end

