#MATRICE DE 2 LIGNES ET 3 COLONNES
A=[1 2 3; 4 5 6]
# MATRICE DE 2 LIGNES ET 3 COLONNES
B=[7 8 9; 10 11 12]
# MATRICE DE 3 LIGNES ET 2 COLONNES
C=[13 14; 15 16; 17 18]
# l'operation s'execute bien 
A+B
# l'operation s'execute bien le résultat est une matrice 2,2
A*C
# Impossible on essaye d'additionner deux matrice pas de la même dimension 
#A+C
# Impossible inv et det marche que sur des matrices carre
#inv(A)
#det(A)
# A Matrice carre donc inv marche 
A=[1 2; 0 0]
inv(A)
# VA METTRE LES VALEURS DE V DANS LA DIAGONAL -1 dans une matrice 
v=[2 5 10]
A=diag(v,-1)
v=[2]
# pareil mais juste avec une seule valeur
A=diag(v,-1)
#MATRICE 3,3
A =[3 1 2; -1 3 4; -2 -1 3]
#Garde que le triangle la diag et le triangle inferieur
L1=tril(A)
#garde que le triangle inferieur
L2=tril(A,-1)
