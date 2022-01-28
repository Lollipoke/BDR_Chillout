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
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_person_role_before_insert_or_update_Commande
BEFORE INSERT OR UPDATE
ON Commande
FOR EACH ROW
EXECUTE FUNCTION function_check_role_commande();

/*=============================== Check if drink is available TRIGGER ==========================*/
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

/*=============================== Check if drink is sold by supplier TRIGGER ==========================*/
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

/*=============================== Check member legal age TRIGGER ==========================*/
CREATE OR REPLACE FUNCTION function_check_member_age_commande_stock() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    DECLARE
        min_age INT;
        member_age INT;
	BEGIN
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
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_supplier_sell_drink_before_insert_or_update_Commande
BEFORE INSERT OR UPDATE
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION function_check_member_age_commande_stock();

/*=============================== Check if all order are from the same supplier TRIGGER ==========================*/
CREATE OR REPLACE FUNCTION function_check_same_supplier_commande_stock() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    DECLARE
        nomFournisseurCommande VARCHAR;
	BEGIN
	    IF EXISTS (SELECT 1 FROM Commande WHERE Commande.id = NEW.idCommande AND commandeFournisseur = TRUE) THEN
            -- On récupère le nom du fournisseur de boisson d'une des insertions précédentes
	        -- La nouvelle insertion ou modification peut se faire uniquement si le même fournisseur fourni la boisson
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