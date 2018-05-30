function variance = varsb(wc,N)
% Calcul du vecteur contenant les variances * nb points
% des sous bandes pour une decomposition en ondelettes 2D
% On commence avec la sous bande d'approximation et on va en augmentant la frequence
% wc : coefficients d'ondelettes donnes par la fonction FWT2()

n=size(wc,1);
t=1:N;
t=2.^t;
taille=[n n./t]

j=1;
figure('Name','Calcul du vecteur contenant les variances * nb points des sous bandes pour une decomposition en ondelettes 2D','NumberTitle','off')
for i=1:N
    subplot(4,3,i)
    str = sprintf('Sous bande l/c [%d,%d,%d,%d]\nNiveau de res %d',taille(i+1)+1,taille(i),1,taille(i+1),i);
    tab=wc(taille(i+1)+1:taille(i),1:taille(i+1));
    variance(j) = std(tab(:))^2;
    moy(j) = mean(tab(:));
    hist(tab(:),50)
    title(str)
    j=j+1;
    subplot(4,3,i+3)
    str = sprintf('Sous bande l/c [%d,%d,%d,%d]\nNiveau de res %d',1,taille(i+1),taille(i+1)+1,taille(i),i);
    tab=wc(1:taille(i+1),taille(i+1)+1:taille(i));
    variance(j) = std(tab(:))^2;
    moy(j) = mean(tab(:));
    hist(tab(:),50)
    title(str)
    j=j+1;
    subplot(4,3,i+6)
    str = sprintf('Sous bande l/c [%d,%d,%d,%d]\nNiveau de res %d',taille(i+1)+1,taille(i),taille(i+1)+1,taille(i),i);
    tab=wc(taille(i+1)+1:taille(i),taille(i+1)+1:taille(i));
    variance(j) = std(tab(:))^2;
    moy(j) = mean(tab(:));
    hist(tab(:),50)
    title(str)
    j=j+1;
    
    wc=wc(1:taille(i+1),1:taille(i+1));
end

if length(variance) ~= 3*N
    error('pb taille variance');
end
subplot(4,3,10)
variance(3*N+1) = std(wc(:))^2;
moy(3*N+1) = mean(wc(:));
hist(wc(:),50)

variance
moy