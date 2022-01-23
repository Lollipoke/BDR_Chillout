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
		quantitee smallint;
	BEGIN
	SELECT vQuantitéStockChillout.quantité INTO quantitee
		FROM vQuantitéStockChillout;
	    --WHERE vQuantitéStockChillout.id = NEW.idBoissonStock;
		raise notice 'Value: %', NEW.quantité;
		raise notice 'Value: %', quantitee; -- problem found : quantitee is null [WIP]
		IF (quantitee >= NEW.quantité) THEN
			INSERT INTO Commande_Stock(idCommande, idBoissonStock, datePéremptionStock, quantité)
				VALUES (NEW.idCommande, NEW.idBoissonStock, NEW.datePéremptionStock, New.quantité);
		ELSIF (quantitee < NEW.quantité) THEN
			RAISE EXCEPTION 'Not enough stock';
		END IF;
 		RETURN NULL;
	END;
$BODY$;

CREATE OR REPLACE TRIGGER check_before_insert_or_update_commande_stock
BEFORE INSERT 
ON Commande_Stock
FOR EACH ROW
EXECUTE FUNCTION check_disponibilité_boisson();
