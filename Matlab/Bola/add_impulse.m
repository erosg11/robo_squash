function [ v_ball ] = add_impulse( v_ball, v_raquete, D, f_raquete, regeneration, m_ball, K )
%add_impulse
% Calcula a velocidade da bola ap�s sofrer a��o de um impulso
% Par�metros:
%   v_ball: Velocidade da bola antes de receber o impulso
%   v_raquete: Velocidade da raquete antes de aplicar o impulso
%   D: Di�metro da bola
%   f_raquete: For�a da raquete
%   regeneration: Regenera��o da bola
%   m_ball: Massa da bola
%   K: K da bola
 
    h = ((5 * m_ball * norm(v_ball - v_raquete) ^ 2)/ ...
    (4 * (D/2) ^0.5 * K))^(2/5);

    tempo = 2.94 * (h / norm(v_ball - v_raquete));
    
    Dq_raquete = tempo * f_raquete;
    
    q_ball = m_ball * v_ball;
    
    q_final = Dq_raquete + q_ball;
    
    
    v_ball = (q_final/m_ball) * regeneration;

end

