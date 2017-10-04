## Pour ne pas passer par un fichier :
f=’1./(1+x.^2)’
fplot(f,[-2,2])
## Passer par une fonction anonyme à préconiser :
f=@(x)[1./(1+x.^2)];
fplot(f,[-2,2])
## PLUSIEURS COURBES SUR LE MEME GRAPHES
x=[2:0.5:2];
y1=x.^2;
y2=x.^3;
plot(x,y1,'r-',x,y2,'b-.')
legend(['y1';'y2'])

