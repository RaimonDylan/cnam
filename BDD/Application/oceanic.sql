-----------------	BDD - TP CNAM - RAIMON Dylan 	-----------------
----------- version 23/11/2018 ----------------

-----------------------------------------------------------------------------
-- Clear previous information.
-----------------------------------------------------------------------------
DROP TABLE IF EXISTS COMMANDEHISTORIQUE CASCADE;
DROP TABLE IF EXISTS LIVRAISON CASCADE;
DROP TABLE IF EXISTS LIGNECOMMANDE CASCADE;
DROP TABLE IF EXISTS COMMANDE CASCADE;
DROP TABLE IF EXISTS ENREGISTRER CASCADE;
DROP TABLE IF EXISTS AVIS CASCADE;
DROP TABLE IF EXISTS TYPE CASCADE;
DROP TABLE IF EXISTS CLIENT CASCADE;
DROP TABLE IF EXISTS PRODUIT CASCADE;
DROP TYPE IF EXISTS sexe_t;

-----------------------------------------------------------------------------
-- Initialize the structure.
-----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;
create type sexe_t as enum('Male', 'Female', 'Autre');
CREATE TABLE CLIENT (
num_cli SERIAL PRIMARY KEY,
email_cli VARCHAR(100)  NOT NULL,
mdp_cli VARCHAR(100) NOT NULL,
nom_cli VARCHAR(100) NOT NULL,
prenom_cli VARCHAR(100) NOT NULL,
sexe_cli sexe_t NOT NULL,
ddn_cli DATE NOT NULL,
adresse1_cli VARCHAR(100) NOT NULL,
adresse2_cli VARCHAR(100) NULL,
cp_cli VARCHAR(100) NOT NULL,
ville_cli VARCHAR(100) NOT NULL,
dtLastConnexion_cli DATE NOT NULL,
dtInscription_cli DATE NOT NULL,
CONSTRAINT email_chk CHECK (((email_cli)::text ~* '^[0-9a-zA-Z._-]+@[0-9a-zA-Z._-]{2,}[.][a-zA-Z]{2,4}$'::text)),
CONSTRAINT dtInscription_chk CHECK (dtInscription_cli> ddn_cli)
);

CREATE TABLE TYPE (
num_type SERIAL PRIMARY KEY,
libelle_type VARCHAR(100) NOT NULL
);

CREATE TABLE PRODUIT (
num_prd SERIAL PRIMARY KEY,
libelle_prd VARCHAR(100) NOT NULL,
prixHT_prd NUMERIC(6,2),
nbStock_prd INTEGER,
num_type INTEGER NOT NULL,
CONSTRAINT nbStock_chk CHECK (nbStock_prd >= 0),
CONSTRAINT prix_chk CHECK (prixHT_prd > 0),
CONSTRAINT FK_PRODUIT_TYPE FOREIGN KEY (num_type)
    REFERENCES TYPE(num_type)
);

CREATE TABLE ENREGISTRER (
num_cli INTEGER NOT NULL,
num_prd INTEGER NOT NULL,
nbProduit_pan INTEGER NOT NULL,
CONSTRAINT PK_ENREGISTRER PRIMARY KEY (num_cli,num_prd),
CONSTRAINT nbProduit_pan CHECK (nbProduit_pan > 0),
CONSTRAINT FK_ENREGISTRER_CLI FOREIGN KEY (num_cli)
    REFERENCES CLIENT(num_cli),
CONSTRAINT FK_ENREGISTRER_PRD FOREIGN KEY (num_prd)
    REFERENCES PRODUIT(num_prd)
);

CREATE TABLE AVIS(
num_cli INTEGER NOT NULL,
num_prd INTEGER NOT NULL,
description_avis VARCHAR(100) NOT NULL,
date_avis VARCHAR(100) NOT NULL,
note_avis NUMERIC(2,1) NOT NULL,
CONSTRAINT PK_AVIS PRIMARY KEY (num_cli,num_prd),
CONSTRAINT FK_AVIS_CLI FOREIGN KEY (num_cli)
    REFERENCES CLIENT(num_cli),
CONSTRAINT FK_AVIS_PRD FOREIGN KEY (num_prd)
    REFERENCES PRODUIT(num_prd),
CONSTRAINT note_chk CHECK (note_avis>= 0 and note_avis <= 5)
);

