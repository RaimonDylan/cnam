function [y] = tcdtI(x)

  N= length(x);
 
  n=0:N-1;
  k=0:N-1;
  
  a=ones(N,1);
  a(1) = 1/sqrt(2);
  a(N) = 1/sqrt(2); 
  
  aa = a*a.';
  
  B =  cos((pi*n.'*k)/(N-1));
  aB = aa .*B;
  
  
  
  y=sqrt(2/(N-1))*aB*x;
  
end