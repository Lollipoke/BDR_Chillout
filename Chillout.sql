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
    année SMALLINT NOT NULL CHECK (année > 1500 AND année <= CAST(EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS SMALLINT)),
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
    quantité SMALLINT NOT NULL CHECK (quantité >= 0),
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
    dateNaissance DATE NOT NULL CHECK (dateNaissance < CURRENT_DATE),
    dateArrivée DATE NOT NULL CHECK (dateArrivée > dateNaissance AND dateArrivée = CURRENT_DATE),
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
    date DATE NOT NULL CHECK (date = CURRENT_DATE),
    CONSTRAINT PK_Evaluation PRIMARY KEY (idBoisson, idMembre)
);
/*-------------------------------------------*/

/*-------------------------------------------*/
DROP TABLE IF EXISTS Commande CASCADE;
CREATE TABLE Commande (
    id SMALLSERIAL,
    dateHeure TIMESTAMP NOT NULL CHECK (dateHeure = CURRENT_TIMESTAMP),
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


/*==================================== TRIGGERS & FONCTIONS =========================================*/

DROP TYPE IF EXISTS type_action CASCADE;
CREATE TYPE type_action AS ENUM ('insert', 'update', 'delete');
/*=============================== LOGS Commande ==========================*/
DROP TABLE IF EXISTS LogCommande CASCADE;
CREATE TABLE LogCommande (
	id SERIAL,
	idCommande INTEGER NOT NULL CHECK (idCommande > 0),
	dateHeure DATE NOT NULL,
	idPersonne INTEGER NOT NULL CHECK (idPersonne > 0),
	commandeFournisseur BOOLEAN NOT NULL,
	typeAction type_action NOT NULL,
	miseAJour TIMESTAMP(0) NOT NULL,
	CONSTRAINT PK_LogEmploye PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION process_logCommande() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
	BEGIN
		IF(TG_OP = 'INSERT') THEN
			INSERT INTO LogCommande(idCommande, dateHeure, idPersonne, commandeFournisseur, typeAction, miseAJour)
				VALUES (NEW.id,NEW.dateHeure, NEW.idPersonne, NEW.commandeFournisseur, 'insert', CURRENT_TIMESTAMP);
		ELSIF(TG_OP = 'UPDATE') THEN
			INSERT INTO LogCommande(idCommande, dateHeure, idPersonne, commandeFournisseur, typeAction, miseAJour)
				VALUES (OLD.id, NEW.dateHeure, NEW.idPersonne, NEW.commandeFournisseur, 'update', CURRENT_TIMESTAMP);
		ELSIF(TG_OP = 'DELETE') THEN
			INSERT INTO LogCommande(idCommande, dateHeure, idPersonne, commandeFournisseur, typeAction, miseAJour)
				VALUES (OLD.id, OLD.dateHeure, OLD.idPersonne, OLD.commandeFournisseur, 'delete', CURRENT_TIMESTAMP);
		END IF;
		RETURN NULL;
	END;
$BODY$;

CREATE OR REPLACE TRIGGER after_insert_or_update_or_delete_Commande
AFTER INSERT OR UPDATE OR DELETE
ON Commande
FOR EACH ROW
EXECUTE FUNCTION process_logCommande();

/*=============================== LOGS Personnes ==========================*/
DROP TABLE IF EXISTS LogPersonne CASCADE;
CREATE TABLE LogPersonne (
	id SERIAL,
	idPersonne INTEGER NOT NULL CHECK (idPersonne > 0),
	nom VARCHAR(80) NOT NULL,
    prénom VARCHAR(80) NOT NULL,
    dateNaissance DATE NOT NULL,
    dateArrivée DATE NOT NULL CHECK (dateArrivée > dateNaissance),
    actif BOOLEAN NOT NULL DEFAULT TRUE,
	typeAction type_action NOT NULL,
	miseAJour TIMESTAMP(0) NOT NULL,
	CONSTRAINT PK_LogPersonne PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION process_logPersonne() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
	BEGIN
		IF(TG_OP = 'INSERT') THEN
			INSERT INTO LogPersonne(idPersonne, nom, prénom, dateNaissance, dateArrivée, actif, typeAction, miseAJour)
				VALUES (NEW.id,NEW.nom, NEW.prénom, NEW.dateNaissance, NEW.dateArrivée, NEW.actif, 'insert', CURRENT_TIMESTAMP);
		ELSIF(TG_OP = 'UPDATE') THEN
			INSERT INTO LogPersonne(idPersonne, nom, prénom, dateNaissance, dateArrivée, actif, typeAction, miseAJour)
				VALUES (OLD.id,NEW.nom, NEW.prénom, NEW.dateNaissance, NEW.dateArrivée, NEW.actif, 'update', CURRENT_TIMESTAMP);
		ELSIF(TG_OP = 'DELETE') THEN
			INSERT INTO LogPersonne(idPersonne, nom, prénom, dateNaissance, dateArrivée, actif, typeAction, miseAJour)
				VALUES (OLD.id, OLD.nom, OLD.prénom, OLD.dateNaissance, OLD.dateArrivée, OLD.actif, 'delete', CURRENT_TIMESTAMP);
		END IF;
		RETURN NULL;
	END;
$BODY$;

CREATE OR REPLACE TRIGGER after_insert_or_update_or_delete_Personne
AFTER INSERT OR UPDATE OR DELETE
ON Personne
FOR EACH ROW
EXECUTE FUNCTION process_logPersonne();


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

/*=============================== Vue quantité StockChillout ==========================*/
DROP VIEW IF EXISTS vQuantitéStockChillout;
CREATE VIEW vQuantitéStockChillout
AS
SELECT Boisson.id, Boisson.nom, SUM(Commande_stock.quantité) AS quantité
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
GROUP BY Boisson.id
ORDER BY Boisson.nom;

/*=============================== Check si le staff donné exist ==========================*/
CREATE OR REPLACE FUNCTION staff_exists(nomUser IN VARCHAR, idUser IN SMALLINT) RETURNS boolean
LANGUAGE plpgsql
AS
$BODY$
DECLARE staff_exists boolean;
BEGIN
    staff_exists := FALSE;

    IF EXISTS (SELECT 1
        FROM Staff
            INNER JOIN Personne
                ON Personne.id = Staff.idPersonne
        WHERE Staff.idPersonne = idUser AND Personne.nom = nomUser)
    THEN staff_exists := TRUE;
    END IF;
    RETURN staff_exists;
END;
$BODY$;

/*=============================== Check si le membre donné existe ==========================*/
CREATE OR REPLACE FUNCTION membre_exists(nomUser IN VARCHAR, idUser IN SMALLINT) RETURNS boolean
LANGUAGE plpgsql
AS
$BODY$
DECLARE membre_exists boolean;
BEGIN
    membre_exists := FALSE;

    IF EXISTS (SELECT 1
        FROM Membre
            INNER JOIN Personne
                ON Personne.id = Membre.idPersonne
        WHERE Membre.idPersonne = idUser AND Personne.nom = nomUser)
    THEN membre_exists := TRUE;
    END IF;
    RETURN membre_exists;
END;
$BODY$;

/*======================= Check si le rôle correspond au type de commande ==================*/
CREATE OR REPLACE FUNCTION function_check_role_commande() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    BEGIN
        IF (new.commandeFournisseur = true) THEN
            IF EXISTS (SELECT 1 FROM Staff INNER JOIN Personne ON Staff.idPersonne = Personne.id WHERE NEW.idPersonne = Staff.idPersonne AND Personne.actif = TRUE) THEN
                RETURN NEW;
            ELSE
				RAISE NOTICE 'Value: %', NEW.id;
                RAISE EXCEPTION 'Cannot create a supplier order while being a member';
            END IF;
        ELSEIF EXISTS (SELECT 1 FROM Membre INNER JOIN Personne ON Membre.idPersonne = Personne.id WHERE NEW.idPersonne = Membre.idPersonne AND Personne.actif = TRUE) THEN
                RETURN NEW;
            ELSE
				RAISE NOTICE 'Value: %', NEW.id;
                RAISE EXCEPTION 'Cannot create a client order while being a staff';
        END IF;
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_person_role_before_insert_or_update_Commande
BEFORE INSERT OR UPDATE
ON Commande
FOR EACH ROW
EXECUTE FUNCTION function_check_role_commande();

/*=============== Check si la boisson qui va être commandé est disponible (en vente) ==================*/
CREATE OR REPLACE FUNCTION function_check_disponibilité_Boisson_commande_stock() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
	BEGIN
    IF EXISTS (SELECT 1 FROM Commande WHERE new.idCommande = id) THEN
        IF EXISTS (SELECT 1 FROM Boisson WHERE new.idBoissonStock = id AND disponibilité = TRUE) THEN
            RETURN NEW;
        ELSE
            RAISE EXCEPTION 'La boisson avec l''id % n''est pas disponible', new.idBoissonStock;
        END IF;
    ELSE
        RAISE EXCEPTION 'La commande avec l''id % n''existe pas', new.idCommande;
    END IF;
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_quantity_ChilloutStock_before_insert_or_update_Commande
BEFORE INSERT OR UPDATE
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION function_check_disponibilité_Boisson_commande_stock();

/*==================== Check si la boisson est fournie par une fournisseur =====================*/
CREATE OR REPLACE FUNCTION function_check_supplier_sell_drink_commande_stock() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
	BEGIN
	IF EXISTS(SELECT 1 FROM Commande WHERE NEW.idCommande = Commande.id AND Commande.commandeFournisseur = TRUE) THEN
        IF EXISTS (SELECT 1 FROM Boisson_Fournisseur
                        INNER JOIN StockFournisseur
                            ON StockFournisseur.idBoissonStock = idBoisson
                        INNER JOIN Commande_Stock
                            ON StockFournisseur.idBoissonStock = Commande_Stock.idBoissonStock
                        INNER JOIN Commande
                            ON Commande_Stock.idCommande = Commande.id
                        WHERE new.idBoissonStock = StockFournisseur.idBoissonStock
                        AND StockFournisseur.nomFournisseur = Boisson_Fournisseur.nomFournisseur
                        AND Commande.commandeFournisseur = true) THEN
            RETURN NEW;
        ELSE
            RAISE EXCEPTION 'Le fournisseur ne dispose pas de la boisson #%', new.idBoissonStock;
        END IF;
    END IF;
	RETURN NEW;
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_supplier_sell_drink_before_insert_Commande
BEFORE INSERT OR UPDATE
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION function_check_supplier_sell_drink_commande_stock();

/*==================== Check l'âge des membres lors des commandes clients ====================*/
CREATE OR REPLACE FUNCTION function_check_member_age_commande_stock() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    DECLARE
        min_age INT;
        member_age INT;
	BEGIN
        IF EXISTS (SELECT 1 FROM Commande WHERE Commande.id = NEW.idCommande AND Commande.commandeFournisseur = FALSE) THEN
            SELECT agemin INTO min_age FROM BoissonAlcoolisée WHERE idBoisson = NEW.idBoissonStock;
            IF (min_age IS NULL) THEN
                min_age := 0;
            END IF;
            RAISE NOTICE 'Value min_age: %', min_age;
            SELECT EXTRACT(YEAR FROM AGE(NOW(), dateNaissance)) INTO member_age FROM Personne INNER JOIN Membre ON Membre.idPersonne = Personne.id INNER JOIN Commande ON Commande.idPersonne = Personne.id WHERE Commande.id = NEW.idCommande;
            RAISE NOTICE 'Value member_age: %', member_age;
            IF (member_age >= min_age) THEN
                RETURN NEW;
            ELSE
                RAISE EXCEPTION 'L''age du client ne permet pas l''achat de cette boisson';
            END IF;
        END IF;
        RETURN NEW;
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_supplier_sell_drink_before_insert_or_update_Commande
BEFORE INSERT OR UPDATE
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION function_check_member_age_commande_stock();

/*===== Check si toutes les boissons d'une commande fournisseur proviennent d'un seul fournisseur ======*/
CREATE OR REPLACE FUNCTION function_check_same_supplier_commande_stock() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    DECLARE
        nomFournisseurCommande VARCHAR;
	BEGIN
	    IF EXISTS (SELECT 1 FROM Commande WHERE Commande.id = NEW.idCommande AND commandeFournisseur = TRUE) THEN
            IF EXISTS (SELECT 1 FROM Commande_Stock WHERE Commande_Stock.idCommande = NEW.idCommande) THEN
                SELECT nomFournisseur INTO nomFournisseurCommande
                FROM StockFournisseur
                    INNER JOIN Commande_Stock
                        ON StockFournisseur.idBoissonStock = Commande_Stock.idBoissonStock
                            AND StockFournisseur.datePéremptionStock = Commande_Stock.datePéremptionStock
                WHERE Commande_Stock.idCommande = NEW.idCommande;
                RAISE NOTICE 'Value nomFournisseurCommande: %', nomFournisseurCommande;
                IF EXISTS(SELECT 1 FROM StockFournisseur WHERE idBoissonStock = NEW.idBoissonStock AND datePéremptionStock = NEW.datePéremptionStock AND nomFournisseur = nomFournisseurCommande) THEN
                    RETURN NEW;
                ELSE
                    RAISE EXCEPTION 'La contrainte indiquant que toutes les boissons d''une commande fournisseur sont fourni par un et un seul fournisseur est violée';
                END IF;
            ELSE
                RETURN NEW;
            END IF;
	    ELSE
	        RAISE NOTICE 'Value idCommande: %', NEW.idCommande;
            RAISE EXCEPTION 'La commande n''existe pas';
        END IF;
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_same_supplier_insert_or_update_Commande
BEFORE INSERT OR UPDATE
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION function_check_same_supplier_commande_stock();

/*=============================== Recharge automatique du stock ==========================*/
CREATE OR REPLACE FUNCTION refill_stockFournisseur() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
	BEGIN
		EXECUTE ('UPDATE StockFournisseur SET quantité = 10 WHERE quantité < 2');
		RETURN NULL;
	END;

$BODY$;

CREATE OR REPLACE TRIGGER refill_after_insert_or_update_StockFournisseur
AFTER INSERT OR UPDATE
ON StockFournisseur
FOR EACH ROW
EXECUTE FUNCTION refill_StockFournisseur();

/*======================= Quantité de boissons restante dans le stock Chillout ==========================*/
CREATE OR REPLACE FUNCTION get_current_ChilloutStock(id_boisson INT, date_péremption DATE) RETURNS INT
LANGUAGE plpgsql
AS
$BODY$
    DECLARE
        sommeStock INT;
    BEGIN
        IF EXISTS (SELECT 1 FROM Stock WHERE Stock.idBoisson = id_boisson AND Stock.datePéremption = date_péremption) THEN
				SELECT (
					SELECT COALESCE(SUM(Commande_Stock.quantité), 0)
						FROM Commande_Stock
						INNER JOIN Commande
							ON Commande_Stock.idCommande = Commande.id
						WHERE Commande.commandeFournisseur = TRUE
						AND id_boisson = Commande_Stock.idBoissonStock
						AND date_péremption = Commande_Stock.datePéremptionStock)
						-   ((SELECT COALESCE(SUM(Commande_Stock.quantité), 0)
								FROM Commande_Stock
								INNER JOIN Commande
								ON Commande_Stock.idCommande = Commande.id
								WHERE Commande.commandeFournisseur = FALSE
								AND id_boisson = Commande_Stock.idBoissonStock
								AND date_péremption = Commande_Stock.datePéremptionStock)
					) INTO sommeStock;
            RETURN sommeStock;
        ELSE
            RAISE EXCEPTION 'La boisson avec l''id #% et la date de péremption % n''existe pas', id_boisson, date_péremption;
        END IF;
    END;
$BODY$;

CREATE OR REPLACE FUNCTION check_quantité_disponible_boisson() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    DECLARE
        sommeStock INT;
	BEGIN
		IF EXISTS(SELECT 1 FROM Commande WHERE Commande.id = NEW.idCommande AND Commande.commandeFournisseur = FALSE) THEN
            sommeStock := get_current_ChilloutStock(NEW.idBoissonStock);
			IF (NEW.quantité <= sommeStock) THEN
				RETURN NEW;
			ELSE
				raise notice 'Value: %', NEW.idCommande;
				RAISE EXCEPTION 'Not enough stock in chillout';
			END IF;
		END IF;
 		RETURN NULL;
	END;
$BODY$;

CREATE OR REPLACE TRIGGER check_quantité_disponible_before_insert_or_update_commande_stock
AFTER INSERT OR UPDATE
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION check_quantité_disponible_boisson();

/*============= [WIP] Quantité de boisson en stock suffisante au fournisseur pour quantité de boisson commandé ===========*/
CREATE OR REPLACE FUNCTION check_disponibilité_boisson_dans_fournisseur() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
	DECLARE
        quantitéFournisseur INT;
	BEGIN
		IF EXISTS(SELECT 1 FROM Commande WHERE Commande.id = NEW.idCommande AND Commande.commandeFournisseur = TRUE) THEN
			IF (NEW.quantité <= (SELECT StockFournisseur.quantité
			   					FROM StockFournisseur
			   					WHERE NEW.idBoissonStock = StockFournisseur.idBoissonStock
			   					ORDER BY StockFournisseur.quantité DESC
			   					LIMIT 1)) THEN
				UPDATE StockFournisseur SET quantité = quantité - NEW.quantité
					WHERE StockFournisseur.idBoissonStock = NEW.idBoissonStock;
				RETURN NEW;
			ELSE
				raise notice 'Value: %', NEW.idCommande;
				RAISE EXCEPTION 'Not enough stock in Fournisseur';
			END IF;
		END IF;
 		RETURN NULL;
	END;
$BODY$;

CREATE OR REPLACE TRIGGER check_before_insert_or_update_commande_stock_if_stock_fournisseur
BEFORE INSERT OR UPDATE
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION check_disponibilité_boisson_dans_fournisseur();

/*=============================== Check que la boisson dans stockChillout existe dans stockFournisseur ==========================*/
CREATE OR REPLACE FUNCTION check_element_in_fournisseur() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
	BEGIN
		IF EXISTS (SELECT 1
				   FROM StockFournisseur
				   WHERE NEW.idBoissonStock = StockFournisseur.idBoissonStock
				   			AND NEW.datePéremptionStock = StockFournisseur.datePéremptionStock) THEN
			RETURN NEW;
		ELSE
			RAISE EXCEPTION 'Cannot insert element in StockChillout that does not exists in StockFournisseur';
		END IF;
		RETURN NULL;
	END;

$BODY$;

CREATE OR REPLACE TRIGGER check_before_insert_or_update_Stock_chillout
BEFORE INSERT OR UPDATE
ON StockChillout
FOR EACH ROW
EXECUTE FUNCTION check_element_in_fournisseur();


/*================ Boisson ====================*/

/* - Soft - */

INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Coca-Cola', 450, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Nestea citron', 500, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Nestea pêche', 500, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Sprite', 330, true);

/* - Bière - */

INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Swaf', 330, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Farmer blanche', 500, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Punk IPA', 330, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('PornStar', 330, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Cardinal', 330, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Boxer', 250, false);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Chouffe', 330, false);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Heineken', 330, false);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Guinness', 500, true);

