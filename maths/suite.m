n = 12;
u = ones(1, n);
for i = 3:n
u(i) = u(i-1)+u(i-2);
end
disp(u)
