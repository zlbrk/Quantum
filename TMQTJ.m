function [R, T] = TMQTJ(E, U, d)
%% TMQTJ = Transfer-Matrix of the Quantum Tunneling Junction
% ������� ������� ������������ �������
%% �������� ����������
% E -- ������ ������� ���������, ��
% U -- �������-���������� ������������� �������
% d -- ������ �������������� "�����������������" ��������
%
%% ���������� ���������� ����������

global el hbar m

%% ����������
% ������� ���������� � ������� ��

E = E*el; % �������, ��
U = U.*el; % ��������� (������������� ����������� ��� �������), ��
d = d.*1e-9; % ������������� "�����������������" ��������, �

%% ���������� ������� ��������� � ������ ������������� ����������� � ���������
% ����������� ������� ���������� �������� �������

D = zeros(2, 2, length(U));
K = zeros(size(U));

for i = 1:length(U)
    K(i) = (2*m*(E - U(i))/hbar/hbar)^0.5;
    D(:, :, i) = [1 1; K(i) -K(i)];
end

P = zeros(2, 2, length(U)-2);
SS(:, :, 1) = diag(ones(2, 1));

for i = 2:length(U)-1
    P(:, :, i) = [exp(-1i*K(i)*d(i-1)) 0; 0 exp(1i*K(i)*d(i-1))];
    SS(:, :, i) = SS(:, :, i-1)*(D(:, :, i)*P(:, :, i)*D(:, :, i)^-1);
end

S = D(:, :, 1)^-1*SS(:, :, length(U)-1)*D(:, :, length(U));

R = abs(S(2, 1))^2/abs(S(1, 1))^2; % ������ ����� ��������� (11)  ��� ������������ ���������

T = (K(length(K))/K(1))*(1/abs(S(1, 1))^2); % ������ ����� ��������� (11) ��� ������������ �����������

end