clear all;
close all;
clc;

%% Параметры моделирования и диапазоны

U0 = 4.5; % высота барьера, эВ (работа выхода электрона из Вольфрама = 4,5 эВ)
k = 6; % порядок дискретизации потенциального рельефа, nil



% Из ANSYS'а
dX = 0.9919; % отклик на ускорение по оси X
dY = 0.8983; % отклик на ускорение по оси Y
dZ = 7.7386; % отклик на ускорение по оси Z

%dZ = 1000; 

Tunneling = false; % туннельный режим

if (Tunneling)
% Диапазон изменения напряжений для построения ВАХ в туннельном режиме
   
    dUmin = 99e-3; % минимальное напряжение смещения, В
    dUmax = 101e-3; % максимальное напряжение смещения, В (Напряженность поля порядка 30 КВ/см)
    dUpts = 3; % точек ВАХ
    dU = linspace(dUmin, dUmax, dUpts); % сетка по напряжениям
    
    % Диапазон изменения расстояний между электродами
    dmin = 3; % минимальное расстояние между электродами, нм
    dmax = 3; % максимальное расстояние между электродами, нм
    dpts = 1; % число исследуемых конфигураций
    d = linspace(dmin, dmax, dpts); % сетка по расстояниям между электродами
    
    % Конструкция
    L1 = 5e-9; % ширина электродов
    Thickness = 5e-9; % толщина электродов
    NumberOfTips = 1; % количество типчиков
    
    %S = 202*1e-6*2*1e-6; % площадь взаимного перекрытия плоских электродов (толщина 2мкм)
    S = L1*Thickness*NumberOfTips; % площадь взаимного перекрытия плоских электродов
else
    % Диапазон изменения напряжений для построения ВАХ в автоэмиссионном режиме
    dUmin = 9.0; % минимальное напряжение смещения, В
    dUmax = 9.0; % максимальное напряжение смещения, В (Напряженность поля порядка 30 КВ/см)
    dUpts = 3; % точек ВАХ
    dU = linspace(dUmin, dUmax, dUpts); % сетка по напряжениям
    
    % Диапазон изменения расстояний между электродами
    dmin = 4; % минимальное расстояние между электродами, нм
    dmax = 4; % максимальное расстояние между электродами, нм
    dpts = 1; % число исследуемых конфигураций
    d = linspace(dmin, dmax, dpts); % сетка по расстояниям между электродами
    
    % Конструкция
    L1 = 5e-9; % ширина электродов
    Thickness = 5e-9; % толщина электродов
    NumberOfTips = 1; % количество типчиков
    
    %S = 202*1e-6*2*1e-6; % площадь взаимного перекрытия плоских электродов (толщина 2мкм)
    S = L1*Thickness*NumberOfTips; % площадь взаимного перекрытия плоских электродов
end



% должна быть сотня пикоампер
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
            formatJ2 = 'Плотность тока (модельная): %0.5g А/см^2';
            outJ2 = sprintf(formatJ2, J2(i, j-1)/1e4);
            disp(outJ2);
            
            formatJ3 = 'Плотность тока (аналитическая): %0.5g А/см^2';
            outJ3 = sprintf(formatJ3, J3(i, j-1)/1e4);
            disp(outJ3);
        end
        pause
        
%         % Генерация сеток и рельефа для прямоугольного барьера
%         [ dx1, xc1 ] = MSMG( d(i), k );
%         [ U1 ] = PWBR( 0.5*U0, dU(j), d(i), xc1 );
%         % Расчет плотности тока для прямоугольного барьера
%         J1(i, j) = ECDQTJ(dU(j), U1, dx1); % матрица заполняется по строкам
%         formatJ1 = 'Плотность тока (прямоугольная): %0.5g А/м^2\n';
%         outJ1 = sprintf(formatJ1, J1(i, j));
%         disp(outJ1);

        % Генерация сеток и рельефа для модельного барьера
        [ dx2, xc2 ] = MSMG( 1.2*d(i), k );
        [ U2 ] = SPRG( U0, dU(j), d(i), xc2 );
        %[ h1 ] = PRVF( xc2, U2 );
        
        % Расчет плотности тока для модельного барьера
        %J2(i, j) = ECDQTJ(dU(j), U2, dx2); % матрица заполняется по строкам
        
        % Расчет плотности тока по аналитическому выражению
        J3(i, j) = GF(U0, dU(j), d(i)); % матрица заполняется по строкам
        
    end
end

%% Визуализация

% figure 
% semilogy(dU, J2.*1e-4,'-rs','LineWidth',2);
% xlabel('dU, V','FontSize', 18);
% ylabel('J, A/cm^2','FontSize', 18);
% title('VAC','FontSize', 18);
% grid on;
% set(gca,'FontSize', 18);

% figure
% semilogy(dU, J2.*S,'-s','LineWidth',2);
% xlim([(dUmin*0.99) (dUmax*1.01)]);
% xlabel('dU, V','FontSize', 18);
% ylabel('I, A','FontSize', 18);
% title('VAC','FontSize', 18);
% grid on;
% set(gca,'FontSize', 18);

figure
semilogy(dU, J3.*S,'-s','LineWidth',2);
xlim([(dUmin*0.99) (dUmax*1.01)]);
xlabel('dU, V','FontSize', 18);
ylabel('I, A','FontSize', 18);
title('VAC','FontSize', 18);
grid on;
set(gca,'FontSize', 18);

% Для навешивания фонаря
% scale=J2(floor(length(J2)/2))/J3(floor(length(J3)/2));

% figure
% semilogy(dU, J3.*1e-4*scale, dU, J2.*1e-4,'rs');
% xlabel('dU, V','FontSize', 18);
% ylabel('J, A/cm^2','FontSize', 18);
% title('VAC','FontSize', 18);
% grid on;
% set(gca,'FontSize', 18);
% 
% figure
% semilogy(dU, J3.*S*scale, dU, J2.*S,'rs');
% xlabel('dU, V','FontSize', 18);
% ylabel('I, A','FontSize', 18);
% title('VAC','FontSize', 18);
% grid on;
% set(gca,'FontSize', 18);