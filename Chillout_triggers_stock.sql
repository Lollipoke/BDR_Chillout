set client_encoding to 'UTF8';

/*=============================== Refill StockFournisseur TRIGGER ==========================*/
CREATE OR REPLACE FUNCTION refill_stockFournisseur() RETURNS TRIGGER
LANGUAGE plpgsql
AS 
$BODY$
	BEGIN
		EXECUTE ('UPDATE StockFournisseur SET quantité = 10 WHERE quantité < 1');
		RETURN NULL;
	END;
	
$BODY$;

CREATE OR REPLACE TRIGGER refill_after_insert_or_update_StockFournisseur
AFTER INSERT OR UPDATE 
ON StockFournisseur
FOR EACH ROW
EXECUTE FUNCTION refill_StockFournisseur();


/*=============================== [WIP] Quantité de boisson en stock suffisante pour quantité de boisson commandé TRIGGER ==========================*/
CREATE OR REPLACE FUNCTION check_disponibilité_boisson() RETURNS TRIGGER
LANGUAGE plpgsql
AS 
$BODY$
	BEGIN
		IF(NEW.idCommande = (SELECT Commande.id FROM Commande WHERE Commande.commandeFournisseur = 'False' LIMIT 1)) THEN
			IF EXISTS(SELECT SUM(Commande_Stock.quantité)
								FROM Commande_Stock
								INNER JOIN Commande
									ON Commande_Stock.idCommande = Commande.id
								WHERE Commande.commandeFournisseur = 'True' 
									AND NEW.idBoissonStock = Commande_Stock.idBoissonStock 
								HAVING (SUM(Commande_Stock.quantité) - (SELECT SUM(Commande_Stock.quantité)
																		FROM Commande_Stock
																		INNER JOIN Commande
																			ON Commande_Stock.idCommande = Commande.id
																		WHERE Commande.commandeFournisseur = 'False' 
																			AND NEW.idBoissonStock = Commande_Stock.idBoissonStock 
																		LIMIT 1)) >= NEW.quantité
								) THEN
				RETURN NEW;
			ELSE
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
