% Robô KR QUANTEC nano F exclusive %
%----Parâmetros Iniciais----%
toRad = pi/180;
toAngule = 1/toRad;

l1 = 0.1703;
e1 = 0.025; %excentricidade 1
l2 = 0.455;
l3 = 0.420;
e2 = 0.025; %excentricidade 2
l4 = 0.090;

lc_raquete = [l4+0.49563 0 0]; %distancia até o centro da elipse da raquete
raio_maximo_menor = 0.14268; % raio menor da elipse
raio_maximo_maior = 0.20162; % raio maior da elipse

%input do usuário
x_raquete = 0.1*cos(90*toRad);
y_raquete = 0.2*sin(90*toRad);
tipoDeparametrizacao = 'cubica';%Seleciona o tipo de parametrização desejada, 'cubica', 'quinta_ordem' ou 'reta_parabola'

verificaParametros(x_raquete, y_raquete, raio_maximo_menor, raio_maximo_maior);

qRange = [-80 260; -190 45; -120 156; -185 185; -120 120; -350 350]*toRad; %range dado pelo fabricante(todos estão normalizados)
moduloAceleracao = 0.1; % modulo da aceleração p/ quinta ordem
tempoTotalSegmento = 3; % tempo em segundos
qtdSegmentos = 1;
tempoPlot = tempoTotalSegmento*qtdSegmentos;
taxaAmostragem = 0.5; %taxa de amostragem
fatorDePrecisao = 0.001; %Precisao do movimento em metros
angulos(1,:) = [0 0 0 0 0 0]*toRad; % posicao inicial do braço robótico
g0 = [0 0 -9.80665]';
mi = blkdiag(0.57,0.57,0.57,0.57,0.57,0.57); % Constante de atrito cinético do aço

% Parametros relacionados ao centro de massa do braço robótico
matrizMassaBracos = [43.04158 69.62141 28.62832 17.66044 5.49770 0.54737 0.78919]';

Pg10 = [0.00051 0.00790 0.10391 1.00000]';
II10 = [0.79642	0.00198	0.00583; 0.00198 0.97971 0.07104; 0.00583 0.07104 0.39072];

Pg21 = [0.21034	0.00132	0.00776 1.00000]';
II21 = [0.38404	0.03919	0.12174; 0.03919 5.17715 -0.00001; 0.12174 -0.00001	5.37011];

Pg32 = [0.00274 0.05248 0.01113 1.00000]';
II32 = [0.28877	0.00105	0.00046; 0.00105 0.07825 0.03919; 0.00046 0.03919 0.27815];

Pg43 = [0.09364 0.00237 -0.00007 1.00000]';
II43 = [0.04790 0.00926	-0.00029; 0.00926 0.23295 -0.00003; -0.00029 -0.00003 0.25373];

Pg54 = [0.01145 0.00142 0.00000 1.00000]';
II54 = [0.00617	0.00002	0.00000; 0.00002 0.00862 0.00000; 0.00000 0.00000 0.00974];

Pg65 = [0.00527 0.00000 -0.00001 1.00000]';
II65 = [0.00039	0.00000	0.00000; 0.00000 0.00022 0.00000; 0.00000 0.00000 0.00022];

Pg76 = [0.34284 0.00000 0.00000 1.00000]';
II76 = [0.00525	0.00000	0.00000; 0.00000 0.12905 0.00000; 0.00000 0.00000 0.13422];

II = ['II10', 'II20', 'II30', 'II40', 'II50', 'II60', 'II70'];

% Regeneração da bola quando bate na raquete
regeneration_raquete = 0.8;

% Regenaração da bola quando bate na parede
regeneration_parede = 0.85;

% Viscosidade do ar 
ar_mi = 17.2 * 10 ^ -6;

% Poison da bola
poison = 0.47;

% Young
young = 6.5 * 10^6;

k_ball = calc_k(poison, young);

% Posição alvo da bola no primeiro lançamento
ball_target = [0; 0; 0];