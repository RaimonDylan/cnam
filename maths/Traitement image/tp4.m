clear all;
close all;
clear all function

% TP 4
%% 1/ INDRODUCTION
figure('Name','Otsu','NumberTitle','off')

subplot(1,2,1);
im = imread('nuageNDG.bmp');

imagesc(im); 
colormap(gray); 
axis image;
title("image de base");

subplot(1,2,2);

[IDX,sep] = otsu_b(im,2);
IDX = IDX .* 50;
imagesc(IDX); 
colormap(gray); 
axis image;
title("image algo OTSU");

%% 2/ APPROCHE SUPERVISEE
figure('Name','Hist sous image','NumberTitle','off')
sub_img_fond = im(20:80 , 130:180);
sub_img_nuage = im(150:200 , 150:200);

m_fond = mean(mean(sub_img_fond));
ec_fond = sqrt(mean(var(sub_img_fond)));
m_nuage = mean(mean(sub_img_nuage));
ec_nuage = sqrt(mean(var(sub_img_nuage)));

params = [ec_fond m_fond];
subplot(1,2,1);
x = 0:1:255;
y = gaussmf(x,params);
plot(x, y);
str = sprintf('sous-image fond\nEcart type = [%d]',ec_fond);
title(str);

subplot(1,2,2);
x2 = 0:1:255;
params = [ec_nuage m_nuage];
y2 = gaussmf(x,params);
plot(x, y);
str = sprintf('sous-image nuage\nEcart type = [%d]',ec_nuage);
title(str);

figure('Name','Determiner le seuil','NumberTitle','off')

x2 = 0:1:255;
params = [ec_nuage m_nuage];
y2 = gaussmf(x,params);
plot(x, y, x2, y2);
seuil = 151;
str = sprintf('seuil = [%d]',seuil);
title(str);
figure('Name','image methode supervisee','NumberTitle','off')


title("image supervisee");
subplot(1,2,1);
imb = 1 + (im > seuil) ;
imagesc(imb); 
colormap(gray); 
axis image;
title("image supervisee");

subplot(1,2,2);
imagesc(IDX); 
colormap(gray); 
axis image;
title("image non supervisee");




