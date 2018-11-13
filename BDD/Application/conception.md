# Conception (½ journée)

## Dictionnaire des données et contraintes particulières

| nom  | format  | règle  | contrainte  | catégorie  |
|------|---------|--------|-------------|------------|
| num_user  |  password |   |  NOT NULL |   |
| email_user  |  varchar |   | UNIQUE NOT NULL CHECK (((email)::text ~* '^[0-9a-zA-Z._-]+@[0-9a-zA-Z._-]{2,}[.][a-zA-Z]{2,4}$'::text)) |   |
| mdp_user  |  password |   |  NOT NULL |   |
| nom_user  |  varchar |   |  NOT NULL |   |
| prenom_user  |  varchar |   | NOT NULL  |   |
| sexe_user  |  domaine('M','F','A') |   |  NOT NULL |   |
| ddn_user  |  date |   | NOT NULL <NOW()  |   |
| adresse1_user  |  varchar |   |  NOT NULL |   |
| adresse2_user  |  varchar |   |  NOT NULL |   |
| cp_user  |  int |   | NOT NULL > 0  |   |
| ville_user  |  varchar |   | NOT NULL  |   |
| dtLastConnexion_user  |  date |   | NOT NULL <NOW() |   |
| dtInscription_user  |  date |   | NOT NULL <NOW() >ddn_user |   |
| num_cde  |  int |   | NOT NULL auto_increment |   |
| date_cde  |  date |   | NOT NULL  |  <NOW() |
| prixHT_cde |  float |   |  NOT NULL |  >0 |
| num_prd  |  int |   | NOT NULL auto_increment |   |
| libelle_prd  |  varchar |   | NOT NULL  |   |
| prixHT_prd  |  float |   |  NOT NULL |   |
| nbStock_prd  |  int |   | NOT NULL > 0  |   |
| num_type  |  int |   | NOT NULL auto_increment |   |
| libelle_type  |  varchar |   | NOT NULL  |   |
| nbProduit  |  int |   | NOT NULL > 0 |   |
| nbProduit_pan  |  int |   | NOT NULL > 0 |   |

## MEA 

![](https://i.imgur.com/OF2YUe2.png)

- **UTILISATEUR** ( <ins>num_cli</ins>, email_cli, mdp_cli, nom_cli, prenom_cli, ddn_cli, sexe_cli, adresse1_cli, adresse2_cli, cp_cli, ville_cli,dtDernierConnexion, dtInscription_cli )
- **ENREGISTRER** ( <ins>#num_cli</ins>, <ins>#num_prd</ins>, nbProduit_pan )
- **PRODUIT** ( <ins>num_prd</ins>, libelle_prd, prixHT_prd, nbStock_prd, #num_type )
- **AVIS** ( <ins>num_avis</ins>, description_avis, date_avis, note_avis, #num_cli, #num_prd )
- **TYPE** ( <ins>num_type</ins>, libelle_type )
- **COMMANDE** ( <ins>num_cde</ins>, date_cde, prixHT_cde, #num_cli )
- **LIGNECOMMANDE** ( <ins>#num_cde</ins>, <ins>#num_prd</ins>, nbProduit )
- **COMMANDEHISTORIQUE** ( <ins>num_cde</ins>, date_cde, prixHT_cde )
- **LIVRAISON** ( <ins>num_liv</ins>, date_liv, adresse1_liv, adresse2_liv, cp_liv, ville_liv, #num_cde )

## Liste des fonctionnalités prises en charges par votre BD (fonctions, triggers).

### Fonctions
- Liste des utilisateurs qui ne sont pas connectées depuis 1 semaines avec des produits enregistrés
- Liste des produits qui n'ont plus de stock
- Liste des commandes qui n'ont pas encore été livrés
- Mettre à jour la date de dernière connexion du client
### Triggers
- Verification de la majorité de l'utilisateur lors de la commande
- Vérification lors de l'insertion d'un avis si le client a bien passé une commande de cette article
- Historiser les commandes lors de la livraison

## MOCODO ONLINE
```
AVIS, 0N UTILISATEUR, 0N PRODUIT: date_avis, note_avis, description_avis

UTILISATEUR: num_cli, email, mdp_cli, nom_cli, prenom_cli, ddn_cli, sexe_cli, adresse1_cli, adresse2_cli, cp_cli, ville_cli, dtLastConnexion, dtInscription_cli
ENREGISTRER, 0N UTILISATEUR, 1N PRODUIT: nbProduit_pan
:
PRODUIT: num_prd, libelle_prd, prixHT_prd, nbStock_prd
CLASSER, 11 PRODUIT, 0N TYPE
TYPE: num_type, libelle_type

PASSER, 0N UTILISATEUR, 11 COMMANDE
COMMANDE: num_cde, date_cde, prixHT_cde
LIGNECOMMANDE, 0N COMMANDE, 1N PRODUIT: nbProduit

COMMANDEHISTORIQUE: num_cde, date_cde, prixHT_cde
DECLENCHER, 01 COMMANDE, 11 LIVRAISON
LIVRAISON: num_liv, date_liv, adresse1_liv, adresse2_liv, cp_liv, ville_liv
```



