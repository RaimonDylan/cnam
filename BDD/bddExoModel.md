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
