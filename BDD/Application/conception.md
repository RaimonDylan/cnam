# Conception (½ journée)

## Dictionnaire des données et contraintes particulières

| nom  | format  | règle  | contrainte  | catégorie  |
|------|---------|--------|-------------|------------|
| email_cli  |  varchar |   | NOT NULL CHECK (((email)::text ~* '^[0-9a-zA-Z._-]+@[0-9a-zA-Z._-]{2,}[.][a-zA-Z]{2,4}$'::text)) |   |
| mdp_cli  |  password |   |  NOT NULL |   |
| nom_cli  |  varchar |   |  NOT NULL |   |
| prenom_cli  |  varchar |   | NOT NULL  |   |
| sexe_cli  |  domaine('M','F','A') |   |  NOT NULL |   |
| ddn_cli  |  date |   | NOT NULL <NOW()  |   |
| rue_cli  |  varchar |   |  NOT NULL |   |
| cp_cli  |  int |   | NOT NULL > 0  |   |
| dtInscription_cli  |  date |   | NOT NULL <NOW() >ddn_cli |   |
| num_cde  |  int |   | NOT NULL auto_increment |   |
| date_cde  |  date |   | NOT NULL  |  <NOW() |
| prixHT_cde |  float |   |  NOT NULL |  >0 |
| num_prd  |  int |   | NOT NULL auto_increment |   |
| libelle_prd  |  varchar |   | NOT NULL  |   |
| prixHT_prd  |  float |   |  NOT NULL |   |
| nbStock_prd  |  int |   | NOT NULL > 0  |   |
| num_type  |  int |   | NOT NULL auto_increment |   |
| libelle_type  |  varchar |   | NOT NULL  |   |

