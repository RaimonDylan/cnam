clear all;
close all;
clear all function
n = 1024;
p = 256;
j = 4;
k = 2^(j-1);
% 2 - Prise en main de Wevelab
% 2 - 1
% Création ondelette Haar
psi = MakeWavelet(j,k,'Haar',[],'Mother',n);% Ondelette mère
psi = psi*2^(log2(n)/2);

phi = MakeWavelet(j,k,'Haar',[],'Father',n);% Ondelette père
phi = phi*2^(log2(n)/2);

figure('Name','Haar','NumberTitle','off')
subplot(2,1,1);
plot(phi);
title('Ondelette père')
subplot(2,1,2);
plot(psi);
title('Ondelette mère')

% 2 - 2
%   Création d'ondelette père
phi2 = MakeWavelet(j,k,'Daubechies',4,'Father',n);%Filtre de longueur 4
phi2 = phi2*2^(log2(n)/2);

phi3 = MakeWavelet(j,k,'Daubechies',6,'Father',n);%Filtre de longueur 6
phi3 = phi3*2^(log2(n)/2);

phi4 = MakeWavelet(j,k,'Daubechies',12,'Father',n);%Filtre de longueur 12
phi4 = phi4*2^(log2(n)/2);

figure('Name','Ondelette père Daubechies','NumberTitle','off')
subplot(1,3,1);
plot(phi2,'r');
title('Filtre longueur 4')
subplot(1,3,2);
plot(phi3);
title('Filtre longueur 6')
subplot(1,3,3);
plot(phi4,'g');
title('Filtre longueur 12')

% 2 - 3
% Réponse impulsionnelle du filtre passe-bas
D12 = MakeONFilter('Daubechies',12);
D8 = MakeONFilter('Daubechies',8);
D4 = MakeONFilter('Daubechies',4);
D6 = MakeONFilter('Daubechies',6);
% Réponse frequentielle
a = fft(D12,p);
aa = fft(D6,p);
aaa = fft(D4,p);
% Module de la réponse fraquentielle
a = abs(a);
aa = abs(aa);
aaa = abs(aaa);

figure('Name','Module reponse freq Daubechies','NumberTitle','off')
plot((0:255)/265,a,(0:255)/265,aa,(0:255)/265,aaa);
legend('D12','D6','D4')
title('Module reponse freq Daubechies')

% 2 - 4
% Création du signal Ramp
sig = MakeSignal('Ramp',n);
J = log2(n); 
jmax = 4;
L = J-jmax; % L correspondant au L à mettre en entree de FWT_PO
b = FWT_PO(sig,L,D12);% Décomposition en ondelettes périodisées du signal 
c = IWT_PO(b,L,D12);% Reconstruction du signal à partir de ses coefficients d'ondelettes
erreur = norm(sig-c);% Erreur entre le signal original et celui reconstruit

figure('Name','Signal Ramp sur 1024 échantillons','NumberTitle','off')
subplot(1,3,1);
plot(sig);
title('Signal Ramp')
subplot(1,3,2);
plot(b,'r');
title('FWT PO')
subplot(1,3,3);
plot(c,'g');
str = sprintf('IWT PO\nErreur = [%d]',erreur);
title(str)

% Création du signal Ramp  sur 2048 échantillons
sig2 = MakeSignal('Ramp',2*n);
sig2 = sig2(1,1:1024); % tronquature du signal de façon à conserver que les 1024 premières valeurs
d = FWT_PO(sig2,L,D12);% Décomposition en ondelettes périodisées du signal 
e = IWT_PO(d,L,D12);% Reconstruction du signal à partir de ses coefficients d'ondelettes
erreur2 = norm(sig2-e);% Erreur entre le signal original et celui reconstruit

figure('Name','Signal Ramp sur 2048 échantillons tronqué a 1024','NumberTitle','off')
subplot(1,3,1);
plot(sig2);
title('Signal Ramp')
subplot(1,3,2);
plot(d,'r');
title('PWT PO')
subplot(1,3,3);
plot(e,'g');
str = sprintf('IWT PO\nErreur = [%d]',erreur2);
title(str)

% 3 - 1
% TRANSFORMEE EN ONDELETTES 2D
fid = fopen('Lenna.raw','r');
lena = fread(fid,[256,256]);
J = log2(length(lena));
jmax = 4;
L = J-jmax; 
fw = FWT2_PO(lena,L,D8);% Décomposition en ondelettes périodisées de l'image
% 3 - 2
iw = IWT2_PO(fw,L,D8);% Reconstruction de l'image à partir de ses coefficients d'ondelettes
erreur3 = norm(lena-iw);% Erreur entre le signal original et celui reconstruit

figure('Name','Transformée en ondelettes 2D PO','NumberTitle','off')
subplot(1,3,1);
imagesc(lena);
title('Image original')
subplot(1,3,2);
imagesc(fw);
title('PWT2 PO')
subplot(1,3,3);
imagesc(iw);
str = sprintf('IWT2 PO\nErreur = [%d]',erreur3);
title(str)
colormap(gray)

% 4 - 1
[qmf,dqmf] = MakeBSFilter('Villasenor',1);

figure('Name','Réponse impulsionnelle des filtres AMR biorthogonale 9/7','NumberTitle','off')
subplot(2,1,1);
plot(qmf);
title('QMF')
subplot(2,1,2);
plot(dqmf);
title('DQMF')

% 4 - 2
J = log2(length(lena)); 
jmax = 3;
L = J-jmax; 
fws = FWT2_SBS(lena,L,qmf,dqmf);% Décomposition multirésolution de l'image
iws = IWT2_SBS(fws,L,qmf,dqmf);% Reconstruction de l'image
erreur4 = norm(lena-iws);% Erreur entre le signal original et celui reconstruit

figure('Name','Compression SBS 2D','NumberTitle','off')
subplot(1,3,1);
imagesc(lena);
title('Image original')
subplot(1,3,2);
imagesc(fws);
title('FWT2 SBS')
subplot(1,3,3);
imagesc(iws);
str = sprintf('IWT2 SBS\nErreur = [%d]',erreur4);
title(str)
colormap(gray)

% 4 - 3 && 4 - 4
% fonction varsb.m
varsb(fws,3)

%4 - 5
st01 = SoftThresh(fws,0.1);
st5 = SoftThresh(fws,5);
st50 = SoftThresh(fws,50);
iws01 = IWT2_SBS(st01,L,qmf,dqmf);% Reconstruction de l'image
iws5 = IWT2_SBS(st5,L,qmf,dqmf);% Reconstruction de l'image
iws50 = IWT2_SBS(st50,L,qmf,dqmf);% Reconstruction de l'image
erreur5 = norm(lena-iws01);% Erreur d'approximation effectué avec ce seuillage
erreur6 = norm(lena-iws5);% Erreur d'approximation effectué avec ce seuillage
erreur7 = norm(lena-iws50);% Erreur d'approximation effectué avec ce seuillage

figure('Name','SoftThresh','NumberTitle','off')
subplot(1,4,1);
imagesc(lena);
title('Image original')
subplot(1,4,2);
imagesc(iws01);
str = sprintf('seuillage = 0.1\nErreur = [%d]',erreur5);
title(str)
subplot(1,4,3);
imagesc(iws5);
str = sprintf('seuillage = 5\nErreur = [%d]',erreur6);
title(str)
subplot(1,4,4);
imagesc(iws50);
str = sprintf('seuillage = 50\nErreur = [%d]',erreur7);
title(str)
colormap(gray)
