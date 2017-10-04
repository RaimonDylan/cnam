x=[pi/6 pi/4 pi/3]
s=sin(x)
c=cos(x)
t=s./c
tan(x)


x = [1; 2; 3];
y = [4; 5; 6];
# Chaque nombre du vecteur x est multiplie par 2
v = x.^2
# somme de chaque nombre du resultat precedent
b = sum(x.^2)
# Equivalent de [4 5 6]*[1;2;3]
s = y'*x
# Meme resultat que s
d = dot(x,y)
# multiplication de chaque terme de la matrice
u = x.*y
# multiplication par lui même de chaque terme
p = x.^x
c = cross(x,y)

somme= sum(1:500)
somme2= sum((1:500).^2)
pair = sum(2:2:500)
imp= sum(1:2:500)