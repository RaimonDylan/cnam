# Fonction remontée
```Matlab
function x=remontee(U,y)
n=length(y);
x(n)=y(n)/U(n,n);
  for i=n-1:-1:1
  x(i)=(y(i)-sum(U(i,i+1:n).*x(i+1:n)))/U(i,i);
  end
end
```
# Test de la fonction remontée
```Matlab
U=[1 2 3;0 4 5;0 0 6]
y = [14,23,18]
remontee(U,y);
```
