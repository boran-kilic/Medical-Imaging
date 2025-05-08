clear
close all
clc
MPI_data = load("MPI_data.mat");
MPI_image = MPI_data.MPI_image;
figure;
imshow(MPI_image,[]);
axis on;

xTicks = linspace(0, size(MPI_image, 2), 7); 
yTicks = linspace(0, size(MPI_image, 1), 3);

xLabels = linspace(0, 90, numel(xTicks));
yLabels = linspace(0, 30, numel(yTicks));

set(gca, 'XTick', xTicks, 'XTickLabel', xLabels);
set(gca, 'YTick', yTicks, 'YTickLabel', yLabels);

xlabel('X (mm)');
ylabel('Y (mm)');
title('MPI Images left to right: Tracer A, Trace X, Tracer B');

TracerA = MPI_image(:, 1:500);
TracerX = MPI_image(:, 501:1000);
TracerB = MPI_image(:, 1001:1500);

noise = MPI_image(1:50,1:50);
rho_N = mean(std(noise));
mu_A = max(TracerA(:));
mu_X = max(TracerX(:));
mu_B = max(TracerB(:));

FWHM_A = findFWHM(TracerA);
fprintf("FWHM of Tracer A :\t %.2f mm \n",FWHM_A);
SNR_A = mu_A/rho_N;
fprintf("SNR of Tracer A :\t %.2f \n",SNR_A);
fprintf("\n");

FWHM_X = findFWHM(TracerX);
fprintf("FWHM of Tracer X :\t %.2f mm \n",FWHM_X);
SNR_X = mu_X/rho_N;
fprintf("SNR of Tracer X :\t %.2f \n",SNR_X);
fprintf("\n");

FWHM_B = findFWHM(TracerB);
fprintf("FWHM of Tracer B :\t %.2f mm \n",FWHM_B);
SNR_B = mu_B/rho_N;
fprintf("SNR of Tracer B :\t %.2f \n",SNR_B);


vessel_phantom = load("vessel_phantom.mat");
vessel_phantom = vessel_phantom.vessel_phantom;

figure;imshow(vessel_phantom,[]);
axis on;
xTicks = linspace(0, size(vessel_phantom, 2), 3); 
yTicks = linspace(0, size(vessel_phantom, 1), 3);
xLabels = linspace(0, 30, numel(xTicks));
yLabels = linspace(0, 30, numel(yTicks));
set(gca, 'XTick', xTicks, 'XTickLabel', xLabels);
set(gca, 'YTick', yTicks, 'YTickLabel', yLabels);
xlabel('X (mm)');
ylabel('Y (mm)');
title('Vessel Phantom Image');

resultA = conv2(vessel_phantom, TracerA, 'same');
resultX = conv2(vessel_phantom, TracerX, 'same');
resultB = conv2(vessel_phantom, TracerB, 'same');

figure;

subplot(1,3,1);imshow(resultA,[]);
title('MPI Image Tracer A');
axis on;
xTicks = linspace(0, size(resultA, 2), 3); 
yTicks = linspace(0, size(resultA, 1), 3);
xLabels = linspace(0, 30, numel(xTicks));
yLabels = linspace(0, 30, numel(yTicks));
set(gca, 'XTick', xTicks, 'XTickLabel', xLabels);
set(gca, 'YTick', yTicks, 'YTickLabel', yLabels);
xlabel('X (mm)');
ylabel('Y (mm)');

subplot(1,3,2);imshow(resultX,[]);
title('MPI Image Tracer X');
axis on;
set(gca, 'XTick', xTicks, 'XTickLabel', xLabels);
set(gca, 'YTick', yTicks, 'YTickLabel', yLabels);
xlabel('X (mm)');ylabel('Y (mm)');

subplot(1,3,3);imshow(resultB,[]);
title('MPI Image Tracer B');
axis on;
set(gca, 'XTick', xTicks, 'XTickLabel', xLabels);
set(gca, 'YTick', yTicks, 'YTickLabel', yLabels);
xlabel('X (mm)');ylabel('Y (mm)');


function FWHM = findFWHM(A)
[max_value, linear_index] = max(A(:));
[~, col] = ind2sub(size(A), linear_index);

target_value = max_value/2;
tolerance = 0.015; 

column_data = A(:, col);
indices = find(abs(column_data - target_value) <= tolerance);

if ~isempty(indices)
    FWHM = abs((col - indices(1))*2*(30/500)) ;
else
    fprintf('No values close to %.2f were found \n', target_value);
end
end



