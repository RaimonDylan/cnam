function y=descente(L,b)
y(1)=b(1)/L(1,1);
for i=2:length(b)
y(i)=(b(i)-dot(L(i,1:i-1),y(1:i-1)))/L(i,i);
end
end

