# fFnction inverse 
```Matlab
function invA=myinv(A)
  [n,m] = size(A);
  [L,U] = mylu(A);
  for j=1:n
    b=zeros(n);
    b(j)=1;
    y=descente(L,b);
    invA(:,j)=remontee(U,y);
  end
end
```
# Test de la fonction inverse 
```Matlab
A = [1 0 3;2 2 2;3 6 4];
disp ("Matrice inverse de A par ma fonction : "),(myinv(A))
disp("Matrice inverse de A par fonction matlab : "),(inv(A))
```
