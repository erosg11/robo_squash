function [posicaoParametrizada,velocidadeParametrizada,aceleracaoParametrizada] = parametrizacaoQuinta(P1,P2,V1,V2,A1,A2,tempoTotalSegmento, passo)
% Função que realiza a parametrização de quinta ordem    
count = 0;
    for t=0:passo:tempoTotalSegmento
        count = count + 1;
        k0 = P1;
        k1 = V1;
        k2 = A1/2;
        k3 = (20*P2-20*P1-(8*V2+12*V1)*tempoTotalSegmento-(3*A1-A2)*tempoTotalSegmento^2)/(2*tempoTotalSegmento^3);
        k4 = (30*P1-30*P2+(14*V2+16*V1)*tempoTotalSegmento+(3*A1-2*A2)*tempoTotalSegmento^2)/(2*tempoTotalSegmento^4);
        k5 = (12*P2-12*P1-(6*V2+6*V1)*tempoTotalSegmento-(A1-A2)*tempoTotalSegmento^2)/(2*tempoTotalSegmento^5);
        posicaoParametrizada(count,:) = k0 + k1*t + k2*t^2 + k3*t^3 + k4*t^4 + k5*t^5;
        velocidadeParametrizada(count,:) = k1 + 2*k2*t + 3*k3*t^2 + 4*k4*t^3 + 5*k5*t^4;
        aceleracaoParametrizada(count,:) = 2*k2 + 6*k3*t + 12*k4*t^2 + 20*k5*t^3;
    end
end

