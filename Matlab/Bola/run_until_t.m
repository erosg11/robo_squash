function [ ball_position, speed ] = run_until_t( ball_position, speed, g, limits, D, mi, m_ball, regeneration_parede, t )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    t0 = 0;
    ball_position_k = ball_position;
    speed_k = speed;
    while t0 < t
        ball_position = ball_position_k;
        speed = speed_k;
        [ball_position_k, speed_k, axis, tp] = run_until_colision(ball_position, speed, g, limits, D, mi, m_ball)
        speed_k = do_colision(speed_k, axis, regeneration_parede);
        t0 = t0 + tp;
    end
    
    t0 = t0 - tp;
    [ ball_position, speed ] = run_until(ball_position, speed, g, t - t0, D, mi, m_ball);

end

