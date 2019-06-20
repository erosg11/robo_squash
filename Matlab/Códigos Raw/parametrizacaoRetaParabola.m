function [posicaoParametrizada,velocidadeParametrizada,aceleracaoParametrizada] = parametrizacaoRetaParabola(P1,P2,tempoTotalSegmento, passo)
    count = 0;
    V = (2*(P2-P1)/tempoTotalSegmento)*0.65; % 65% da velocidade máxima permitida para a parte linear
    tb = (V*tempoTotalSegmento + P1 - P2)/V;
    c2 = V/tb;
    
    % posicao inicial(P1) até a posição de fusao A
    for t=0:passo:tb
        count = count + 1;             
        posicaoParametrizada(count,:) = P1 + (c2*t^2)/2;
        velocidadeParametrizada(count,:) = c2*t;
        aceleracaoParametrizada(count,:) = c2;
        PA = posicaoParametrizada(count,:);
    end
    tbNum = t(length(t));
    %da posicao A até a posição de fusão B
    for t=tbNum+passo:passo:tempoTotalSegmento-tbNum
        count = count + 1;
        posicaoParametrizada(count,:) = PA + V*(t-tbNum);
        velocidadeParametrizada(count,:) = V*(1-(tb-tbNum)/tb);
        aceleracaoParametrizada(count,:) = 0;
    end
    lastTNum = t(length(t));
    %da posicao B até o ponto final(P2)
    for t=lastTNum+passo:passo:tempoTotalSegmento
        count = count + 1;
        posicaoParametrizada(count,:) = P2 - 0.5*c2*(tempoTotalSegmento-t)^2;
        velocidadeParametrizada(count,:) = c2*(tempoTotalSegmento-t)*(1-(tempoTotalSegmento-tbNum-lastTNum)/(tempoTotalSegmento-tbNum));
        aceleracaoParametrizada(count,:) = -c2;
    end
end
