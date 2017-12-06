function d=mydet(A)
  d=1;
  [L,U] = mylu(A);
  [n,m] = size(A);
  for i=1:n
    d = d*U(i,i);
  end
end