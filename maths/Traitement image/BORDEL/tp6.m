clear all;
close all;
clear all function
I = imread('photophore.tif');

J = imnoise(I,'salt & pepper',0.02);

K = medfilt2(J, [3 3]);
flt1 = ones(3)/9;
Y = conv2(I,flt1,'same');

r=MC(I,K,1)
r2=MC(I,Y,1)

figure('Name','Filtre mediane','NumberTitle','off')
subplot(1,3,1);
imshow(I)
colormap(gray)
title('Image de base')

subplot(1,3,2);
imshow(J)
colormap(gray)
title('Ajout de bruit')

subplot(1,3,3);
imshow(K)
colormap(gray)
str = sprintf('Application filtre mediane\nVariance = [%d]',r);
title(str);

figure('Name','Filtre linéaire','NumberTitle','off')
subplot(1,3,1);
imshow(I)
colormap(gray)
title('Image de base')

subplot(1,3,2);
imshow(J)
colormap(gray)
title('Ajout de bruit')

subplot(1,3,3);
image(Y/4)
colormap(gray)
str = sprintf('Application filtre linéaire\nVariance = [%d]',r2);
title(str);

