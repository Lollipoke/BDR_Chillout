-- BDR Projet Chillout
-- Auteur:  Alen Bijelic, Mélissa Gehring, Yanik Lange
-- Date:    22.12.2021

set client_encoding to 'utf8';

/*================ Création des tables ====================*/

DROP TABLE IF EXISTS Boisson CASCADE;
CREATE TABLE Boisson (
    id SMALLSERIAL,
    nom VARCHAR(80) NOT NULL,
    contenance SMALLINT NOT NULL CHECK (contenance > 0),
    disponibilité BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT PK_Boisson PRIMARY KEY (id)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS BoissonAlcoolisée CASCADE;
CREATE TABLE BoissonAlcoolisée (
    idBoisson SMALLINT,
    tauxAlcool DECIMAL(3,1) NOT NULL CHECK (tauxAlcool >= 0),
    ageMin SMALLINT NOT NULL CHECK (ageMin > 0 AND ageMin < 150),
    pays VARCHAR(80) NOT NULL,
    région VARCHAR(80) NOT NULL,
    CONSTRAINT PK_BoissonAlcoolisée PRIMARY KEY (idBoisson)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS BoissonSoft CASCADE;
CREATE TABLE BoissonSoft (
    idBoisson SMALLINT,    
    CONSTRAINT PK_BoissonSoft PRIMARY KEY (idBoisson)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Bière CASCADE;
-- Création et affectation du type enum
DROP TYPE IF EXISTS TypeBière CASCADE;
CREATE TYPE TypeBière AS ENUM ('Blonde', 'Blanche', 'IPA', 'Stout');
CREATE TABLE Bière (
    idBoissonAlcoolisée SMALLINT,
    type TypeBière NOT NULL,
    CONSTRAINT PK_Bière PRIMARY KEY (idBoissonAlcoolisée)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Vin CASCADE;
DROP TYPE IF EXISTS TypeVin CASCADE;
CREATE TYPE TypeVin AS ENUM ('Rouge', 'Blanc', 'Rosé');
CREATE TABLE Vin (
    idBoissonAlcoolisée SMALLINT,
    type TypeVin NOT NULL,
    année SMALLINT NOT NULL CHECK (année > 1500),
    CONSTRAINT PK_Vin PRIMARY KEY (idBoissonAlcoolisée)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Stock CASCADE;
CREATE TABLE Stock (
    idBoisson SMALLINT,
    datePéremption DATE CHECK (datePéremption >= current_date - interval '1 month'),
    CONSTRAINT PK_Stock PRIMARY KEY (idBoisson, datePéremption)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS StockFournisseur CASCADE;
CREATE TABLE StockFournisseur (
    idBoissonStock SMALLINT,
    datePéremptionStock DATE,
    quantité SMALLINT NOT NULL CHECK (quantité > 0),
    nomFournisseur VARCHAR(80) NOT NULL,
    CONSTRAINT PK_StockFournisseur PRIMARY KEY (idBoissonStock, datePéremptionStock)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS StockChillout CASCADE;
CREATE TABLE StockChillout (
    idBoissonStock SMALLINT,
    datePéremptionStock DATE,
    prixDeVente DECIMAL(8,2) NOT NULL CHECK (prixDeVente > 0),
    CONSTRAINT PK_StockChillout PRIMARY KEY (idBoissonStock, datePéremptionStock)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Fournisseur CASCADE;
CREATE TABLE Fournisseur (
    nom VARCHAR(80),
    nomRue VARCHAR(80) NOT NULL,
    numRue SMALLINT NOT NULL CHECK (numRue > 0),
    codePostal SMALLINT NOT NULL CHECK (codePostal > 0),
    localité VARCHAR(80) NOT NULL,
    fraisLivraison DECIMAL(8, 2) NOT NULL CHECK (fraisLivraison >= 0),
    CONSTRAINT PK_Fournisseur PRIMARY KEY (nom)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Boisson_Fournisseur CASCADE;
CREATE TABLE Boisson_Fournisseur (
    idBoisson SMALLINT,
    nomFournisseur VARCHAR(80),
    prixUnitaire DECIMAL(8, 2) NOT NULL CHECK (prixUnitaire > 0),
    CONSTRAINT PK_Boisson_Fournisseur PRIMARY KEY (idBoisson, nomFournisseur)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Personne CASCADE;
CREATE TABLE Personne (
    id SMALLSERIAL,
    nom VARCHAR(80) NOT NULL,
    prénom VARCHAR(80) NOT NULL,
    dateNaissance DATE NOT NULL,
    dateArrivée DATE NOT NULL CHECK (dateArrivée > dateNaissance),
    actif BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT PK_Personne PRIMARY KEY (id)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Membre CASCADE;
CREATE TABLE Membre (
    idPersonne SMALLINT,
    libelléFilière VARCHAR(80) NOT NULL,
    CONSTRAINT PK_Membre PRIMARY KEY (idPersonne)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Filière CASCADE;
CREATE TABLE Filière (
    libellé VARCHAR(80),
    CONSTRAINT PK_Filière PRIMARY KEY (libellé)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Staff CASCADE;
CREATE TABLE Staff (
    idPersonne SMALLINT,
    CONSTRAINT PK_Staff PRIMARY KEY (idPersonne)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Evaluation CASCADE;
CREATE TABLE Evaluation (
    idBoisson SMALLINT,
    idMembre SMALLINT,
    note SMALLINT NOT NULL CHECK (note >= 1 AND note <= 5),
    date DATE NOT NULL,
    CONSTRAINT PK_Evaluation PRIMARY KEY (idBoisson, idMembre)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Commande CASCADE;
CREATE TABLE Commande (
    id SMALLSERIAL,
    dateHeure DATE NOT NULL,
    idPersonne SMALLINT NOT NULL,
	commandeFournisseur BOOLEAN NOT NULL,
    CONSTRAINT PK_Commande PRIMARY KEY (id)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Commande_Stock CASCADE; 
CREATE TABLE Commande_Stock (
    idCommande SMALLINT,
    idBoissonStock SMALLINT,
    datePéremptionStock DATE,
    quantité SMALLINT NOT NULL CHECK (quantité > 0),
    CONSTRAINT PK_Commande_Stock PRIMARY KEY (idCommande, idBoissonStock, datePéremptionStock)
);

/*============================= Création d'indexs sur les clé étrangères =====================*/

CREATE INDEX IDX_FK_BoissonAlcoolisée_idBoisson ON BoissonAlcoolisée(idBoisson ASC);

CREATE INDEX IDX_FK_BoissonSoft_idBoisson ON BoissonSoft(idBoisson ASC);

CREATE INDEX IDX_FK_Bière_idBoissonAlcoolisée ON Bière(idBoissonAlcoolisée ASC);

CREATE INDEX IDX_FK_Vin_idBoissonAlcoolisée ON Vin(idBoissonAlcoolisée ASC);

CREATE INDEX IDX_FK_Stock_idBoisson ON Stock(idBoisson ASC);

CREATE INDEX IDX_FK_StockFournisseur_idBoissonStock_datePéremptionStock ON StockFournisseur(idBoissonStock ASC, datePéremptionStock ASC);
CREATE INDEX IDX_FK_StockFournisseur_nomFournisseur ON StockFournisseur(nomFournisseur ASC);

CREATE INDEX IDX_FK_StockChillout_idBoissonStock_datePéremptionStock ON StockChillout(idBoissonStock ASC, datePéremptionStock ASC);

CREATE INDEX IDX_FK_Boisson_Fournisseur_idBoisson ON Boisson_Fournisseur(idBoisson ASC);
CREATE INDEX IDX_FK_Boisson_Fournisseur_nomFournisseur ON Boisson_Fournisseur(nomFournisseur ASC);

CREATE INDEX IDX_FK_Membre_idPersonne ON Membre(idPersonne ASC);
CREATE INDEX IDX_FK_Membre_libelléFilière ON Membre(libelléFilière ASC);

CREATE INDEX IDX_FK_Staff_idPersonne ON Staff(idPersonne ASC);

CREATE INDEX IDX_FK_Evaluation_idBoisson ON Evaluation(idBoisson ASC);
CREATE INDEX IDX_FK_Evaluation_idMembre ON Evaluation(idMembre ASC);

CREATE INDEX IDX_FK_Commande_idPersonne ON Commande(idPersonne ASC);

CREATE INDEX IDX_FK_Commande_Stock_idCommande ON Commande_Stock(idCommande ASC);
CREATE INDEX IDX_FK_Commande_Stock_idBoissonStock_datePéremptionStock ON Commande_Stock(idBoissonStock ASC, datePéremptionStock ASC);

/*=================================== Contraintes de clés étrangères =========================*/

ALTER TABLE BoissonAlcoolisée 
    ADD CONSTRAINT FK_BoissonAlcoolisée_idBoisson
        FOREIGN KEY (idBoisson)
            REFERENCES Boisson (id)
ON UPDATE CASCADE;
/*-------------------------------------------*/
ALTER TABLE BoissonSoft
    ADD CONSTRAINT FK_BoissonSoft_idBoisson
        FOREIGN KEY (idBoisson)
            REFERENCES Boisson (id)
ON UPDATE CASCADE;
/*-------------------------------------------*/
ALTER TABLE Bière
    ADD CONSTRAINT FK_Bière_idBoissonAlcoolisée
        FOREIGN KEY (idBoissonAlcoolisée)       
            REFERENCES BoissonAlcoolisée (idBoisson)
ON UPDATE CASCADE;
/*-------------------------------------------*/
ALTER TABLE Vin
    ADD CONSTRAINT FK_Vin_idBoissonAlcoolisée
        FOREIGN KEY (idBoissonAlcoolisée)
            REFERENCES BoissonAlcoolisée (idBoisson)
ON UPDATE CASCADE;
/*-------------------------------------------*/
ALTER TABLE Stock
    ADD CONSTRAINT FK_Stock_idBoisson
        FOREIGN KEY (idBoisson)
            REFERENCES Boisson (id);
/*-------------------------------------------*/
ALTER TABLE StockFournisseur
    ADD CONSTRAINT FK_StockFournisseur_idBoissonStock_datePéremptionStock
        FOREIGN KEY (idBoissonStock, datePéremptionStock)
            REFERENCES Stock (idBoisson, datePéremption);
ALTER TABLE StockFournisseur
    ADD CONSTRAINT FK_StockFournisseur_nomFournisseur
        FOREIGN KEY (nomFournisseur)
            REFERENCES Fournisseur (nom)
ON UPDATE CASCADE;            
/*-------------------------------------------*/
ALTER TABLE StockChillout
    ADD CONSTRAINT FK_StockChillout_idBoissonStock_datePéremptionStock
        FOREIGN KEY (idBoissonStock, datePéremptionStock)
            REFERENCES Stock (idBoisson, datePéremption);
/*-------------------------------------------*/
ALTER TABLE Boisson_Fournisseur
    ADD CONSTRAINT FK_Boisson_Fournisseur_idBoisson
        FOREIGN KEY (idBoisson)
            REFERENCES Boisson (id);

ALTER TABLE Boisson_Fournisseur
    ADD CONSTRAINT FK_Boisson_Fournisseur_nomFournisseur
        FOREIGN KEY (nomFournisseur)
            REFERENCES Fournisseur (nom)
ON UPDATE CASCADE;
/*-------------------------------------------*/

/*-------------------------------------------*/
ALTER TABLE Membre
    ADD CONSTRAINT FK_Membre_idPersonne
        FOREIGN KEY (idPersonne)
            REFERENCES Personne (id);

ALTER TABLE Membre
    ADD CONSTRAINT FK_Membre_libelléFilière
        FOREIGN KEY (libelléFilière)
            REFERENCES Filière (libellé)
ON UPDATE CASCADE;
/*-------------------------------------------*/

/*-------------------------------------------*/
ALTER TABLE Staff
    ADD CONSTRAINT FK_Staff_idPersonne
        FOREIGN KEY (idPersonne)
            REFERENCES Personne (id);
/*-------------------------------------------*/

/*-------------------------------------------*/
ALTER TABLE Evaluation
    ADD CONSTRAINT FK_Evaluation_idBoisson
        FOREIGN KEY (idBoisson)
            REFERENCES Boisson (id);

ALTER TABLE Evaluation
    ADD CONSTRAINT FK_Evaluation_idMembre
        FOREIGN KEY (idMembre)
            REFERENCES Membre (idPersonne);
/*-------------------------------------------*/

/*-------------------------------------------*/
ALTER TABLE Commande
    ADD CONSTRAINT FK_Commande_idPersonne
        FOREIGN KEY (idPersonne)
            REFERENCES Personne (id);
/*-------------------------------------------*/

/*-------------------------------------------*/
ALTER TABLE Commande_Stock
    ADD CONSTRAINT FK_Commande_Stock_idCommande
        FOREIGN KEY (idCommande)
            REFERENCES Commande (id);
ALTER TABLE Commande_Stock
    ADD CONSTRAINT FK_Commande_Stock_idBoissonStock_datePéremptionStock
        FOREIGN KEY (idBoissonStock, datePéremptionStock)
            REFERENCES Stock (idBoisson, datePéremption);

/*=================================== Vérification de l'héritage ====================================*/

/* ------------------------------------------------------------------ */ 
-- Vérifie qu'une boisson n'est pas aussi une boisson soft
CREATE OR REPLACE FUNCTION function_check_boisson_alcoolisée()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idBoisson IN (SELECT idBoisson FROM BoissonSoft) THEN
        RAISE EXCEPTION 'Id de BoissonAlcoolisée invalide --> %', NEW.idBoisson
        USING HINT = 'L''heritage sur Boisson est disjoint. '
                     'Une boisson ne peut appartenir a plusieurs sous-types.';
    ELSE
        RETURN NEW;
    END IF;     
END; $$
LANGUAGE plpgsql;

CREATE TRIGGER check_boisson_alcoolisée
    BEFORE INSERT ON BoissonAlcoolisée
    FOR EACH ROW
    EXECUTE FUNCTION function_check_boisson_alcoolisée();

-- Vérifie qu'une boisson soft n'est pas aussi une boisson alcoolisée
CREATE OR REPLACE FUNCTION function_check_boisson_soft()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idBoisson IN (SELECT idBoisson FROM BoissonAlcoolisée) THEN
        RAISE EXCEPTION 'Id de BoissonSoft invalide --> %', NEW.idBoisson
        USING HINT = 'L''heritage sur Boisson est disjoint. '
                     'Une boisson ne peut appartenir a plusieurs sous-types.';
    ELSE
        RETURN NEW;
    END IF;     
END; $$
LANGUAGE plpgsql;

CREATE TRIGGER check_boisson_soft
    BEFORE INSERT ON BoissonSoft
    FOR EACH ROW
    EXECUTE FUNCTION function_check_boisson_soft();
/* ------------------------------------------------------------------ */

/* ------------------------------------------------------------------ */ 
-- Vérifie qu'une bière n'est pas aussi un vin
CREATE OR REPLACE FUNCTION function_check_bière()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idBoissonAlcoolisée IN (SELECT idBoissonAlcoolisée FROM Vin) THEN
        RAISE EXCEPTION 'Id de Bière invalide --> %', NEW.idBoissonAlcoolisée
        USING HINT = 'L''heritage sur BoissonAlcoolisée est disjoint. '
                     'Une boisson alcoolisée ne peut appartenir a plusieurs sous-types.';
    ELSE
        RETURN NEW;
    END IF;     
END; $$
LANGUAGE plpgsql;

CREATE TRIGGER check_bière
    BEFORE INSERT ON Bière
    FOR EACH ROW
    EXECUTE FUNCTION function_check_bière();

-- Vérifie qu'un vin n'est pas aussi une bière
CREATE OR REPLACE FUNCTION function_check_vin()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idBoissonAlcoolisée IN (SELECT idBoissonAlcoolisée FROM Bière) THEN
        RAISE EXCEPTION 'Id de Vin invalide --> %', NEW.idBoissonAlcoolisée
        USING HINT = 'L''heritage sur BoissonAlcoolisée est disjoint. '
                     'Une boisson alcoolisée ne peut appartenir a plusieurs sous-types.';
    ELSE
        RETURN NEW;
    END IF;     
END; $$
LANGUAGE plpgsql;

CREATE TRIGGER check_vin
    BEFORE INSERT ON Vin
    FOR EACH ROW
    EXECUTE FUNCTION function_check_vin();
/* ------------------------------------------------------------------ */