set client_encoding to 'UTF8';

CREATE OR REPLACE FUNCTION function_check_role_commande() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    BEGIN
        IF (new.commandeFournisseur = true) THEN
            IF EXISTS (SELECT 1 FROM Staff INNER JOIN Personne ON Staff.idPersonne = Personne.id WHERE NEW.idPersonne = Staff.idPersonne AND Personne.actif = TRUE) THEN
                RETURN NEW;
            ELSE
				raise notice 'Value: %', NEW.id;
                RAISE EXCEPTION 'Cannot create a supplier order while being a member';
            END IF;
        ELSEIF EXISTS (SELECT 1 FROM Membre INNER JOIN Personne ON Membre.idPersonne = Personne.id WHERE NEW.idPersonne = Membre.idPersonne AND Personne.actif = TRUE) THEN
                RETURN NEW;
            ELSE
				raise notice 'Value: %', NEW.id;
                RAISE EXCEPTION 'Cannot create a client order while being a staff';
        END IF;
		RETURN NULL;
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_person_role_before_insert_or_update_Commande
BEFORE INSERT OR UPDATE
ON Commande
FOR EACH ROW
EXECUTE FUNCTION function_check_role_commande();