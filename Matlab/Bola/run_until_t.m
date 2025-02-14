function [ ball_position, speed ] = run_until_t( ball_position, speed, g, limits, D, mi, m_ball, regeneration_parede, t )
%run_until_t
% Fun��o que calcula a posi��o da bola no tempo t, computando as colis�es
% com a parede
% Par�metros:
%   ball_position: Posi��o da bola nos 3 eixos
%   speed: Velocidade da bola nos 3 eixos
%   g: Valor da gravidade
%   limits: Tamanho da quadra
%   D: Di�metro da bola
%   mi: Viscosidade do ar
%   m_ball: Massa da bola
%   regeneration_parede: Fator de regenera��o da bola com a parede
%   t: Tempo que voc� deseja saber a posi��o da bola
%
% Retorna:
%   ball_positions: Posi��o da bola
%   speed: Velocidade da bola

    t0 = 0;
    ball_position_k = ball_position;
    speed_k = speed;
    while t0 < t
        ball_position = ball_position_k;
        speed = speed_k;
        [ball_position_k, speed_k, axis, tp] = run_until_colision(ball_position, speed, g, limits, D, mi, m_ball);
        speed_k = do_colision(speed_k, axis, regeneration_parede);
        t0 = t0 + tp;
    end
    
    t0 = t0 - tp;
    [ ball_position, speed ] = run_until(ball_position, speed, g, t - t0, D, mi, m_ball);

end

