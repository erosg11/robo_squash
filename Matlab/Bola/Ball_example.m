% Posição da bola no eixo x, y e z
ball_position = [1;-1.1;1.5];

% Limites da sala no eixo x e y
limits = [2,-2;2,-2];

% Velocidade da bolinha nos 3 eixos
speed = [-5;5;7];

% Gravidade
g = -9.81;

% Massa da bola
m_ball = 57*10^-3;

% Massa da raquete
m_raquete = 1;

% Velocidade da raquete ao bater na bola
v_raquete = [
    1;
    0;
    1.5;
    ];

% Regeneração da bola quando bate na raquete
regeneration_raquete = 0.8;

% Regenaração da bola quando bate na parede
regeneration_parede = 0.85;

% Viscosidade do ar 
mi = 17.2 * 10 ^ -6;

% Diâmetro da bola
D = 6.5 * 10 ^ -2;

disp('Run until colision')

% Axis é o eixo que ocorre a colisão
[ball_position, speed, axis, t] = run_until_colision(ball_position, speed, g, limits, D, mi, m_ball)

disp('Doing colision')
speed = do_colision(speed, axis, regeneration_parede)

disp('Run until colision')
[ball_position, speed, axis, t] = run_until_colision(ball_position, speed, g, limits, D, mi, m_ball)

disp('Add momentum')
speed = add_momentum(m_ball, speed, m_raquete, v_raquete, regeneration_raquete)
