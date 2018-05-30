##dct(x)
function [y] = tcdtII(x)
  N= length(x);
 
  n=0:N-1;
  k=0:N-1;
  
  b=ones(N,1);
  b(1) = 1/sqrt(2);
 
  
  B =  cos((pi*k*(n.'.+0.5))/(N));
  bB = b *B;
  
  
  
  y=sqrt(2/(N))*bB*x;
  
end