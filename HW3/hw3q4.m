close all;clear;

%a
P = phantom('Modified Shepp-Logan',256);
figure;
imshow(P,[]);
title("Phantom Image");

%b
theta= 0:179;
R = radon(P,theta);
figure;imshow(R,[]);
title("Sinogram");
xlabel("l", 'Interpreter', 'tex');
ylabel('\theta', 'Interpreter', 'tex')

figure;
I1 = iradon(R,theta,"linear","Ram-Lak");
subplot(1,3,1); 
imshow(I1,[]);
title("Reconstructed Image (Ram-Lak)");

I2 = iradon(R,theta,"linear","Hamming");
subplot(1,3,2); 
imshow(I2,[]);
title("Reconstructed Image (Hamming)");

I3 = iradon(R,theta,"linear","none");
subplot(1,3,3);
imshow(I3,[]);
title("Reconstructed Image (none)");

%c
noise_std = 5;
noise = noise_std * randn(size(R));
R = R + noise;

theta= 0:179;
figure;imshow(R,[]);
title("Sinogram with noise");
xlabel("l", 'Interpreter', 'tex');
ylabel('\theta', 'Interpreter', 'tex')

figure;
I1 = iradon(R,theta,"linear","Ram-Lak");
subplot(1,3,1); 
imshow(I1,[]);
title("Reconstructed Image (Ram-Lak) with noise");

I2 = iradon(R,theta,"linear","Hamming");
subplot(1,3,2); 
imshow(I2,[]);
title("Reconstructed Image (Hamming) with noise");

I3 = iradon(R,theta,"linear","none");
subplot(1,3,3);
imshow(I3,[]);
title("Reconstructed Image (none) with noise");

%d
theta= 0:5:179;
R = radon(P,theta);
figure;imshow(R,[]);
title("Sinogram with fewer projections");
xlabel("l", 'Interpreter', 'tex');
ylabel('\theta', 'Interpreter', 'tex')

figure;
I1 = iradon(R,theta,"linear","Ram-Lak");
subplot(1,3,1); 
imshow(I1,[]);
title("Reconstructed Image (Ram-Lak) fewer projections");

I2 = iradon(R,theta,"linear","Hamming");
subplot(1,3,2); 
imshow(I2,[]);
title("Reconstructed Image (Hamming) fewer projections");

I3 = iradon(R,theta,"linear","none");
subplot(1,3,3);
imshow(I3,[]);
title("Reconstructed Image (none) fewer projections");

clear;clc;

