# Descente 
```Matlab
function y=descente(L,b)
  y(1)=b(1)/L(1,1);
  for i=2:length(b)
    y(i)=(b(i)-dot(L(i,1:i-1),y(1:i-1)))/L(i,i);
  end
end
```

# Test de la fonction Descente

```Matlab
L=[1 0 0;2 3 0;4 5 6]
b=[1;8;32]
descente(L,b);
```
