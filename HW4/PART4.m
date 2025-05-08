close all; clear; clc

load('brainT2_mri.mat');

TE1=60; 
TE2=120; 
T2map=(TE2-TE1)./log(image1./image2); 
T2map_noisy=(TE2-TE1)./log(image1_noisy./image2_noisy); 

figure;imshow(abs(T2map),[0,350]);
title("T2 map of noise-free dataset"); 

figure; imshow(abs(T2map_noisy),[0,350]); 
title("T2 map of noisy dataset");

figure;imshow(T2map,[]) 
mask=roiellipse; 

T2_est=mean(T2map(mask)) 
T2_est_noisy=mean(T2map_noisy(mask))
error = (abs(T2_est - T2_est_noisy)/T2_est)*100