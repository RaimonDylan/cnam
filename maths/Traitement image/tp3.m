clear all;
close all;
clear all function

% TP 3
%% 1/ INDRODUCTION

im = imread('photophore.tif');
imgd = double(im);

result = ContourLaplacien(imgd, 230);

figure('Name','ContourLaPlacien','NumberTitle','off')

subplot(1,2,1);

imagesc(result); 
colormap(gray); 
axis image;

subplot(1,2,2);

# ajout de bruit
et = 5;
imgd2 = imgd + et*randn(size(imgd));
result05 = ContourLaplacien(imgd2, 230);
tauxResult05 = sum(sum(result ~= result05));

imagesc(result05); 
colormap(gray); 
axis image;
str = sprintf('ecart type 5\nTaux erreur= [%d]',tauxResult05);
title(str);


[sFinal,thresh] = canny(imgd,.4,3.5,1);

figure('Name','canny','NumberTitle','off')
subplot(1,2,1);
imagesc(sFinal); 
colormap(gray); 
axis image;


subplot(1,2,2);

# ajout de bruit
[canny05,thresh] = canny(imgd2,.4,3.5,1);
tauxCanny05 = sum(sum(sFinal ~= canny05));

imagesc(canny05); 
colormap(gray); 
axis image;
str = sprintf('ecart type 5\nTaux erreur= [%d]',tauxCanny05);
title(str);

