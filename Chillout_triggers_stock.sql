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
CREATE OR REPLACE FUNCTION check_disponibilité_boisson() RETURNS TRIGGER
LANGUAGE plpgsql
AS 
$BODY$
	DECLARE	
		quantiteChill integer;
		quantiteCommande integer;
	BEGIN
		SELECT vQuantitéStockChillout.quantité into quantiteChill
		FROM vQuantitéStockChillout;
	    /*SELECT Commande_Stock.quantité into quantiteCommande
		FROM Commande_Stock;*/
		IF (quantiteChill >= quantiteCommande) THEN
			--RAISE EXCEPTION 'Not enough stock';
			INSERT INTO Commande_Stock(idCommande, idBoissonStock, datePéremptionStock, quantité)
				VALUES (NEW.idCommande, NEW.idBoissonStock, NEW.datePéremptionStock, New.quantité);
		ELSIF (quantiteChill <= quantiteCommande) THEN
			--RAISE EXCEPTION 'Not enough stock';
		END IF;
 		RETURN NULL;
	END;
$BODY$;

CREATE OR REPLACE TRIGGER check_before_insert_or_update_commande_stock
BEFORE INSERT OR UPDATE 
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION check_disponibilité_boisson();
