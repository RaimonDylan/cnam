function [L,U]=mylu(A)
  [n,m]=size(A);
  L=eye(n);
  for k = 1:n+1
    for i = k+1:n
      L(i,k) = A(i,k)/A(k,k);
      A(i,:)=A(i,:)-L(i,k)*A(k,:);
    end
  end
  U= A(:,1:n);
end
