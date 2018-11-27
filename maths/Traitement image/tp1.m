clear all;
close all;
clear all function
im = imread('photophore.tif');

% Manipulation
%% 1/ image non bruitéé

figure('Name','Bruit','NumberTitle','off')
imf = double(im);
subplot(2,1,1);
image(imf/4)
colormap(gray)
title('Image de base')

%% 2/ image synthétique

et = 5;
imb = imf + et*randn(size(imf));
subplot(2,1,2);
image(imb/4)
colormap(gray)
title('ajout de bruit')

%% 3/ filtre moyen

flt1 = ones(3)/9;
flt2 = ones(5)/25;
imf1 = conv2(imb,flt1,'same');
imf2 = conv2(imb,flt2,'same');

figure('Name','Filtre','NumberTitle','off')

subplot(2,1,1);
image(imf1/4)
colormap(gray)
[n,m]=size(imf/4);
%perf=sqrt(sum(sum((imf-imf1).^2))/(n*m));
[N,M] = size(imf/4);


perf = sqrt((1/(N*M))*(sum(sum((imf - imf1).^2))));
str = sprintf('Filtre 3x3\nPerformance = [%d]',perf);
title(str);

subplot(2,1,2);
image(imf2/4)
colormap(gray)
perf=sqrt(sum(sum((imf-imf2).^2))/(n*m));
str = sprintf('Filtre 5x5\nPerformance = [%d]',perf);
title(str);

%% 4/ Filtre gaussien

[X,Y] = meshgrid(-1:1,-1:1);
[X2,Y2] = meshgrid(-2:2,-2:2);
sigma = n/6;
fgauss = exp(-(X.^2+Y.^2)/(2*sigma*sigma));
fgauss = fgauss/sum(sum(fgauss));
fgauss2 = exp(-(X2.^2+Y2.^2)/(2*sigma*sigma));
fgauss2 = fgauss2/sum(sum(fgauss2));

imf1 = conv2(imb,fgauss,'same');
imf2 = conv2(imb,fgauss2,'same');

figure('Name','Filtre Gaussien','NumberTitle','off')

subplot(2,1,1);
image(imf1/4)
colormap(gray)
perf=sqrt(sum(sum((imf-imf1).^2))/(n*m));
str = sprintf('Filtre Gaussien 3x3\nPerformance = [%d]',perf);
title(str);

subplot(2,1,2);
image(imf2/4)
colormap(gray)
perf=sqrt(sum(sum((imf-imf2).^2))/(n*m));
str = sprintf('Filtre Gaussien 5x5\nPerformance = [%d]',perf);
title(str);



