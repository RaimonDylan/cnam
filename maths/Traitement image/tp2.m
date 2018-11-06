clear all;
close all;
clear all function

% TP 2
%% 1/ sinus

[x,y] = meshgrid(1:256,1:256);
A = 10;
B = 5;
I = sin(2*pi*(A*x/256 + B*y/256))+1;
figure('Name','TF image sinusoidale','NumberTitle','off')
subplot(2,1,1);
imshow(I)
title('A= 10 B= 5')
I = sin(2*pi*(20*x/256 + 1*y/256))+1;
subplot(2,1,2);
imshow(I)
title('A= 20 B= 1')

%% FFT

FI = fft2(I);
M_FI = abs(FI);
M_FI = fftshift(M_FI);

figure('Name','FFT','NumberTitle','off')
%subplot(2,1,1);
imshow(M_FI)
title('FFT')
% Plus A est élevé plus le point est loin
% Varié B reviens à varier la direction

%% 2/ Linéarité de FFT

I1 = sin(2*pi*(2*x/256 + 20*y/256))+1;
I2 = sin(2*pi*(20*x/256 + 2*y/256))+1;
I = I1+I2;

FI = fft2(I);
M_FI = abs(FI);
M_FI = fftshift(M_FI);

figure('Name','FFT 2','NumberTitle','off')
%subplot(2,1,1);
imshow(M_FI)
title('FFT')


%% 2/ Filtrage

figure('Name','Filtrage','NumberTitle','off')
I = sin(2*pi*(50*x/256 + 10*y/256))+1;
im = imread('photophore.tif');
imf = double(im);
image((imf+I)/4)
colormap(gray)
title('Image de base + sinus')
figure('Name','FFT','NumberTitle','off')
FI = fft2(I);
M_FI = abs(FI);
M_FI = fftshift(M_FI);
image(M_FI)
colormap(gray)
title('HMMM')

figure('Name','FINAL','NumberTitle','off')
FI = fft2(im+I);
FI(247,207) = 0;
FI(11,51) = 0;
FI = fftshift(FI);
im2 = ifft2(FI);
image((abs(im2))/4)
colormap(gray)
title('FINAL')