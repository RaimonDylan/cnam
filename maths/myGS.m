function [x,kfinal,residu]=myGS(A,b,toll,kmax)
    n=length(b);
    x = zeros(n,1);
    kfinal=0;
    residu=norm(A*x-b);
    while residu>=toll && kfinal<=kmax
      for i=1:n
        j=[1:i-1,i+1:n];
        x(i)=(b(i)-sum(A(i,j).*x(j)))/A(i,i);
      end
      kfinal+=1;
      residu=norm(A*x-b);
      end
end