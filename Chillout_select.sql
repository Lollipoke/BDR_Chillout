

/*============================ STATISTICS DU CHILLOUT ================================*/
/*==== Lister les quantités des boissons en stock du chillout ===== */
/*SELECT Boisson.id, Boisson.nom, Boisson.contenance, SUM(Commande_Stock.quantité) AS quantiteDisponible
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
WHERE Commande.commandeFournisseur = 'TRUE' AND Boisson.disponibilité = 'TRUE'
GROUP BY Boisson.id
ORDER BY Boisson.id ASC;*/

/*============================ STATISTICS POUR CHAQUE MEMBRE ================================*/

/* === Dépense total === */
/*SELECT SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1;*/

/* === Dépense total par boisson === */
/*SELECT Boisson.id, Boisson.nom, SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1
GROUP BY Boisson.id;*/

/* === [WIP] Dépense total par Catégorie === */
/*SELECT Boisson.id, Boisson.nom, SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1
GROUP BY Boisson.id;*/

/* === Dépense total Journalière des 7 derniers jours=== */
SELECT Commande.dateHeure, SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1
GROUP BY Commande.dateHeure
ORDER BY Commande.dateHeure DESC
LIMIT 7;

/* === [WIP] Dépense total hebdomadaire === */
SELECT Commande.dateHeure, SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1
GROUP BY Commande.dateHeure
ORDER BY Commande.dateHeure DESC
LIMIT 7;

/* === [WIP] Dépense total hebdomadaire === */
SELECT Commande.dateHeure, SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1
GROUP BY Commande.dateHeure
ORDER BY Commande.dateHeure DESC
LIMIT 7;


/*SELECT *
FROM StockFournisseur, StockChillout
WHERE StockChillout.idBoissonStock = StockFournisseur.idBoissonStock AND StockChillout.datePéremptionStock = StockFournisseur.datePéremptionStock;*/

/*SELECT DISTINCT Boisson.id, Boisson.nom, SUM(Commande_stock.quantité)
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
WHERE Commande.commandeFournisseur = 'TRUE'
GROUP BY Boisson.id
ORDER BY SUM(Commande_stock.quantité) DESC;

SELECT DISTINCT Boisson.id, Boisson.nom, SUM(Commande_stock.quantité)
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
WHERE Commande.commandeFournisseur = 'False'
GROUP BY Boisson.id
ORDER BY SUM(Commande_stock.quantité) DESC;*/

/*SELECT *
FROM Commande_Stock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
WHERE Commande.commandeFournisseur = 'True';*/
	