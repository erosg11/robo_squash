function [ K ] = calc_k( poison, young )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

K = (4/3) * ((1 - poison ^2)/young) ^ -1;
end

