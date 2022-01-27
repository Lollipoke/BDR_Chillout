set client_encoding to 'UTF8';

/*=============================== Refill StockFournisseur TRIGGER ==========================*/
CREATE OR REPLACE FUNCTION refill_stockFournisseur() RETURNS TRIGGER
LANGUAGE plpgsql
AS 
$BODY$
	BEGIN
		EXECUTE ('UPDATE StockFournisseur SET quantité = 10 WHERE quantité < 5');
		RETURN NULL;
	END;
	
$BODY$;

CREATE OR REPLACE TRIGGER refill_after_insert_or_update_StockFournisseur
AFTER INSERT OR UPDATE 
ON StockFournisseur
FOR EACH ROW
EXECUTE FUNCTION refill_StockFournisseur();


/*=============================== [WIP] Check que boisson commandé soit dans le stock TRIGGER ==========================*/
/*CREATE OR REPLACE FUNCTION check_disponibilité_boisson() RETURNS TRIGGER
LANGUAGE plpgsql
AS 
$BODY$
	DECLARE
		quantitee smallint;
	BEGIN
		IF (NEW.quantité <= (SELECT DISTINCT SUM(Commande_stock.quantité)
							FROM Boisson
							INNER JOIN Commande_Stock
							ON Boisson.id = Commande_Stock.idBoissonStock
							WHERE NEW.idBoissonStock == Boisson.id
							GROUP BY Boisson.id
							ORDER BY Boisson.nom)) THEN
			RETURN NEW;
		ELSE
			RAISE EXCEPTION 'Not enough stock';
		END IF;
 		RETURN NULL;
	END;
$BODY$;

CREATE OR REPLACE TRIGGER check_before_insert_or_update_commande_stock
BEFORE INSERT 
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION check_disponibilité_boisson();*/

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

CREATE OR REPLACE TRIGGER check_before_insert_or_update_StockChillout
BEFORE INSERT OR UPDATE 
ON StockChillout
FOR EACH ROW
EXECUTE FUNCTION check_element_in_fournisseur();
