Is = 4*pi;  
x = linspace(-1, 1, 500);
Id = zeros(size(x));

for i = 1:length(x)
    if abs(x(i)) < 1 / (2 * sqrt(3))
        Id(i) = (Is / (4 * pi)) * (1 / (x(i)^2 + 1)^(3/2)) * ...
                exp(-20 * (0.15 - 0.3 * sqrt(3) * abs(x(i))) / ...
                (1 + sqrt(3) * abs(x(i)))) * sqrt(x(i)^2 + 1);
    else
        Id(i) = (Is / (4 * pi)) * (1 / (x(i)^2 + 1)^(3/2));
    end
end

plot(x, Id, 'LineWidth', 1.5);
xlabel('x');
ylabel('I_d(x)');
title('Plot of I_d(x) with I_s = 4\pi');
grid on;
