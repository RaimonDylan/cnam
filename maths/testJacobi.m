A = [2 1;1 3];
b = [1;0];
[x,k,r]=jacobi(A,b,1.e-9,50);
disp("x jacobi : ")
x
disp("x matlab : "),(A\b)
disp("residu   : "),(r)
disp("k FINAL  : "),(k)
[x,k,r]=myGS(A,b,1.e-9,50);
disp("x GS : ")
x
disp("residu   : "),(r)
disp("k FINAL  : "),(k)