# Exercice Model Entité relation

## Exemple
- Propriétaire(**numprop**, nomprop, adresseprop)
- Appartement(**numappart**, #numProp, #numImmeub, #numType,  tarifbase)
- Immeuble(**numimmeub**, adresseimmeub)
- Contrat(**numContrat**, #numAppart, #numClient, caution, datecontrat)
- Client(**numClient**, nomClient, adresseClient)
- Reserve(**numClient**, **numappart**, acompte, datedebut, duree)
- Type(**numtype**, libelle)
- Saison(**codesaison**, libellesaison)
- EstTarife(**numtype**, **codesaison**, coeffMajoration)

## Exo1
- Client(**numClient**, #numTerritoire, nomClient, adresseClient)
- Territoire(**numTerritoire**, nomTerritoire)
- Commdande(**Commande**, #numCLient, #numVendeur, #numModele, dateCommande, Acompte)
- Comporte(**numCommande**, **codeOption**)
- Option(**codeOption**, tarifOption)
- Modele(**numModel**, anneemodele, prixbase, nomModele)
- Vendeur(**numVendeur**, nomvendeur, adressVendeur)
- ConvertPar(**numVendeur**, **numTerritoire**, ancienneté)

## Exo2

**CLIENT** (<ins>codeClient</ins>, nomClient, adresseClient)  
**SEJOUR** (<ins>codeSejour</ins>, dateDebut, dateFin, nbPers, #_codeClient_, #_codeChambre_)  
**LoisirSejour** (<ins>#_codeLoisir_</ins>, <ins>#_codeSejour_</ins>)  
**LOISIR** (<ins>codeLoisir</ins>, libelleLoisir)  
**TarificationLoisir** (<ins>#_codeLogement_</ins>, <ins>#_codeLoisir_</ins>, tarifLoisir)  
**CLASSE** (<ins>codeClasse</ins>, libelleClasse)  
**LOGEMENT** (<ins>codeLogement</ins>, adresseLogement, #_codeClasse_)  
**CATEGORIE** (<ins>codeCategorie</ins>, libelleCategorie, tarifMin, tarifMax)  
**CHAMBRE** (<ins>codeChambre</ins>, nbreLits, tarif, #_codeCategorie_, #_codeLogement_)

![](http://image.noelshack.com/fichiers/2018/39/4/1538039218-exo2.jpg)

## exo 3
#### Dictionnaire de données : 
- nomResponsable
- noIntervention
- DateIntervention
- nomTechnicien
- TempsPassé
- nomClient
- AdresseClient
- NoClient
- Distance
- QuantitePiece
- RefPiece
- PrixPiece
- NomPiece
- NoFacture
- DateEmissionFacture
### MEA
![](http://image.noelshack.com/fichiers/2018/39/5/1538121796-a.png)
### modele relationnel
**INTERVENTION** (<ins>noIntervention</ins>, dateIntervention, nomTech, tpsPasse, nomResp, #_noFacture_)  
**CLIENT** (<ins>noClient</ins>, nomClient, adresseClient, distance)  
**REMPLACE** (<ins>#_noIntervention_</ins>, <ins>#_refPiece_</ins>, qtePiece)  
**PIECE** (<ins>refPiece</ins>, prix, nom)  
**FACTURE** (<ins>noFacture</ins>, dateEmission, #_noClient_)

### Requete
- Combien a reçu de factures chaque client
- Quelles sont les interventions pour lesquelles on a changé aucune pièce
- Combien d'intervention par facture
