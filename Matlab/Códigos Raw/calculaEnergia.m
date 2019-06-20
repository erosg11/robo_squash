function energiaTotal = calculaEnergia(m, dPg, II, Pg, g)
    % Calcula energia cinetica - potencial
    energiaCinetica = 0.5*m*(dPg(1:3)')*dPg(1:3) + 0.5*(dPg(4:6)')*(II*dPg(4:6));
    energiaPotencial = -m*g'*Pg(1:3);
    energiaTotal = energiaCinetica - energiaPotencial;
end