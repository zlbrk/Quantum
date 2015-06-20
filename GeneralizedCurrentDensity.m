%% John G. Simmons' Generalized Formula for Electron Quantum Tunneling

% Notation and used physical quantities
% J  - current density,A/m^2
% U0 - work function, eV
% dU - bias voltage, V
% d  - interelectrode gap, nm
% el - electron charge, C
% kb - Boltzmann's constant, J/K
% T  - temperature, K
% hbar - reduced Planck's constant, J-s
% m  - electron mass, kg

% Initialization
clear all;
close all;
clc;

%% Physical constants and parameters

el = 1.6e-19; % заряд электрона, Кл
kb = 1.38e-23; % постоянная Больцмана, Дж/К

eps0 = 8.85e-12; % диэлектрическая проницаемость вакуума, Ф/м

Temp = 300; % температура, К

phit = kb*Temp/el; % температурный коэффициент, эВ

h = 6.62e-34; % постоянная Планка, Дж*с
hbar = h/2/pi; % приведенная постоянная Планка, Дж*с

m = 9.11e-31; % масса электрона, кг

U0 = 5.3; % работа выхода из платины, эв

dU = 1.6; % напряжение смещения, В

d = 2.8; % расстояние между электродами, нм
d = d*1e-9; % перевод в метры
%% Energy grid

% Энергия Ферми принимается за начало отсчета.
% Fermi energy is set to be origin

% Определение диапазонов интегрирования распределений
Emin = -0.5*U0; % нижняя граница диапазона энергий, эВ
Emax = +0.5*U0; % верхняя граница диапазона энергий, эВ
Epts =  1001; % количество значений энергии в диапазоне [Emin:Emax], шт

% Построение сеток
E = linspace(Emin, Emax, Epts); % опорная сетка по энергиям, эВ
dE = diff(E);  % интервалы опорной сетки, эВ

%% Fermi-Dirac Distribution
% Fermi energy is assumed to be zero
% Platinum's Melting Temperature 1768 in Degrees Celsius or 2041 in Degrees Kelvin 
f = @(E) 1./(1+exp(el*E/kb/Temp));

plot(E, f(E), E, f(E+dU))%, E, f(E)-f(E+dU));
grid on;
xlim([min(E) max(E)])
xlabel('Energy, eV')
ylabel('Probability, nil')
title('Fermi-Dirac Distribution')

%% WKB Tunneling Probability Function

beta = 23/24; % correction factor, nil
phim = 3.1; % potential barrier mean height, eV

A = (4*pi*beta*d/h)*(2*m)^0.5; % 
D = @(Ex) exp(-A*el*(phim - Ex).^0.5);
% figure
% plot(E, D(E));
% grid on;
% xlim([min(E) max(E)])
% xlabel('Energy, eV')
% ylabel('WKB Probability of Tunneling, nil')

%% Current-Voltage characteristic

J0 = el/2/pi/h/(beta*d)^2;
%J = @(dU) J0*((el*phim)*exp(-A*(el*phim)^0.5) - el*(phim + dU).*exp(-A*(el*(phim + dU)).^0.5));

dUmin = 0;
dUmax = 1.6;
dpts = 100;
dstp = (dUmax-dUmin)/(dpts-1);
dU = dUmin:dstp:dUmax;

J_G = zeros(size(dU));
for i = 1: length(dU)
    J_G(i) = J0*((el*phim)*exp(-A*(el*phim)^0.5) - el*(phim + dU(i))*exp(-A*(el*(phim + dU(i)))^0.5));
end

%% Equations Expressed in Practical Units

% средняя высота барьера задается в электрон-вольтах
% ширина барьера задается в ангстремах
% плотность тока рассчитывается в Амперах, деленных на квадратный сантиметр

d=d/1e-10; % перевод ширины барьера в ангстремы

d=0.43*d; % попытка промоделировать s 0.42

J_Gpr = zeros(size(dU)); % обобщенный барьер
for i = 1: length(dU)
    J_Gpr(i) = (6.2*1e10/(beta*d)^2)*(phim*exp(-1.025*beta*d*phim^0.5) - (phim + dU(i))*exp(-1.025*beta*d*(phim + dU(i))^0.5));
end

J_Rpr = zeros(size(dU)); % прямоугольный
F = zeros(size(dU));
for i = 1: length(dU)
    if dU(i)<U0
        J_Rpr(i) = (6.2*1e10/d^2)*((U0 - dU(i)/2)*exp(-1.025*d*(U0 - dU(i)/2)^0.5)...
            - (U0 + dU(i)/2)*exp(-1.025*d*(U0 + dU(i)/2)^0.5)); % Eq (46)
    elseif dU(i)>U0
        F(i) = dU(i)/d;
        J_Rpr(i) = 3.38*1e10*(F(i)^2/U0)*(exp(-0.689/F(i)*U0^1.5) ...
            - (1 + 2*dU(i)/U0)*exp(-0.689/F(i)*(1 + 2*dU(i)/U0)^0.5*U0^1.5)); % Eq (47)
    end
end

J_RIpr = zeros(size(dU)); % прямоугольный с изображением
K = 1;
for i = 1: length(dU)
    if dU(i)<U0
        s1 = 6/K/U0;
        s2 = d*(1-46/(3*U0*K*d +20 -2*dU(i)*K*d)) + 6/K/U0;
        phii = U0 - (dU(i)/2/d)*(s1+s2) - (5.75/K/(s2-s1))*log(s2*(d-s1)/s1/(d-s2));
        J_RIpr(i) = (6.2*1e10/d^2)*(phii*exp(-1.025*d*phii^0.5)...
            - (phii + dU(i))*exp(-1.025*d*(phii +dU(i))^0.5)); % Eq (50)
    elseif dU(i)>U0
        s1 = 6/K/U0;
        s2 = (U0*K*d - 28)/K/dU(i);
        phii = U0 - (dU(i)/2/d)*(s1+s2) - (5.75/K/(s2-s1))*log(s2*(d-s1)/s1/(d-s2));
        J_RIpr(i) = (6.2*1e10/d^2)*(phii*exp(-1.025*d*phii^0.5)...
            - (phii + dU(i))*exp(-1.025*d*(phii +dU(i))^0.5)); % Eq (50)
    end
end

%% Параметры структуры Шашкина-Вопилкина
a = 3*200*1e-9; % поперечная протяженность зазора, м
b = 1e-6; % глубина зазора, м
S = a*b; % площадь перекрытия электродов, м^2

%% Сравнение вольтамперных характеристик для различных случаев

figure % Обобщенный барьер
semilogy(dU, J_G./1e4, dU, J_Gpr)
xlabel('dU, V');
ylabel('J, A/cm^2');
title('Generalized');
grid on;

figure % Прямоугольный без изображения
semilogy(dU, J_G./1e4, dU, J_Rpr)
xlabel('dU, V');
ylabel('J, A/cm^2');
title('Rectangular without image');
grid on;

figure % Прямоугольный с изображением
semilogy(dU, J_Rpr.*1e4, dU, J_RIpr.*1e4)
xlabel('dU, V');
ylabel('J, A/m^2');
title('Rectangular with image');
grid on;

figure % Прямоугольный с изображением (Ток)
semilogy(dU, J_RIpr.*(1e4*S))
xlabel('dU, V');
ylabel('I, A');
grid on;