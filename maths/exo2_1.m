P=[-1 1; 0 0; 1 1];
[a,b] = size(P);
matrice=ones(a,a);
matrice(:,2:end)= P(:,1).^(1:a-1);
x = matrice\P(:,2)


