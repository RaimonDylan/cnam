function [y]=naive(alpha,x)
  y=zeros(size(x));
  
  for a=size(alpha):-1:1
    % a vecteur qui commence par la taille
    % de alpha et regresse de 1 jusqu'a 1
    y=alpha(a)+x.*y;
  end
end
  