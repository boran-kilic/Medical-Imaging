clear 
close all
P = phantom('Modified Shepp-Logan',500);
figure();
imshow(P);
title('Original Image');
saveas(gcf, 'original.jpg');

F = fft2c(P);
figure();
imshow(log(1 + abs(F)), []); 
title('Magnitude Spectrum of the Original Image');
saveas(gcf, 'magspec_original.jpg');

plot_sinc_and_spectrum(0.3, 0.3, F)
plot_sinc_and_spectrum(0.3, 3, F)
plot_sinc_and_spectrum(1.5, 1.5, F)

function plot_sinc_and_spectrum(sigma_x, sigma_y, F)
    [x, y] = meshgrid(-25:0.1:25-0.1, -25:0.1:25-0.1);

    h = sinc2D(x, y, sigma_x, sigma_y);
    figure;
    surf(x, y, h, 'EdgeColor', 'none');
    title(['2D Sinc Function, \sigma_x = ', num2str(sigma_x), ', \sigma_y = ', num2str(sigma_y)]);
    xlabel('x'); ylabel('y'); zlabel('h(x, y)');
    saveas(gcf, ['sinc_function_sigma_x_', num2str(sigma_x), '_sigma_y_', num2str(sigma_y), '.jpg']);

    H = fft2c(h);
    figure();
    imshow(log(1 + abs(H)), []); 
    title(['Magnitude Spectrum of the Transfer Function, \sigma_x = ', num2str(sigma_x), ', \sigma_y = ', num2str(sigma_y)]);
    saveas(gcf, ['spectrum_transfer_function_sigma_x_', num2str(sigma_x), '_sigma_y_', num2str(sigma_y), '.jpg']);

    Y = F .* H;

    outimg = ifft2c(Y);
    figure();
    imshow(abs(outimg), []); 
    title(['Output Image, \sigma_x = ', num2str(sigma_x), ', \sigma_y = ', num2str(sigma_y)]);
    saveas(gcf, ['output_image_sigma_x_', num2str(sigma_x), '_sigma_y_', num2str(sigma_y), '.jpg']);

    figure();
    imshow(log(1 + abs(Y)), []); 
    title(['Magnitude Spectrum of the Output Image, \sigma_x = ', num2str(sigma_x), ', \sigma_y = ', num2str(sigma_y)]);
    saveas(gcf, ['magnitude_spectrum_output_sigma_x_', num2str(sigma_x), '_sigma_y_', num2str(sigma_y), '.jpg']);
end

function h = sinc2D(x, y, sigma_x, sigma_y)
    x_scaled = x / sigma_x;
    y_scaled = y / sigma_y;
    h = (sinc(x_scaled) .* sinc(y_scaled));
end
