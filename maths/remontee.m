function x=remontee(U,y)
n=length(y);
x(n)=y(n)/U(n,n);
  for i=n-1:-1:1
  x(i)=(y(i)-sum(U(i,i+1:n).*x(i+1:n)))/U(i,i);
  end
  x
end
