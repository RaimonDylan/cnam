clear all;
close all;
clear all function

% TP 3
%% 1/ INDRODUCTION

im = imread('photophore.tif');
figure('Name','Bruit','NumberTitle','off')
imf = double(im);
result = ContourLaplacien(imf,0.01);
image(result/4)
colormap(gray)