CREATE TABLE COMMANDE (
num_cde SERIAL PRIMARY KEY,
date_cde DATE NOT NULL,
prixHT_cde NUMERIC(10,2) NOT NULL,
num_cli INTEGER NOT NULL,
CONSTRAINT FK_COMMANDE_CLIENT FOREIGN KEY (num_cli)
    REFERENCES CLIENT(num_cli),
CONSTRAINT prixHT_cde CHECK (prixHT_cde > 0)
);

CREATE TABLE LIGNECOMMANDE (
num_cde INTEGER NOT NULL,
num_prd INTEGER NOT NULL,
nbProduit INTEGER NOT NULL,
CONSTRAINT PK_LIGNECOMMANDE PRIMARY KEY (num_cde,num_prd),
CONSTRAINT FK_LIGNECOMMANDE_CDE FOREIGN KEY (num_cde)
    REFERENCES COMMANDE(num_cde),
CONSTRAINT FK_LIGNECOMMANDE_PRD FOREIGN KEY (num_prd)
    REFERENCES PRODUIT(num_prd),
CONSTRAINT nbProduitCommand_ckc CHECK (nbProduit >= 0)
);

CREATE TABLE COMMANDEHISTORIQUE (
num_cde INTEGER NOT NULL,
num_prd INTEGER NOT NULL,
nbProduit INTEGER NOT NULL,
CONSTRAINT PK_COMMANDEHISTORIQUE PRIMARY KEY (num_cde,num_prd)
);

CREATE TABLE LIVRAISON (
num_liv SERIAL PRIMARY KEY,
date_liv DATE NOT NULL,
adresse1_liv VARCHAR(100) NOT NULL,
adresse2_liv VARCHAR(100) NULL,
cp_liv VARCHAR(100) NOT NULL,
ville_liv VARCHAR(100) NOT NULL,
num_cde INTEGER NOT NULL,
CONSTRAINT FK_LIVRAISON_COMMANDE FOREIGN KEY (num_cde)
    REFERENCES COMMANDE(num_cde)
);

-----------------------------------------------------------------------------
-- Insert some data.
-----------------------------------------------------------------------------

insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('mlambell0@csmonitor.com', 'WiZxuC0w9Q4a', 'Lambell', 'Cléopatre', 'Male', '1973-06-11', '34 Main Center', '55150-000', 'Belo Jardim', '2018-11-20', '2017-09-08');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('rtolhurst1@answers.com', 'N7CvtZLySa', 'Tolhurst', 'Illustrée', 'Female', '1985-07-02', '8 Bonner Alley', '544 01', 'Laibin', '2018-09-09', '2016-01-10');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('ehaggath2@webeden.co.uk', 'BDbEQLsKI', 'Haggath', 'Danièle', 'Male', '1973-11-13', '49 Eastlawn Crossing', '544 01', 'Dvůr Králové nad Labem', '2018-07-04', '2017-09-16');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('kpietroni3@kickstarter.com', '4WNlJ7pz', 'Pietroni', 'Bérangère', 'Female', '1995-01-26', '214 7th Circle', 'A98', 'Crossmolina', '2018-11-16', '2016-09-26');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('kpaddie4@dion.ne.jp', 'm1DxXJWb', 'Paddie', 'Dà', 'Female', '1989-06-01', '0 Melvin Terrace', '731 33', 'Köping', '2018-03-16', '2018-01-28');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('mproffitt5@bbc.co.uk', 'nz6Bf0Oz6', 'Proffitt', 'Nuó', 'Male', '1970-10-16', '2280 Commercial Point', '26130', 'Pak Phli', '2018-09-09', '2016-11-10');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('kschukert6@java.com', 'sgFEyz', 'Schukert', 'Médiamass', 'Female', '1989-02-19', '06 Bayside Terrace', '39280', 'Las Animas', '2018-06-13', '2017-12-11');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('sdillet7@google.it', 'Wj96I68C6Na', 'Dillet', 'Stéphanie', 'Female', '1985-02-10', '69030 Aberg Street', '58800-000', 'Sousa', '2018-11-01', '2015-10-17');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('ecorran8@theguardian.com', 'q4qAMQ82', 'Corran', 'Edmée', 'Male', '1985-01-19', '7 Marquette Way', '392999', 'Pokrovo-Prigorodnoye', '2018-10-23', '2017-06-25');
insert into CLIENT (email_cli, mdp_cli, nom_cli, prenom_cli, sexe_cli, ddn_cli, adresse1_cli, cp_cli, ville_cli, dtLastConnexion_cli, dtInscription_cli) values ('cstelle9@chron.com', 'jAap4xXuZ8Y', 'Stelle', 'Marlène', 'Male', '2005-04-27', '88715 Fordem Way', '5300', 'Puerto Princesa', '2018-01-29', '2015-04-02');

