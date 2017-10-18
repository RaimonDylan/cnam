function [alpha]=naivePoly(P)
  % retourne le vecteur alpha
  [a,b] = size(P); 
  % dans a la taille de la première colonne de P
  % dans b la taille de la deuxième colonne de P
  matrice=ones(a,a);
  matrice(:,2:end)= P(:,1).^(1:a-1);
  alpha = matrice\P(:,2);
end

