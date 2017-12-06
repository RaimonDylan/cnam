function [x,kfinal,residu]=jacobi(A,b,toll,kmax)
    [n,m]=size(A);
    xold = zeros(n,1);
    kfinal=0;
    residu=norm(A*xold-b);
    n=length(b);
    while residu>=toll && kfinal<=kmax
      for i=1:n
        j=[1:i-1,i+1:n];
        xnew(i)=(b(i)-sum(A(i,j).*xold(j)))/A(i,i);
      end
      kfinal+=1;
      xold=xnew;
      residu=norm(A*xold'-b);
      end
    x=xnew;
end