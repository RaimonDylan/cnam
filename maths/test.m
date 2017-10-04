x=0:0.1:10*pi;
y1=sin(x); y2=sqrt(x); y3=sin(x).*sqrt(x);
plot(x,y1,x,y2,x,y3);
legend('off');
grid('on');
axis([0 10 -1 3]); % changement limites (zoom)
axis('ij');        % inversion de l'axe Y