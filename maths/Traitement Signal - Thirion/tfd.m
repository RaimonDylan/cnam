function [y] = tfd(x)

  N= length(x);
  A = zeros(N,N);
  n=0:N-1;
  k=0:N-1;
  A = exp(-j*2*pi*((n.'*k) / N));
  
  y=(1/N)*A*x;  
end