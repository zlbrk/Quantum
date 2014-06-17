scale=J2(5)/J3(5);

figure
semilogy(dU, J2.*1e-4, dU, J3.*1e-4*scale);
xlabel('dU, V','FontSize', 18);
ylabel('J, A/cm^2','FontSize', 18);
title('VAC','FontSize', 18);
grid on;
set(gca,'FontSize', 18);

figure
semilogy(dU, J2.*S, dU, J3.*S*scale);
xlabel('dU, V','FontSize', 18);
ylabel('I, A','FontSize', 18);
title('VAC','FontSize', 18);
grid on;
set(gca,'FontSize', 18);