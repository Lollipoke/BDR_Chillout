set client_encoding to 'UTF8';

/*=============================== Chillout stock quantity view ==========================*/
DROP VIEW IF EXISTS vQuantitéStockChillout;
CREATE VIEW vQuantitéStockChillout
AS
SELECT Boisson.id, Boisson.nom, SUM(Commande_stock.quantité) AS quantité
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
GROUP BY Boisson.id
ORDER BY Boisson.nom;
