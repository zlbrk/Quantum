clear all;
close all;
clc;

%% ��������� ������������� � ���������

U0 = 5.32; % ������ �������, �� (������ ������ ��������� �� ��������� = 4,5 ��)
k = 3; % ������� ������������� �������������� �������, nil

% �������� ��������� ���������� ��� ���������� ���
dUmin = 0.0; % ����������� ���������� ��������, �
dUmax = 1.6; % ������������ ���������� ��������, � (������������� ���� ������� 30 ��/��)
dUpts = 10; % ����� ���
dU = linspace(dUmin, dUmax, dUpts); % ����� �� �����������

% �������� ��������� ���������� ����� �����������
dmin = 2.8; % ����������� ���������� ����� �����������, ��
dmax = 2.8; % ������������ ���������� ����� �����������, ��
dpts = 1; % ����� ����������� ������������
d = linspace(dmin, dmax, dpts); % ����� �� ����������� ����� �����������

S = 0.6*1e-6*1*1e-6; % ������� ��������� ���������� ������� ����������
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
            formatJ2 = '��������� ���� (���������): %0.5g �/�^2';
            outJ2 = sprintf(formatJ2, J2(i, j-1));
            disp(outJ2);
            
            formatJ3 = '��������� ���� (�������������): %0.5g �/�^2';
            outJ3 = sprintf(formatJ3, J3(i, j-1));
            disp(outJ3);
        end
        
%         % ��������� ����� � ������� ��� �������������� �������
%         [ dx1, xc1 ] = MSMG( d(i), k );
%         [ U1 ] = PWBR( 0.5*U0, dU(j), d(i), xc1 );
%         % ������ ��������� ���� ��� �������������� �������
%         J1(i, j) = ECDQTJ(dU(j), U1, dx1); % ������� ����������� �� �������
%         formatJ1 = '��������� ���� (�������������): %0.5g �/�^2\n';
%         outJ1 = sprintf(formatJ1, J1(i, j));
%         disp(outJ1);

        % ��������� ����� � ������� ��� ���������� �������
        [ dx2, xc2 ] = MSMG( 7*d(i), k+4 );
        [ U2 ] = SPRG( U0, dU(j), d(i), xc2 );
        [ h1 ] = PRVF( xc2, U2 );
        
        % ������ ��������� ���� ��� ���������� �������
        J2(i, j) = ECDQTJ(dU(j), U2, dx2); % ������� ����������� �� �������
        
        % ������ ��������� ���� �� �������������� ���������
        J3(i, j) = GeneralizedCurrentDensity(U0, dU(j), d(i)); % ������� ����������� �� �������
        
    end
end

% ��� ����������� ������
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