/* - Vin - */

INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Chasselas', 100, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Mateus', 90, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Fendant', 100, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Bordeaux', 90, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Pinot gris', 100, true);


/*================ Boisson soft ====================*/

INSERT INTO BoissonSoft (idBoisson) VALUES (1);
INSERT INTO BoissonSoft (idBoisson) VALUES (2);
INSERT INTO BoissonSoft (idBoisson) VALUES (3);
INSERT INTO BoissonSoft (idBoisson) VALUES (4);


/*================ Boisson alcoolisée ====================*/

/* - Bières - */

INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (5, 4.8, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (6, 4.8, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (7, 5.4, 16, 'Ecosse', 'Highland');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (8, 6.1, 18, 'Suisse', 'Valais');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (9, 4.8, 16, 'Suisse', 'Fribourg');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (10, 5.0, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (11, 8.0, 16, 'Belgique', 'Namur');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (12, 6.1, 16, 'Pays-Bas', 'Hollande');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (13, 8.8, 16, 'Irlande', 'Galway');

/* - Vin - */

INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (14, 10.1, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (15, 11.0, 16, 'Portugais', 'Algarve');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (16, 12.0, 16, 'Suisse', 'Valais');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (17, 13.3, 16, 'France', 'Bordeaux');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (18, 16.1, 18, 'Pays-Bas', 'Hollande');


/*================ Bière ====================*/

INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (5, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (6, 'Blanche');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (7, 'IPA');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (8, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (9, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (10, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (11, 'IPA');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (12, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (13, 'Stout');


/*================ Vin ====================*/

INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (14, 'Blanc', 2022);
INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (15, 'Rosé', 2011);
INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (16, 'Blanc', 2013);
INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (17, 'Rouge', 1983);
INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (18, 'Blanc', 2008);


/*================ Personne ====================*/

/* - Membres - */

INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Dylan', 'Bob', '1993-12-10', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Hammond', 'Yvonne', '1993-12-10', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Hammond', 'Cerise', '2000-10-20', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Monjeau', 'Hélène', '2005-05-30', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Boileau', 'Xavier', '2000-10-20', CURRENT_DATE, false);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Charest', 'Xavier', '1996-02-28', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Leroy', 'Raoul', '2007-08-21', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Jolicoeur', 'Patricia', '1998-12-14', CURRENT_DATE, false);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Sansouci', 'Arnaud', '1999-06-21', CURRENT_DATE, false);

/* - Staff - */

INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Martel', 'Laurène', '2001-09-13', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Lavalée', 'Thibault', '1998-12-14', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Lauzier', 'Laetitia', '1997-05-12', CURRENT_DATE, true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Leroy', 'Arnaud', '2002-05-25', CURRENT_DATE, false);


/*================ Filière ====================*/

INSERT INTO Filière (libellé) VALUES ('COMEM+');
INSERT INTO Filière (libellé) VALUES ('EC+G');
INSERT INTO Filière (libellé) VALUES ('HEG');
INSERT INTO Filière (libellé) VALUES ('TIC');
INSERT INTO Filière (libellé) VALUES ('TIN');


/*================ Membre ====================*/

INSERT INTO Membre (idPersonne, libelléFilière) VALUES (1, 'COMEM+');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (2, 'TIC');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (3, 'TIC');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (4, 'TIC');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (5, 'TIN');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (6, 'EC+G');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (7, 'TIN');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (8, 'EC+G');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (9, 'TIC');


/*================ Staff ====================*/

INSERT INTO Staff (idPersonne) VALUES (10);
INSERT INTO Staff (idPersonne) VALUES (11);
INSERT INTO Staff (idPersonne) VALUES (12);
INSERT INTO Staff (idPersonne) VALUES (13);
INSERT INTO Staff (idPersonne) VALUES (6);
INSERT INTO Staff (idPersonne) VALUES (7);


/*================ Evaluation ====================*/
/* REMARQUE: il faut que la date de Evaluation soit la date courrente sinon le check ne permet pas d'insérer l'évaluation */
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 1, 4, CURRENT_DATE);
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 2, 4, CURRENT_DATE);
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (5, 2, 5, CURRENT_DATE);
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 3, 4, CURRENT_DATE);
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 4, 4, CURRENT_DATE);
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (5, 4, 5, CURRENT_DATE);
/*INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 5, 4, '2022-01-25');*/ /*valeur hors date pour tester le check */
/*INSERT INTO Evaluation(1, 6, 4, '2019-04-10');*/ /* Membre actif qui n'a pas noté */


/*================ Fournisseur ====================*/

INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Ammstein', 'Rue des Champignons',  34, 1400, 'Yverdon-les-Bains', 4.9);
INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Landi', 'Impasse de la bonne affaire', 17, 1400, 'Yverdon-les-Bains', 0.0);
INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Alloboissons', 'Route du Bois',  3, 1753, 'Matran', 7.9);
INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Aligro', 'Avenue de la Concorde',  6, 1022, 'Chavannes-près-Renens', 4.9);
INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Use Less Eco', 'Chemin du port', 15, 1400, 'Yverdon-les-Bains', 2.9);


/*================ Boisson Fournisseur ====================*/

INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (1, 'Ammstein', 1.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (2, 'Ammstein', 1.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (3, 'Ammstein', 1.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (4, 'Ammstein', 1.4);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (5, 'Ammstein', 3.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (6, 'Ammstein', 3.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (7, 'Ammstein', 2.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (8, 'Ammstein', 4.8);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (9, 'Ammstein', 4.8);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (10, 'Ammstein', 1.9);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (11, 'Ammstein', 2.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (12, 'Ammstein', 2.8);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (13, 'Ammstein', 3.4);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (14, 'Ammstein', 5.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (15, 'Ammstein', 2.1);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (16, 'Ammstein', 3.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (17, 'Ammstein', 14.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (18, 'Ammstein', 10.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (1, 'Landi', 1.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (3, 'Landi', 1.3);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (5, 'Landi', 3.3);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (7, 'Landi', 1.5);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (9, 'Landi', 5.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (11, 'Landi', 2.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (13, 'Landi', 3.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (15, 'Landi', 2.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (17, 'Landi', 12.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (1, 'Alloboissons', 0.9);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (2, 'Alloboissons', 1.4);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (3, 'Alloboissons', 1.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (4, 'Alloboissons', 1.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (5, 'Alloboissons', 2.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (6, 'Alloboissons', 3.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (7, 'Alloboissons', 2.1);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (8, 'Alloboissons', 5.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (9, 'Alloboissons', 5.1);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (1, 'Aligro', 1.1);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (5, 'Aligro', 2.8);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (10, 'Aligro', 1.3);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (11, 'Aligro', 2.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (15, 'Aligro', 2.0);


/*================ Commande ====================*/

/* - Fournisseur - */

INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 10, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 11, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 12, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 6, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 6, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 7, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 6, TRUE);

/* REMARQUE : Si on utilise les insert ci-dessous, il faut commenter les autres insert et retirer le check dans la table Commande*/
/*INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('12.01.2022', 10, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('01.01.2022', 11, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('31.12.2021', 12, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 6, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 6, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 7, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 6, TRUE);*/

/* - Client - */

INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 1, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 2, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 3, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 1, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 1, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 2, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 4, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES (CURRENT_TIMESTAMP, 3, FALSE);

/* REMARQUE : Si on utilise les insert ci-dessous, il faut commenter les autres insert et retirer le check dans la table Commande*/
/*INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('12.01.2022', 1, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('31.12.2021', 2, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('01.01.2022', 3, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 1, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 1, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 2, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 4, FALSE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 3, FALSE);*/



/*================ Stock ====================*/

INSERT INTO Stock (idBoisson, datePéremption) VALUES (1, '13.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (1, '14.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (2, '13.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (2, '31.12.2021');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (3, '12.01.2022');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (4, '18.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (5, '12.01.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (5, '12.01.2022');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (5, '31.12.2021');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (6, '12.01.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (7, '12.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (8, '16.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (9, '16.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (13, '31.03.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (14, '31.03.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (15, '31.05.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (16, '31.05.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (17, '31.07.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (17, '01.08.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (17, '02.08.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (18, '31.12.2021');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (18, '01.01.2022');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (18, '02.01.2022');



/*================ Stock Fournisseur ====================*/
/* REMARQUE : Insérer uniquement des couples idBoisson, date qui sont dans Stock */
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (1, '13.02.2023', 10, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (2, '13.02.2023', 20, 'Ammstein');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (3, '12.01.2022', 50, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (4, '18.02.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (5, '12.01.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (5, '12.01.2022', 10, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (5, '31.12.2021', 10, 'Aligro');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (6, '12.01.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (7, '12.02.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (8, '16.02.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (9, '16.02.2023', 20, 'Landi');
/*INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (10, '31.02.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (11, '31.02.2023', 2, 'Ammstein');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (12, '31.02.2023', 2, 'Landi');*/ /* pas dispo */
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (13, '31.03.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (14, '31.03.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (15, '31.05.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (16, '31.05.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (17, '31.07.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (17, '01.08.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (17, '02.08.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (18, '31.12.2021', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (18, '01.01.2022', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (18, '02.01.2022', 2, 'Landi');


/*================ Stock Chillout ====================*/
/* REMARQUE : Insérer uniquement des couples idBoisson, date qui sont dans Stock */
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (1, '13.02.2023', 1.5);
/*INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (1, '14.02.2023', 1.5);*/ /* n'existe pas chez le fournisseur */
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (2, '13.02.2023', 1.5);
/*INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (3, '12.01.2022', 1.5);*/ /* pas dispo au chillout mais dispo chez fournisseur */
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (4, '18.02.2023', 1.6);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (5, '12.01.2023', 4.2);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (5, '12.01.2022', 3.7);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (5, '31.12.2021', 3.2);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (7, '12.02.2023', 2.3);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (8, '16.02.2023', 5.2);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (13, '31.03.2023', 3.0);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (14, '31.03.2023', 6.3);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (15, '31.05.2023', 2.3);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (16, '31.05.2023', 3.5);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (17, '31.07.2023', 16.0);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (18, '31.12.2021', 14.0);




/*================ Commande Stock ====================*/

/* === Commande au Fournisseur === */
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (1, 1, '13.02.2023', 7);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (2, 1, '13.02.2023', 2);
/*INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (1, 5, '13.02.2023', 3);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (1, 7, '13.02.2023', 1);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (1, 1, '13.02.2023', 1);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (2, 1, '14.02.2023', 2);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (3, 2, '13.02.2023', 3);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (4, 2, '31.12.2021', 6);*/ /* marche pas */
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (5, 3, '12.01.2022', 6);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (6, 4, '18.02.2023', 6);
--INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (7, 5, '12.01.2023', 6);

/* === Commande au Chillout === */
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (9, 4, '18.02.2023', 1);
/*INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (9, 3, '12.01.2022', 2);*/
/*INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (10, 5, '12.01.2023', 2);*/
/*INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (10, 5, '12.01.2023', 5);*/
/*INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (10, 5, '12.01.2023', 1);*/
/*INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (8, 6, '12.01.2023', 6);*/
/*INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (9, 6, '12.01.2023', 2);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (9, 1, '13.02.2023', 1);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (9, 1, '14.02.2023', 2);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (9, 5, '31.12.2021', 3);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (10, 6, '12.01.2023', 2);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (11, 6, '12.01.2023', 4);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (12, 6, '12.01.2023', 6);
/*INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (13, 18, '12.01.2023', 1);*/ /* marche pas*/
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (14, 6, '12.01.2023', 2);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (15, 6, '12.01.2023', 4);*/