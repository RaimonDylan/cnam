# Fonction syslin
```Matlab
function x=syslin(A,b)
  [L,U] = mylu(A);
  y=descente(L,b)';
  x=remontee(U,y)';
end
```
# test de la Fonction syslin
```Matlab
A = [2 1;1 3];
b = [1;0];
x = syslin(A,b)
```
