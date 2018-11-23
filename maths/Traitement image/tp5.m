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

L5=[1 , 4 , 6 , 4 , 1]; %level  (Intensitaet)
E5=[-1, -2, 0 , 2 , 1]; %edge   (Kanten)
S5=[-1,  0, 2 , 0 ,-1]; %spot
R5=[1 , -4, 6 ,-4 , 1]; %ripple (Rauhheit)
W5=[-1, 2 , 0 , -2, 1]; %wave   (welligkeit)
L5S5=L5'*S5;
imf = conv2(im,L5S5,'same') ;
%imf_c = VarianceLocale(imf,11);
subplot(1,3,2);
imagesc(imf); 
colormap(gray); 
axis image
title("convolution L5S5");
%subplot(1,3,3);
%imagesc(imf_c); 
%colormap(gray); 
%axis image
%title("Variance locale");

figure('Name','Texture moyenne ','NumberTitle','off')
img1 = imread('texture1.tif');
img1 = conv2(img1,L5S5,'same') ;
%img1_c = VarianceLocale(img1,11);
img2 = imread('texture2.tif');
img2 = conv2(img2,L5S5,'same') ;
%img2_c = VarianceLocale(img2,11);
normA = img1 - min(img1(:));
normA = normA ./ max(normA(:));
normA = 255*normA;
normB = img2 - min(img2(:));
normB = normB ./ max(normB(:));
normB = 255*normB;
m_img1 = mean(mean(normA));
m_img2 = mean(mean(normB));
ec_img1 = sqrt(mean(var(normA)));
ec_img2 = sqrt(mean(var(normB)));
subplot(1,2,1);
hist(normA,100) ;
str = sprintf('Image texture 1\nmoy = [%d]',m_img1);
title(str);
subplot(1,2,2);
hist(normA,100) ;
str = sprintf('Image texture 2\nmoy = [%d]',m_img2);
title(str);
figure('Name','Texture 3','NumberTitle','off')

subplot(1,2,1);
[IDX,sep] = otsu_b(im,2);
IDX = IDX .* 50;
imagesc(IDX); 
colormap(gray); 
axis image;
title("image algo OTSU");

subplot(1,2,2);
seuil = 93;
imb = 1 + (im > seuil) ;
imagesc(imb); 
colormap(gray); 
axis image;
title("Image binaire par seuillage");

figure('Name','Texture histogramme ','NumberTitle','off')


x = 0:1:255;
params = [ec_img1 m_img1];
y = gaussmf(x,params);

x2 = 0:1:255;
params = [ec_img2 m_img2];
y2 = gaussmf(x2,params);
plot(x, y, x2, y2);
legend({'texture 1','texture 2'},'Location','southwest')

str = sprintf('seuil = [%d]',seuil);
title(str);

