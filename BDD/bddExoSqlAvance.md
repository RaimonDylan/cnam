# Exercices SQL base Fichier
## Déterminez les clés de ces relations 

- **ADHERENT** (__NumA__, NomA, PrenomA, VilleA, CotisationA)
- **VOYAGE** (__RefV__, DestinationV, DureeV, CoutV, TypeV)
- **DEPART** (#__RefV__,__DateDepart__)
- **RESERVATION** (__Ndossier__, #NumA, #RefV, #DateDepart, Acompte)
- Clé primaire de départ : concatenation de refV et dateDepart
- Clé étrangère RefV et DateDepart RESERVATION : concatenation de refV et dateDepart DEPART

### 10) Retrouver le nombre de réservations, la somme et la moyenne des acomptes versés par voyage
```SQL
SELECT count(*) as nbReservation, SUM(Acompte) as somAcompte, avg(Acompte), refV
FROM RESERVATION
GROUP BY RefV
```

### 1) Retrouver et afficher le prix moyen des voyages de type Raid-Découverte en fonction de la durée (9).
```SQL
SELECT DureeV, AVG(CoutV) as prixMoyen
FROM VOYAGE
WHERE TypeV = 'RD'
GROUP BY DureeV
```
### 2) Retrouver le prix moyen des voyages d'une durée d'une semaine en fonction du type du voyage (11).
```SQL
SELECT DureeV, TypeV,  AVG(CoutV) as prixMoyen
FROM VOYAGE
WHERE DureeV = 1
GROUP BY typeV
```
### 3) Retrouver le nombre de voyages proposés par le club en fonction de la destination et du type (13).
```SQL
SELECT count(*) as nbVoyage, destinationV, typeV
FROM VOYAGE
GROUP BY destinationV, typeV
```
### 4) Retrouver le coût maximum, le coût minimum et le coût moyen des voyages de 2 semaines en fonction de la destination (14).
```SQL
SELECT MAX(CoutV) as CoutMax, MIN(CoutV) as CoutMin, AVG(CoutV) as CoutMoyen
FROM VOYAGE
WHERE DureeV = 2
GROUP BY destinationV
```
### 5) Retrouver les destinations des voyages dont la durée maximale de séjour est supérieure ou égale à 3 semaines, afficher ces destinations et leur durée maximale (16).
```SQL
SELECT DestinationV, MAX(DureeV)
FROM VOYAGE
GROUP BY destinationV
HAVING DureeV >= 3
```
### 6) Retrouver parmi les destinations de voyages de 3 ou 4 semaines, ceux qui ont un prix minimum inférieur ou égal à 15 000 euros ; Afficher la destination, le type, la référence de ces voyages ainsi que leur durée et leur prix (31).
```SQL
SELECT *
FROM VOYAGE
WHERE DureeV IN ('3','4')
GROUP BY DestinationV
HAVING MIN(CoutV) <= 15000
```
### 7) Calculer et afficher le prix moyen des voyages de sport et détente en fonction de la durée (35)
```SQL
SELECT AVG(CoutV) as PrixMoyen
FROM VOYAGE
WHERE TypeV = 'SD'
GROUP BY DureeV
```
### 8) Retrouvez les adherents n'ayant fait aucune réservation de voyage de type circuit touristique, affichez toutes les caracteristiques des adherents
```SQL
SELECT *
FROM ADHERENT
WHERE NumA NOT IN ( SELECT NumA 
                    FROM RESERVATION r, VOYAGE v
                    WHERE r.RefV = v.RefV
                    AND TypeV = 'CT' )
```
### 9) Retrouvez les voyages dont le prix est inférieur au prix moyen des voyages de type sport et detente
```SQL
SELECT *
FROM VOYAGE
WHERE CoutV < ( SELECT AVG(CoutV) 
                FROM VOYAGE
                AND TypeV = 'SD' )
```
