close all
clear
% Define the range of x values
x = linspace(0, 20, 1000); % x values from 0 to 20

% Calculate the first-order Bessel function values
y = besselj(1, pi*x)./(2.*x);
y1 = sinc(x);
% Plot the Bessel function
figure;
plot(x, y, 'LineWidth', 1.5);
grid on;
title('jinc and sinc');
xlabel('x');
hold on
plot(x, y1, 'LineWidth', 1.5);
hold off
legend("jinc", "sinc")