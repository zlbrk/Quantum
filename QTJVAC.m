clear all;
close all;
clc;

%% Параметры моделирования и диапазоны

U0 = 5.32; % высота барьера, эВ (работа выхода электрона из Вольфрама = 4,5 эВ)
k = 3; % порядок дискретизации потенциального рельефа, nil

% Диапазон изменения напряжений для построения ВАХ
dUmin = 0.0; % минимальное напряжение смещения, В
dUmax = 1.6; % максимальное напряжение смещения, В (Напряженность поля порядка 30 КВ/см)
dUpts = 10; % точек ВАХ
dU = linspace(dUmin, dUmax, dUpts); % сетка по напряжениям

% Диапазон изменения расстояний между электродами
dmin = 2.8; % минимальное расстояние между электродами, нм
dmax = 2.8; % максимальное расстояние между электродами, нм
dpts = 1; % число исследуемых конфигураций
d = linspace(dmin, dmax, dpts); % сетка по расстояниям между электродами

S = 0.6*1e-6*1*1e-6; % площадь взаимного перекрытия плоских электродов
%% Построение вольт-амперных характеристик двухэлектродной структуры

J1 = zeros(dpts, dUpts);
J2 = zeros(dpts, dUpts);
J3 = zeros(dpts, dUpts);
for i = 1: dpts % строки
    for j = 1: dUpts % столбцы
        
        % Вывод параметров решения
        clc;
        
        format_wf = 'Работа выхода: U0=%0.5g\n';
        out_wf = sprintf(format_wf, U0);
        disp(out_wf);
        format_bv = 'Напряжение смещения: dU=%0.5g\n';
        out_bv = sprintf(format_bv, dU(j));
        disp(out_bv);
        format_d = 'Расстояние между электродами: d=%0.5g\n';
        out_d = sprintf(format_d, d(i));
        disp(out_d);
        format_k = 'Параметр дискретизации: k=%0.5g\n';
        out_k = sprintf(format_k, k);
        disp(out_k);
        
        if j>1
            formatJ2 = 'Плотность тока (модельная): %0.5g А/м^2';
            outJ2 = sprintf(formatJ2, J2(i, j-1));
            disp(outJ2);
            
            formatJ3 = 'Плотность тока (аналитическая): %0.5g А/м^2';
            outJ3 = sprintf(formatJ3, J3(i, j-1));
            disp(outJ3);
        end
        
%         % Генерация сеток и рельефа для прямоугольного барьера
%         [ dx1, xc1 ] = MSMG( d(i), k );
%         [ U1 ] = PWBR( 0.5*U0, dU(j), d(i), xc1 );
%         % Расчет плотности тока для прямоугольного барьера
%         J1(i, j) = ECDQTJ(dU(j), U1, dx1); % матрица заполняется по строкам
%         formatJ1 = 'Плотность тока (прямоугольная): %0.5g А/м^2\n';
%         outJ1 = sprintf(formatJ1, J1(i, j));
%         disp(outJ1);

        % Генерация сеток и рельефа для модельного барьера
        [ dx2, xc2 ] = MSMG( 7*d(i), k+4 );
        [ U2 ] = SPRG( U0, dU(j), d(i), xc2 );
        [ h1 ] = PRVF( xc2, U2 );
        
        % Расчет плотности тока для модельного барьера
        J2(i, j) = ECDQTJ(dU(j), U2, dx2); % матрица заполняется по строкам
        
        % Расчет плотности тока по аналитическому выражению
        J3(i, j) = GeneralizedCurrentDensity(U0, dU(j), d(i)); % матрица заполняется по строкам
        
    end
end

% Для навешивания фонаря
scale=J2(floor(length(J2)/2))/J3(floor(length(J3)/2));

figure
semilogy(dU, J3.*1e-4*scale, dU, J2.*1e-4,'rs');
xlabel('dU, V','FontSize', 18);
ylabel('J, A/cm^2','FontSize', 18);
title('VAC','FontSize', 18);
grid on;
set(gca,'FontSize', 18);

% figure
% semilogy(dU, J3.*S*scale, dU, J2.*S,'rs');
% xlabel('dU, V','FontSize', 18);
% ylabel('I, A','FontSize', 18);
% title('VAC','FontSize', 18);
% grid on;
% set(gca,'FontSize', 18);