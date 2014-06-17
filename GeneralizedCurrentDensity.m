function [J] = GeneralizedCurrentDensity(U0, dU, d)
% J  - плотность тока, А/м^2
% U0 - работа выхода, эв
% dU - напряжение смещения, В
% d  - расстояние между электродами, нм

s = d*10; % перевод в ангстремы
s1 = 6/U0;
s2 = s*(1 - 46/(3*U0*s +20 - 2*dU*s))+s1;
ds = s2 - s1;

phi = U0 - (dU)/2/s*(s1+s2) - 5.75/(s2-s1)*log(s2*(s-s1)/s1/(s-s2));

J = 1/ds/ds*(phi*exp(-1.025*ds*(phi^0.5)) - (phi+dU)*exp(-1.025*ds*(phi+dU)^0.5));

