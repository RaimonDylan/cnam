# Exercices SQL base Fichier
## Déterminez les clés de ces relations 

- **ADHERENT** (__NumA__, NomA, PrenomA, VilleA, CotisationA)
- **VOYAGE** (__RefV__, DestinationV, DureeV, CoutV, TypeV)
- **DEPART** (#__RefV__,__DateDepart__)
- **RESERVATION** (__Ndossier__, #NumA, #RefV, #DateDepart, Acompte)
- Clé primaire de départ : concatenation de refV et dateDepart
- Clé étrangère RefV et DateDepart RESERVATION : concatenation de refV et dateDepart DEPART

### 1) Retrouver les adhérents parisiens ; afficher leur nom et prénom.
```SQL
SELECT NomA,PrenomA
FROM ADHERENT
WHERE villeA = "Paris"
```
### 2) Retrouver les voyages de type Raid-Découverte ou Sport-Détente dont le coût est inférieur ou égal à 15 000 euros ; afficher la destination, la durée, le coût et le type.
```SQL
SELECT DestinationV, DureeV, CoutV, TypeV
FROM VOYAGE
WHERE typeV IN ('RD','SD')
AND coutV <= 150000
```
### 3) Retrouver la référence, la durée, le type et les dates de départ des voyages à destination de la "TURQUIE".
```SQL
SELECT v.RefV, DureeV, TypeV, DateDepart
FROM VOYAGE v NATURAL JOIN DEPART d
```
### 4) Retrouver les adhérents de "VERSAILLES" ayant effectué des réservations sur des voyages à destination de la "TUNISIE" ; afficher leur nom, prénom et le montant de l'acompte versé.
```SQL
SELECT NomA, PrenomA, Acompte
FROM ADHERENT a, VOYAGE v, RESERVATION r
WHERE a.NumA = r.NumA
AND   v.RefV = r.RefV
AND DestinationV = "TUNISIE"
```
### 5) Retrouver les adhérents ayant effectué des réservations sur des voyages autres que des circuits touristiques et préciser le type du voyage ; afficher donc le nom et le prénom de l'adhérent ainsi que le type du voyage considéré.
```SQL
SELECT NomA, PrenomA, TypeV
FROM ADHERENT a, VOYAGE v
WHERE TypeV != "CT"
```
### 6) Retrouver et afficher le nombre de voyages proposés par le club de voyage.
```SQL
SELECT count(*) as nbVoyage
FROM VOYAGE
```
### 7) Retrouver et afficher le nombre de départs proposés par le club de voyage.
```SQL
SELECT count(*) as nbDepart
FROM DEPART
```
### 8) Retrouver et afficher le prix moyen des voyages de type Raid-Découverte d'une durée de 2 semaines.
```SQL
SELECT AVG(coutV) as pmVoyage
FROM VOYAGE
WHERE DureeV = 2 AND TypeV = "RD"
```
### 9) Retrouver et afficher le prix moyen des voyages d'une durée d'une semaine tout type confondu.
```SQL
SELECT AVG(coutV) as pmVoyage
FROM VOYAGE
WHERE DureeV = 1 
```
### 10) Retrouver le nombre de réservations, la somme et la moyenne des acomptes versés par voyage
```SQL
SELECT count(*) as nbReservation, SUM(Acompte) as somAcompte, AVG(Acompte) as moyAcompte
FROM RESERVATION
GROUP BY RefV
```
### 11) Retrouver les destinations des voyages d’une durée de 2 semaines dont le coût est inférieur à 10 000 euros, afficher le coût ainsi que la destination
```SQL
SELECT CoutV, DestinationV
FROM VOYAGE
WHERE CoutV < 10000
AND DureeV = 2
```
### 12) Afficher la liste des caractéristiques de tous les voyages complétée par les caractéristiques des réservations effectuées s’il y en a.
```SQL
SELECT *
FROM VOYAGE v LEFT JOIN RESERVATION r on v.RefV = r.RefV
```
### 13) Afficher la liste des caractéristiques des réservations complétée par le nom et le prénom de l’adhérent.
```SQL
SELECT r.*, NomA, PrenomA
FROM RESERVATION r NATURAL JOIN ADHERENT
```
### 14) Afficher le nom, le prénom et le numéro de tous les adhérents ainsi que la référence et la date de départ des voyages qu’ils ont réservés s’il y en a.
```SQL
SELECT NomA, PrenomA, a.NumA, RefV, DateDepart
FROM ADHERENT a LEFT JOIN RESERVATION r on a.NumA = r.NumA 
```
### 15) Retrouver les voyages dont les dates de départ proposées sont comprises entre le 01/04/98 et le 01/05/98 ; afficher la référence, la destination, la durée et les dates de départ proposées.
```SQL
SELECT v.RefV, DestinationV, DureeV, DateDepart
FROM VOYAGE v NATURAL JOIN DEPART d
WHERE DateDepart BETWEEN "01/04/98" and "01/05/98"
```
### 16) Retrouver les adhérents dont le nom commence par les lettres AL ; afficher le nom, le prénom et la ville.
```SQL
SELECT NomA, PrenomA, VilleA
FROM ADHERENT
LIKE "AL%"
```
### 17) Retrouver les voyages à destination de l’Espagne ou du Portugal ayant un départ compris entre le 26/04/98 et le 21/05/98 et dont le prix est inférieur ou égal à 9 000 euros ; Afficher la référence du voyage, la destination et le prix ainsi que la date de départ exacte, le type et la durée.
```SQL
SELECT v.RefV, DestinationV, CoutV, DateDepart, TypeV, DureeV
FROM VOYAGE v NATURAL JOIN DEPART d
WHERE DestinationV IN ('ESPAGNE','PORTUGAL')
AND   DateDepart BETWEEN "26/04/98" and "21/05/98"
AND   CoutV <= 9000
```
### 18) Retrouver les voyages ayant un départ compris entre le 26/04/98 et le 21/05/98 et dont le prix est inférieur ou égal à 9 000 euros et correspondant à l’une des cinq destinations suivantes : Baléares, Espagne, Grèce, Italie, Portugal ; Afficher la référence du voyage, la destination et le prix ainsi que la date de départ exacte, le type et la durée.
```SQL
SELECT v.RefV, DestinationV, CoutV, DateDepart, TypeV, DureeV
FROM VOYAGE v NATURAL JOIN DEPART d
WHERE DateDepart BETWEEN "26/04/98" and "21/05/98"
AND   CoutV <= 9000
AND   DestinationV IN ('ESPAGNE','PORTUGAL','BALEARES','GRECE','ITALIE')
```
### 19) Retrouver les voyages d’une durée de 1 ou 2 semaines ayant un départ compris entre le 01/06/98 et le 27/06/98 sachant que le prix doit être inférieur ou égal à 7 000 euros ou bien que la destination doit être l’Irlande ; Afficher le prix, la destination, le type et la durée du voyage ainsi que sa référence et la date de départ exacte.
```SQL
SELECT v.RefV, DestinationV, CoutV, DateDepart, TypeV, DureeV
FROM VOYAGE v NATURAL JOIN DEPART d
WHERE DureeV IN ('1','2')
AND   DateDepart BETWEEN "01/06/98" and "27/06/98"
AND   (CoutV <= 7000
OR   DestinationV = 'IRLANDE')
```
### 20) Retrouver les adhérents ayant effectué des réservations sur des voyages d’une durée supérieure à 3 semaines ; Afficher le nom, le prénom et le numéro de l’adhérent.
```SQL
SELECT NomA, PrenomA, a.NumA
FROM ADHERENT a, VOYAGE v, RESERVATION r
WHERE a.NumA = r.NumA
AND   v.RefV = r.RefV
AND DureeV > 3
```
### 21) Retrouver les réservations correspondant à des voyages d’un coût supérieur à 10 000 euros ; Afficher la référence du voyage et la destination ainsi que les caractéristiques de durée, de type et de prix.
```SQL
SELECT RefV, DestinationV, DureeV, TypeV, CoutV
FROM CoutV > 10000
```
### 22) Retrouver les voyages réservés par des adhérents parisiens ; Afficher la référence du voyage et la destination.
```SQL
SELECT v.RefV, DestinationV
FROM ADHERENT a, VOYAGE v, RESERVATION r
WHERE a.NumA = r.NumA
AND   v.RefV = r.RefV
AND   VilleA = "PARIS"
```
### 23) Calculer le solde restant à payer pour chaque réservation effectuée par un adhérent ; Afficher le nom, le prénom de l’adhérent, la référence du voyage et la date de départ ainsi que le solde.
```SQL
SELECT NomA, PrenomA, r.RefV, DateDepart, (CoutV - Acompte) as SoldeRestant
FROM ADHERENT a, VOYAGE v, RESERVATION r
WHERE a.NumA = r.NumA
AND   v.RefV = r.RefV
```