insert into TYPE (libelle_type) values ('Colliers');
insert into TYPE (libelle_type) values ('Boucles oreilles');
insert into TYPE (libelle_type) values ('Bagues');
insert into TYPE (libelle_type) values ('Bracelets');
insert into TYPE (libelle_type) values ('Miroirs');
insert into TYPE (libelle_type) values ('Porte-clés');
insert into TYPE (libelle_type) values ('Strap');

insert into PRODUIT (libelle_prd, prixHT_prd, nbStock_prd, num_type) values ('Unicorn',8.00,5,2);
insert into PRODUIT (libelle_prd, prixHT_prd, nbStock_prd, num_type) values ('Cat Kawaii',6.00,5,2);
insert into PRODUIT (libelle_prd, prixHT_prd, nbStock_prd, num_type) values ('ras de cou',13.00,0,1);
insert into PRODUIT (libelle_prd, prixHT_prd, nbStock_prd, num_type) values ('magicfoil',15.00,3,1);
insert into PRODUIT (libelle_prd, prixHT_prd, nbStock_prd, num_type) values ('cute chibi',6.00,5,4);


insert into ENREGISTRER(num_cli, num_prd, nbProduit_pan) values (1,1,2);
insert into ENREGISTRER(num_cli, num_prd, nbProduit_pan) values (3,1,1);
insert into ENREGISTRER(num_cli, num_prd, nbProduit_pan) values (1,4,1);
insert into ENREGISTRER(num_cli, num_prd, nbProduit_pan) values (5,2,2);
insert into ENREGISTRER(num_cli, num_prd, nbProduit_pan) values (1,5,1);

insert into AVIS(num_cli, num_prd, description_avis, date_avis, note_avis) values (1,1,'INCROYABLE','2018-11-16',4.5);
insert into AVIS(num_cli, num_prd, description_avis, date_avis, note_avis) values (1,2,'ma vie à changé depuis cet achat','2018-10-05',4.0);
insert into AVIS(num_cli, num_prd, description_avis, date_avis, note_avis) values (3,2,'euh vraiment pas terrible','2018-11-16',1.5); 

insert into COMMANDE(date_cde, prixHT_cde, num_cli) values ('2018-11-13',22.0,1); 
insert into COMMANDE(date_cde, prixHT_cde, num_cli) values ('2018-10-01',13.0,1); 
insert into COMMANDE(date_cde, prixHT_cde, num_cli) values ('2018-11-10',12.0,3); 
insert into COMMANDE(date_cde, prixHT_cde, num_cli) values ('2018-05-28',21.0,3); 

