function [L,U,P]=mylupivot(A)
  [n,m]=size(A);
  L=eye(n);
  P=eye(n);
  for k = 1:n-1
    [maxVal ipiv] = max(abs(A(k:n,k)));
    ipiv+=k-1;
    A([k ipiv],:)=A([ipiv k],:);
    P([k ipiv],:)=P([ipiv k],:);
    for i = k+1:n
      L(i,k) = A(i,k)/A(k,k);
      A(i,:)=A(i,:)-L(i,k)*A(k,:);
    end
  end
  U= A(:,1:n);
end
