function [posicaoParametrizada,velocidadeParametrizada,aceleracaoParametrizada] = parametrizacaoCubica(P1,P2,tempoTotalSegmento, passo)
% Função que realiza a parametrização Cúbica   
count = 0;
    for t=0:passo:tempoTotalSegmento
        count = count + 1;
        k0 = P1;
        k1 = 0;
        k2 = 3*(P2-P1)/tempoTotalSegmento^2;
        k3 = -2*(P2-P1)/tempoTotalSegmento^3;
        posicaoParametrizada(count,:) = k0 + k1*t + k2*t^2 + k3*t^3;
        velocidadeParametrizada(count,:) = k1 + 2*k2*t + 3*k3*t^2;
        aceleracaoParametrizada(count,:) = 2*k2 + 6*k3*t;
    end
end

