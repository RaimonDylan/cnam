function x=syslin(A,b)
  [L,U] = mylu(A);
  y=descente(L,b)';
  x=remontee(U,y)';
end