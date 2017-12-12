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
