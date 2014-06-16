function [ h1 ] = PRVF( xc, U )
%% PRVF = Potential Relief Visualisation Function
%% Описание интерфейса
% [nil]
%
% U  -- потенциальный рельеф, эВ (энергетический потенциал)
% xc -- дополненная сопряженная сетка, нм
%% Визуализация потенциального рельефа

figure;
h1 = stem(xc, U,...
    'Color', [0.39 0.47 0.64], ...
    'MarkerFaceColor', [0.39 0.47 0.64], ...
    'MarkerEdgeColor', [0.24 0.24 0.24], ...
    'Marker', 'square', ...
    'LineWidth', 2);
grid on;
xlabel('x, nm', 'FontSize', 18);
ylabel('U, eV', 'FontSize', 18);
title('Barrier','FontSize',18);
xlim([(min(xc) - (max(xc)-min(xc))/(length(xc)-1)/2)...
    (max(xc) + (max(xc)-min(xc))/(length(xc)-1)/2)]);
set(gca,'FontSize',18);
hbase = get(h1,'Baseline');
set(hbase,'LineStyle','--');