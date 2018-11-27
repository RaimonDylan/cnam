clear all;
close all;
clear all function

% TP 5
%% 1/ INDRODUCTION
im = imread('texture3.tif');

figure('Name','Texture','NumberTitle','off')
subplot(1,3,1);
imagesc(im); 
colormap(gray); 
axis image;
title("image de base");
J = imnoise(im,'salt & pepper',0.02);
K = medfilt2(J);