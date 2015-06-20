clear all;
close all;
clc;

%% ��������� ������������� � ���������

U0 = 4.5; % ������ �������, �� (������ ������ ��������� �� ��������� = 4,5 ��)
k = 6; % ������� ������������� �������������� �������, nil



% �� ANSYS'�
dX = 0.9919; % ������ �� ��������� �� ��� X
dY = 0.8983; % ������ �� ��������� �� ��� Y
dZ = 7.7386; % ������ �� ��������� �� ��� Z

%dZ = 1000; 

Tunneling = false; % ���������� �����

if (Tunneling)
% �������� ��������� ���������� ��� ���������� ��� � ���������� ������
   
    dUmin = 99e-3; % ����������� ���������� ��������, �
    dUmax = 101e-3; % ������������ ���������� ��������, � (������������� ���� ������� 30 ��/��)
    dUpts = 3; % ����� ���
    dU = linspace(dUmin, dUmax, dUpts); % ����� �� �����������
    
    % �������� ��������� ���������� ����� �����������
    dmin = 3; % ����������� ���������� ����� �����������, ��
    dmax = 3; % ������������ ���������� ����� �����������, ��
    dpts = 1; % ����� ����������� ������������
    d = linspace(dmin, dmax, dpts); % ����� �� ����������� ����� �����������
    
    % �����������
    L1 = 5e-9; % ������ ����������
    Thickness = 5e-9; % ������� ����������
    NumberOfTips = 1; % ���������� ��������
    
    %S = 202*1e-6*2*1e-6; % ������� ��������� ���������� ������� ���������� (������� 2���)
    S = L1*Thickness*NumberOfTips; % ������� ��������� ���������� ������� ����������
else
    % �������� ��������� ���������� ��� ���������� ��� � ��������������� ������
    dUmin = 9.0; % ����������� ���������� ��������, �
    dUmax = 9.0; % ������������ ���������� ��������, � (������������� ���� ������� 30 ��/��)
    dUpts = 3; % ����� ���
    dU = linspace(dUmin, dUmax, dUpts); % ����� �� �����������
    
    % �������� ��������� ���������� ����� �����������
    dmin = 4; % ����������� ���������� ����� �����������, ��
    dmax = 4; % ������������ ���������� ����� �����������, ��
    dpts = 1; % ����� ����������� ������������
    d = linspace(dmin, dmax, dpts); % ����� �� ����������� ����� �����������
    
    % �����������
    L1 = 5e-9; % ������ ����������
    Thickness = 5e-9; % ������� ����������
    NumberOfTips = 1; % ���������� ��������
    
    %S = 202*1e-6*2*1e-6; % ������� ��������� ���������� ������� ���������� (������� 2���)
    S = L1*Thickness*NumberOfTips; % ������� ��������� ���������� ������� ����������
end



% ������ ���� ����� ���������
%% ���������� �����-�������� ������������� ��������������� ���������

J1 = zeros(dpts, dUpts);
J2 = zeros(dpts, dUpts);
J3 = zeros(dpts, dUpts);
for i = 1: dpts % ������
    for j = 1: dUpts % �������
        
        % ����� ���������� �������
        clc;
        
        format_wf = '������ ������: U0=%0.5g\n';
        out_wf = sprintf(format_wf, U0);
        disp(out_wf);
        format_bv = '���������� ��������: dU=%0.5g\n';
        out_bv = sprintf(format_bv, dU(j));
        disp(out_bv);
        format_d = '���������� ����� �����������: d=%0.5g\n';
        out_d = sprintf(format_d, d(i));
        disp(out_d);
        format_k = '�������� �������������: k=%0.5g\n';
        out_k = sprintf(format_k, k);
        disp(out_k);
        
        if j>1
            formatJ2 = '��������� ���� (���������): %0.5g �/��^2';
            outJ2 = sprintf(formatJ2, J2(i, j-1)/1e4);
            disp(outJ2);
            
            formatJ3 = '��������� ���� (�������������): %0.5g �/��^2';
            outJ3 = sprintf(formatJ3, J3(i, j-1)/1e4);
            disp(outJ3);
        end
        pause
        
%         % ��������� ����� � ������� ��� �������������� �������
%         [ dx1, xc1 ] = MSMG( d(i), k );
%         [ U1 ] = PWBR( 0.5*U0, dU(j), d(i), xc1 );
%         % ������ ��������� ���� ��� �������������� �������
%         J1(i, j) = ECDQTJ(dU(j), U1, dx1); % ������� ����������� �� �������
%         formatJ1 = '��������� ���� (�������������): %0.5g �/�^2\n';
%         outJ1 = sprintf(formatJ1, J1(i, j));
%         disp(outJ1);

        % ��������� ����� � ������� ��� ���������� �������
        [ dx2, xc2 ] = MSMG( 1.2*d(i), k );
        [ U2 ] = SPRG( U0, dU(j), d(i), xc2 );
        %[ h1 ] = PRVF( xc2, U2 );
        
        % ������ ��������� ���� ��� ���������� �������
        %J2(i, j) = ECDQTJ(dU(j), U2, dx2); % ������� ����������� �� �������
        
        % ������ ��������� ���� �� �������������� ���������
        J3(i, j) = GF(U0, dU(j), d(i)); % ������� ����������� �� �������
        
    end
end

%% ������������

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

% ��� ����������� ������
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