insert into LIGNECOMMANDE(num_cde, num_prd, nbProduit) values (1,1,2); 
insert into LIGNECOMMANDE(num_cde, num_prd, nbProduit) values (1,2,1); 
insert into LIGNECOMMANDE(num_cde, num_prd, nbProduit) values (2,3,1);
insert into LIGNECOMMANDE(num_cde, num_prd, nbProduit) values (3,2,2);
insert into LIGNECOMMANDE(num_cde, num_prd, nbProduit) values (4,4,1);
insert into LIGNECOMMANDE(num_cde, num_prd, nbProduit) values (4,5,1);

insert into LIVRAISON(date_liv, adresse1_liv, cp_liv, ville_liv, num_cde) values ('2018-11-15','34 Main Center','55150-000', 'Belo Jardim',1);

-------------------------------------------------------
-- Functions.
-------------------------------------------------------
CREATE OR REPLACE FUNCTION getInactifUser() 
RETURNS SETOF integer
AS $$
  SELECT DISTINCT num_cli FROM CLIENT NATURAL JOIN ENREGISTRER
  WHERE DATE_PART('day', NOW()::timestamp - dtLastConnexion_cli::timestamp) > 7;
$$ LANGUAGE SQL; 

CREATE OR REPLACE FUNCTION getProduitEpuise() 
RETURNS SETOF integer
AS $$
  SELECT num_prd FROM PRODUIT
  WHERE nbStock_prd = 0;
$$ LANGUAGE SQL; 

CREATE OR REPLACE FUNCTION getNoteProduit(produit integer)
RETURNS numeric
AS $$
  SELECT avg(note_avis) FROM avis WHERE num_prd = produit;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION majDtLastConnexion(_client integer)
RETURNS void 
AS $$
  UPDATE CLIENT
  SET dtLastConnexion_cli = NOW()
  WHERE num_cli = _client;
$$ LANGUAGE SQL;  

CREATE OR REPLACE FUNCTION VERIFICATION_MAJORITE()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $function$
   DECLARE majorite_ok boolean := false;
   BEGIN
      majorite_ok := (SELECT DATE_PART('year', NOW()::timestamp ) - DATE_PART('year', ddn_cli::timestamp) > 18 FROM CLIENT WHERE num_cli = new.num_cli);
      IF (majorite_ok) THEN RETURN new;
      ELSE RETURN NULL;
      -- ne renvoie rien, insertion abandonnée --
      END IF;
    END;
$function$;

CREATE TRIGGER VERIFICATION_MAJORITE_TRIGGER
   BEFORE INSERT
      ON COMMANDE FOR EACH ROW EXECUTE PROCEDURE VERIFICATION_MAJORITE();

CREATE OR REPLACE FUNCTION VERIFICATION_AJOUT_AVIS()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $function$
   DECLARE commande_ok boolean := false;
   BEGIN
      commande_ok := (SELECT count(*) > 0 FROM COMMANDE NATURAL JOIN LIGNECOMMANDE WHERE num_cli = new.num_cli AND num_prd = new.num_prd);
      IF (commande_ok) THEN RETURN new;
      ELSE RETURN NULL;
      -- ne renvoie rien, insertion abandonnée --
      END IF;
    END;
$function$;

CREATE TRIGGER VERIFICATION_AJOUT_AVIS_TRIGGER
   BEFORE INSERT
      ON AVIS FOR EACH ROW EXECUTE PROCEDURE VERIFICATION_AJOUT_AVIS();

CREATE OR REPLACE FUNCTION HISTORIQUE_COMMANDE()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $function$
   BEGIN
      INSERT INTO COMMANDEHISTORIQUE (num_cde, num_prd, nbProduit)
      SELECT num_cde, num_prd, nbProduit
      FROM LIGNECOMMANDE
      WHERE num_cde = new.num_cde;
      DELETE FROM LIGNECOMMANDE WHERE num_cde = new.num_cde;
      RETURN NULL;
    END;
$function$;

CREATE TRIGGER HISTORIQUE_COMMANDE_TRIGGER
   AFTER INSERT
      ON LIVRAISON FOR EACH ROW EXECUTE PROCEDURE HISTORIQUE_COMMANDE();
