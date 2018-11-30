# Recherche d'information 
## TF
- poids d'un terme dans un doc
## IDF 
- quantifier le contenue informatif d'un terme (rareté)
## W 
- TF * IDF
## Final ranking
- Score(terme,document) = SOMME(TF.IDF)

# Objectif 
- User Taste -> Info Need -> Query -> Search Engine -> Results -> Query Refinement -> Query -> ...

# Structure de données : Index enversé
- Collection C de doculement -> Indexation ( Tokenization -> Linguistic modules -> Indexation) -> Index inversé positionnel

## taille de l'index 
- 10% des données brutes si index non positionnel
- 30 - 50 % si index positionnel
- Encore + si gestion des sysnonymes etc...

# Calcul des poids
- Important si son poids et sa rareté sont importants
- Wt,d : t = terme, d = document
- Wt,d = TFt,f * IDFt = 1 * log10(TFt,d) * log10(N/DFt) : N = nombre de docs

# Recherche
- Recherche et ranking des documents répondant à une requete q selon le modèle vectoriel
- score(di,q) = cos(di,q) 

# Recall/Precision
-        R     P
- 1 R   1/10  1/1
- 2 N   1/10  1/2
- 3 N   1/10  1/3
- 4 R   2/10  2/4
- 5 R   3/10  3/5
- 6 N   3/10  3/6
- 7 R   4/10  4/7
- 8 N   5/10  5/8
- 9 N   5/10  5/9
- 10 N   5/10  5/10

- MAP (Mean Average Precision) -> pour toutes les requetes : permet de comparer les systèmes entre eux


