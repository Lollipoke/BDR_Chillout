

/*============================ STATISTICS DU CHILLOUT ================================*/
/*==== Lister les quantités des boissons en stock du chillout ===== */
SELECT Boisson.id, Boisson.nom, Boisson.contenance, SUM(Commande_Stock.quantité) AS quantiteDisponible
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
WHERE Commande.commandeFournisseur = 'TRUE' AND Boisson.disponibilité = 'TRUE'
GROUP BY Boisson.id
ORDER BY Boisson.id ASC;

/*============================ STATISTICS POUR CHAQUE MEMBRE ================================*/

/* === Dépense total === */
SELECT SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1;

/* === Dépense total par boisson === */
SELECT Boisson.id, Boisson.nom, SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
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
GROUP BY Boisson.id;

/* === [WIP] Dépense total par Catégorie === */
SELECT Boisson.id, Boisson.nom, SUM(Commande_Stock.quantité) AS quantitCommandé, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS prixTotal
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
GROUP BY Boisson.id;

/* === Dépense Moyenne Hebdo === */
SELECT ROUND(AVG(Commande_Stock.quantité), 2) AS quantitéMoyenne, ROUND(AVG(Commande_Stock.quantité * StockChillout.prixDeVente), 2) AS depenseMoyenne
FROM Commande_Stock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1 AND EXTRACT('week' FROM Commande.dateHeure) = EXTRACT('week' FROM CURRENT_TIMESTAMP);

/* === Dépense Moyenne Mensuelle === */
SELECT ROUND(AVG(Commande_Stock.quantité), 2) AS quantitéMoyenne, ROUND(AVG(Commande_Stock.quantité * StockChillout.prixDeVente), 2) AS depenseMoyenne
FROM Commande_Stock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1 AND EXTRACT(month FROM Commande.dateHeure) = EXTRACT(month FROM CURRENT_TIMESTAMP);

/* === Dépense Moyenne Annuelle === */
SELECT ROUND(AVG(Commande_Stock.quantité), 2) AS quantitéMoyenne, ROUND(AVG(Commande_Stock.quantité * StockChillout.prixDeVente), 2) AS depenseMoyenne
FROM Commande_Stock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1 AND EXTRACT(year FROM Commande.dateHeure) = EXTRACT(year FROM CURRENT_TIMESTAMP);

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

/* === Dépense total hebdomadaire === */
SELECT SUM(Commande_Stock.quantité) AS quantitéTotale, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS dépenseTotale
FROM Commande_Stock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1 AND EXTRACT('week' FROM Commande.dateHeure) = EXTRACT('week' FROM CURRENT_TIMESTAMP);

/* === Dépense total Mensuelle === */
SELECT SUM(Commande_Stock.quantité) AS quantitéTotale, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS dépenseTotale
FROM Commande_Stock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1 AND EXTRACT(month FROM Commande.dateHeure) = EXTRACT(month FROM CURRENT_TIMESTAMP);

/* === Dépense total Annuelle === */
SELECT SUM(Commande_Stock.quantité) AS quantitéTotale, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS dépenseTotale
FROM Commande_Stock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1 AND EXTRACT(year FROM Commande.dateHeure) = EXTRACT(year FROM CURRENT_TIMESTAMP);

/* === Boisson la plus commandé entre 2 date === */
SELECT Boisson.id, Boisson.nom, Boisson.contenance, SUM(Commande_Stock.quantité) AS quantitéTotale, SUM(Commande_Stock.quantité * StockChillout.prixDeVente) AS dépenseTotale
FROM Boisson
INNER JOIN Commande_Stock
	ON Boisson.id = Commande_Stock.idBoissonStock
FROM Commande_Stock
INNER JOIN StockChillout
	ON Commande_Stock.idBoissonStock = StockChillout.idBoissonStock
INNER JOIN Commande
	ON Commande_Stock.idCommande = Commande.id
INNER JOIN Personne
	ON Commande.idPersonne = Personne.id
WHERE Personne.id = 1 AND Commande.dateHeure BETWEEN '2022-01-20' AND '2022-01-29';
GROUP BY Boisson.id
ORDER BY Boisson.id DESC
LIMIT 1;



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
	