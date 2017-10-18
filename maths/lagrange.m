function [y]=lagrange(P,x)
  [a,b] = size(P);
  y=zeros(size(x));
  pcolonne= P(:,1);
  for i=1:a
    L=ones(size(x));
    for j=[1:a]
      if(j~=i)
        L.*=(x-P(j,1))/(P(i,1)-P(j,1));
      end
    end
    y+=P(i,2)*L;
  end
end