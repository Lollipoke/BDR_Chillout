set client_encoding to 'UTF8';


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




