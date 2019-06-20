function [ K ] = calc_k( poison, young )
%calc_k
% Calcula o k da bola com base do poison e young da bola

K = (4/3) * ((1 - poison ^2)/young) ^ -1;
end

