function [ v_ball ] = add_momentum( m_ball, v_ball, m_raquete, v_raquete, regeneration )
%add_momentum
%   Fun��o que calcula a velocidade da bolinha ap�s ser adicionado momento
%   pela a��o externa da raquete
%   Par�metros:
%   m_ball: Massa da bolinha
%   v_ball: Velocidade da bolinha antes da raquetada
%   m_raquete: Massa da raquete
%   v_raquete: Velocidade da raquete antes da colis�o
%   regeneration: Regenera��o da colis�o entre a bolinha e a raquete
%   Retorna:
%   v_ball: Velocidade da bolinha ap�s a colis�o

v_ball = regeneration * (m_raquete .* v_raquete ./ m_ball + v_ball);

end

