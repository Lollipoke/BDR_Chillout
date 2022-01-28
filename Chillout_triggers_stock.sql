set client_encoding to 'UTF8';

/*=============================== Refill StockFournisseur TRIGGER ==========================*/
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


/*=============================== [WIP] Quantité de boisson en stock suffisante au chillout pour quantité de boisson commandé TRIGGER ==========================*/
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

CREATE OR REPLACE FUNCTION check_disponibilité_boisson() RETURNS TRIGGER
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

CREATE OR REPLACE TRIGGER check_before_insert_or_update_commande_stock
AFTER INSERT OR UPDATE
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION check_disponibilité_boisson();

/*=============================== [WIP] Quantité de boisson en stock suffisante au fournisseur pour quantité de boisson commandé TRIGGER ==========================*/
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

/*=============================== Check que la boisson dans stockChillout existe dans stockFournisseur TRIGGER ==========================*/
CREATE OR REPLACE FUNCTION check_element_in_fournisseur() RETURNS TRIGGER
LANGUAGE plpgsql
AS 
$BODY$
	BEGIN	
		IF EXISTS (SELECT *
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
