function [ v_ball ] = add_momentum( m_ball, v_ball, m_raquete, v_raquete, regeneration )
%add_momentum
%   Função que calcula a velocidade da bolinha após ser adicionado momento
%   pela ação externa da raquete
%   Parâmetros:
%   m_ball: Massa da bolinha
%   v_ball: Velocidade da bolinha antes da raquetada
%   m_raquete: Massa da raquete
%   v_raquete: Velocidade da raquete antes da colisão
%   regeneration: Regeneração da colisão entre a bolinha e a raquete
%   Retorna:
%   v_ball: Velocidade da bolinha após a colisão

v_ball = regeneration * (m_raquete .* v_raquete ./ m_ball + v_ball);

end

