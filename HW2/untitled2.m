close all
% Define the parameter a (shift)
a = 0; % Example value of a > 1

% Define the radius range and angular range
r = linspace(0, 5, 500); % Radial distance
theta = linspace(0, 2*pi, 500); % Angle from 0 to 2*pi

% Create a meshgrid for polar coordinates
[R, Theta] = meshgrid(r, theta);

% Convert polar coordinates to Cartesian for plotting
X = R .* cos(Theta);
Y = R .* sin(Theta);

% Define the rect function in polar coordinates
f_R = double(abs(R - a) <= 0.5);

% Plot the function as an image
figure;
pcolor(X, Y, f_R); % Pseudocolor plot for better visualization
shading flat; % Remove grid lines for a cleaner plot
colormap([1 1 1; 0 0 1]); % White for 0 and blue for 1 (inside the disc)
axis equal;
title(['Plot of f(r) = rect(r - ', num2str(a), ') in Polar Coordinates']);
xlabel('x');
ylabel('y');
