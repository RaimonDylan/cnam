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
**SEJOUR** (<ins>codeSejour</ins>, dateDebut, dateFin, nbPers, _codeClient_, _codeChambre_)  
**LoisirSejour** (<ins>_codeLoisir_</ins>, <ins>_codeSejour_</ins>)  
**LOISIR** (<ins>codeLoisir</ins>, libelleLoisir)  
**TarificationLoisir** (<ins>_codeLogement_</ins>, <ins>_codeLoisir_</ins>, tarifLoisir)  
**CLASSE** (<ins>codeClasse</ins>, libelleClasse)  
**LOGEMENT** (<ins>codeLogement</ins>, adresseLogement, _codeClasse_)  
**CATEGORIE** (<ins>codeCategorie</ins>, libelleCategorie, tarifMin, tarifMax)  
**CHAMBRE** (<ins>codeChambre</ins>, nbreLits, tarif, _codeCategorie_, _codeLogement_)
