clear all 
clear all function
N=32;
fe = 64;
Te = 1/fe;
n=[0:N-1]*Te;
f1 =10;
x1=cos(2*pi*f1*n); 
x2=cos(2*pi*f1*n+pi/4); 
x3=sin(2*pi*f1*n); 

tcdt1 = tcdtI(x1.');
tcdt2 = tcdtI(x2.');
tcdt3 = tcdtI(x3.');



figure(1);
subplot(3,1,1);
plot(tcdt1,'r');
subplot(3,1,2);
plot(tcdt2,'g');
subplot(3,1,3);
plot(tcdt3,'b');


dect1 = dct(x1.')
dect2 = dct(x2.')
dect3 = dct(x3.')
figure(2);
subplot(3,2,1);
plot(dect1,'r');
subplot(3,2,2);
plot(dect2,'g');
subplot(3,2,3);
plot(dect3,'b');