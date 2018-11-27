clear all;
close all;
clear all function
im = imread('photophore.tif');

% TP 6
%% 1/ INDRODUCTION
figure('Name','Texture','NumberTitle','off')
imf = double(im);
subplot(3,1,1);
image(imf/4)
colormap(gray)
title('Image de base')

J = imnoise(imf);
K = medfilt2(J);
subplot(3,1,3);
image(J)
colormap(gray)
title('ajout de bruit')
subplot(3,1,3);
image(K/4)
colormap(gray)
title('filtre median')
