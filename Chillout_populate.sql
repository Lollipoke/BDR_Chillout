-- BDR Projet Chillout
-- Auteur:  Alen Bijelic, Mélissa Gehring, Yanik Lange
-- Date:    11.01.2022

set client_encoding to 'utf8';

/*================ Boisson ====================*/

/* - Soft - */

INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Coca-Cola', 450, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Nestea citron', 500, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Nestea pêche', 500, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Sprite', 330, true);

/* - Bière - */

INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Swaf', 330, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Farmer blanche', 500, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Punk IPA', 330, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('PornStar', 330, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Cardinal', 330, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Boxer', 250, false);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Chouffe', 330, false);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Heineken', 330, false);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Guinness', 500, true);

/* - Vin - */ 

INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Chasselas', 100, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Mateus', 90, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Fendant', 100, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Bordeaux', 90, true);
INSERT INTO Boisson (nom, contenance, disponibilité) VALUES ('Pinot gris', 100, true);


/*================ Boisson soft ====================*/

INSERT INTO BoissonSoft VALUES (1);
INSERT INTO BoissonSoft VALUES (2);
INSERT INTO BoissonSoft VALUES (3);
INSERT INTO BoissonSoft VALUES (4);


/*================ Boisson alcoolisée ====================*/

/* - Bières - */

INSERT INTO BoissonAlcoolisée VALUES (5, 4.8, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée VALUES (6, 4.8, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée VALUES (7, 5.4, 16, 'Ecosse', 'Highland');
INSERT INTO BoissonAlcoolisée VALUES (8, 6.1, 18, 'Suisse', 'Valais');
INSERT INTO BoissonAlcoolisée VALUES (9, 4.8, 'Suisse', 'Fribourg');
INSERT INTO BoissonAlcoolisée VALUES (10, 5.0, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée VALUES (11, 8.0, 'Belgique', 'Namur');
INSERT INTO BoissonAlcoolisée VALUES (12, 6.1, 'Pays-Bas', 'Hollande');
INSERT INTO BoissonAlcoolisée VALUES (13, 8.8, 'Irlande', 'Galway');

/* - Vin - */

INSERT INTO BoissonAlcoolisée VALUES (14, 10.1, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée VALUES (15, 11.0, 'Portugais', 'Algarve');
INSERT INTO BoissonAlcoolisée VALUES (16, 12.0, 'Suisse', 'Valais');
INSERT INTO BoissonAlcoolisée VALUES (17, 13.3, 'France', 'Bordeaux');
INSERT INTO BoissonAlcoolisée VALUES (18, 16.1, 'Pays-Bas', 'Hollande');


/*================ Bière ====================*/

INSERT INTO Bière VALUES (5, 'Blonde');
INSERT INTO Bière VALUES (6, 'Blanche');
INSERT INTO Bière VALUES (7, 'IPA');
INSERT INTO Bière VALUES (8, 'Blonde');
INSERT INTO Bière VALUES (9, 'Blonde');
INSERT INTO Bière VALUES (10, 'Blonde');
INSERT INTO Bière VALUES (11, 'IPA');
INSERT INTO Bière VALUES (12, 'Blonde');
INSERT INTO Bière VALUES (13, 'Stout');


/*================ Vin ====================*/

INSERT INTO Vin VALUES (14, 'Blanc', 2011);
INSERT INTO Vin VALUES (15, 'Rosé', 2011);
INSERT INTO Vin VALUES (16, 'Blanc', 2013);
INSERT INTO Vin VALUES (17, 'Rouge', 1983);
INSERT INTO Vin VALUES (18, 'Blanc', 2008);


/*================ Personne ====================*/

/* - Membres - */

INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Dylan', 'Bob', '1993-12-10', '2021-11-03', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Hammond', 'Yvonne', '1993-12-10', '2021-11-03', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Hammond', 'Cerise', '2000-10-20', '2021-07-01', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Monjeau', 'Hélène', '2005-05-30', '2021-07-01', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Boileau', 'Xavier', '2000-10-20', '2020-03-19', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Charest', 'Xavier', '1996-02-28', '2019-04-07', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Leroy', 'Raoul', '2007-08-21', '2020-09-02', false);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Jolicoeur', 'Patricia', '1998-12-14', '2021-11-29', false);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Sansouci', 'Arnaud', '1999-06-21', '2022-01-03', false);

/* - Staff - */

INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Martel', 'Laurène', '2001-09-13', '2021-11-03', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Lavalée', 'Thibault', '1998-12-14', '2020-06-07', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Lauzier', 'Laetitia', '1997-05-12', '2021-06-07', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Leroy', 'Arnaud', '2002-05-25', '2019-08-14', false);


/*================ Filière ====================*/

INSERT INTO Filière VALUES ('COMEM+');
INSERT INTO Filière VALUES ('EC+G');
INSERT INTO Filière VALUES ('HEG');
INSERT INTO Filière VALUES ('TIC');
INSERT INTO Filière VALUES ('TIN');


/*================ Membre ====================*/

INSERT INTO Membre VALUES (1, 'COMEM+');
INSERT INTO Membre VALUES (2, 'TIC');
INSERT INTO Membre VALUES (3, 'TIC');
INSERT INTO Membre VALUES (4, 'TIC');
INSERT INTO Membre VALUES (5, 'TIN');
INSERT INTO Membre VALUES (6, 'EC+G');
INSERT INTO Membre VALUES (7, 'TIN'); 
INSERT INTO Membre VALUES (8, 'EC+G');
INSERT INTO Membre VALUES (9, 'TIC');


/*================ Staff ====================*/

INSERT INTO Staff VALUES (10);
INSERT INTO Staff VALUES (11);
INSERT INTO Staff VALUES (12);
INSERT INTO Staff VALUES (13);
INSERT INTO Staff VALUES (6);
INSERT INTO Staff VALUES (7);


/*================ Evaluation ====================*/
/* TODO check les dates d'évaluations avec dateArrivée des Membres */
INSERT INTO Evaluation(1, 1, 4, '2021-03-13');
INSERT INTO Evaluation(1, 2, 4, '2021-03-13');
INSERT INTO Evaluation(5, 2, 5, '2021-03-13');
INSERT INTO Evaluation(1, 3, 4, '2018-07-11');
INSERT INTO Evaluation(1, 4, 4, '2019-04-11');
INSERT INTO Evaluation(5, 4, 5, '2021-03-13');
INSERT INTO Evaluation(1, 5, 4, '2018-09-01');
/*INSERT INTO Evaluation(1, 6, 4, '2019-04-10');*/ /* Membre actif qui n'a pas noté */


/*================ Fournisseur ====================*/

INSERT INTO Fournisseur VALUES ('Ammstein', 'Rue des Champignons',  34, 1400, 'Yverdon-les-Bains', 4.9);
INSERT INTO Fournisseur VALUES ('Landi', 'Impasse de la bonne affaire', 17, 1400, 'Yverdon-les-Bains', 0.0);
INSERT INTO Fournisseur VALUES ('Alloboissons', 'Route du Bois',  3, 1753, 'Matran', 7.9);
INSERT INTO Fournisseur VALUES ('Aligro', 'Avenue de la Concorde',  6, 1022, 'Chavannes-près-Renens', 4.9);
INSERT INTO Fournisseur VALUES ('Use Less Eco', 'Chemin du port', 15, 1400, 'Yverdon-les-Bains', 2.9);


/*================ Boisson Fournisseur ====================*/

INSERT INTO Boisson_Fournisseur VALUES (1, 'Ammstein', 1.0);
INSERT INTO Boisson_Fournisseur VALUES (2, 'Ammstein', 1.2);
INSERT INTO Boisson_Fournisseur VALUES (3, 'Ammstein', 1.2);
INSERT INTO Boisson_Fournisseur VALUES (4, 'Ammstein', 1.4);
INSERT INTO Boisson_Fournisseur VALUES (5, 'Ammstein', 3.0);
INSERT INTO Boisson_Fournisseur VALUES (6, 'Ammstein', 3.2);
INSERT INTO Boisson_Fournisseur VALUES (7, 'Ammstein', 2.0);
INSERT INTO Boisson_Fournisseur VALUES (8, 'Ammstein', 4.8);
INSERT INTO Boisson_Fournisseur VALUES (9, 'Ammstein', 4.8);
INSERT INTO Boisson_Fournisseur VALUES (10, 'Ammstein', 1.9);
INSERT INTO Boisson_Fournisseur VALUES (11, 'Ammstein', 2.7);
INSERT INTO Boisson_Fournisseur VALUES (12, 'Ammstein', 2.8);
INSERT INTO Boisson_Fournisseur VALUES (13, 'Ammstein', 3.4);
INSERT INTO Boisson_Fournisseur VALUES (14, 'Ammstein', 5.7);
INSERT INTO Boisson_Fournisseur VALUES (15, 'Ammstein', 2.1);
INSERT INTO Boisson_Fournisseur VALUES (16, 'Ammstein', 3.0);
INSERT INTO Boisson_Fournisseur VALUES (17, 'Ammstein', 14.0);
INSERT INTO Boisson_Fournisseur VALUES (18, 'Ammstein', 10.0);
INSERT INTO Boisson_Fournisseur VALUES (1, 'Landi', 1.0);
INSERT INTO Boisson_Fournisseur VALUES (3, 'Landi', 1.3);
INSERT INTO Boisson_Fournisseur VALUES (5, 'Landi', 3.3);
INSERT INTO Boisson_Fournisseur VALUES (7, 'Landi', 1.5);
INSERT INTO Boisson_Fournisseur VALUES (9, 'Landi', 5.0);
INSERT INTO Boisson_Fournisseur VALUES (11, 'Landi', 2.7);
INSERT INTO Boisson_Fournisseur VALUES (13, 'Landi', 3.0);
INSERT INTO Boisson_Fournisseur VALUES (15, 'Landi', 2.2);
INSERT INTO Boisson_Fournisseur VALUES (17, 'Landi', 12.0);
INSERT INTO Boisson_Fournisseur VALUES (1, 'Alloboissons', 0.9);
INSERT INTO Boisson_Fournisseur VALUES (2, 'Alloboissons', 1.4);
INSERT INTO Boisson_Fournisseur VALUES (3, 'Alloboissons', 1.2);
INSERT INTO Boisson_Fournisseur VALUES (4, 'Alloboissons', 1.7);
INSERT INTO Boisson_Fournisseur VALUES (5, 'Alloboissons', 2.0);
INSERT INTO Boisson_Fournisseur VALUES (6, 'Alloboissons', 3.7);
INSERT INTO Boisson_Fournisseur VALUES (7, 'Alloboissons', 2.1);
INSERT INTO Boisson_Fournisseur VALUES (8, 'Alloboissons', 5.2);
INSERT INTO Boisson_Fournisseur VALUES (9, 'Alloboissons', 5.1);
INSERT INTO Boisson_Fournisseur VALUES (1, 'Aligro', 1.1);
INSERT INTO Boisson_Fournisseur VALUES (5, 'Aligro', 2.8);
INSERT INTO Boisson_Fournisseur VALUES (10, 'Aligro', 1.3);
INSERT INTO Boisson_Fournisseur VALUES (11, 'Aligro', 2.2);
INSERT INTO Boisson_Fournisseur VALUES (15, 'Aligro', 2.0);


/*================ Commande ====================*/

/* - Fournisseur - */

INSERT INTO Commande (dateHeure, idPersonne) VALUES ('12.01.2022', 10);
INSERT INTO Commande (dateHeure, idPersonne) VALUES ('01.01.2022', 11);
INSERT INTO Commande (dateHeure, idPersonne) VALUES ('31.12.2021', 12);
INSERT INTO Commande (dateHeure, idPersonne) VALUES ('21.12.2021', 6);

/* - Client - */



/*================ Stock ====================*/

INSERT INTO Stock VALUES (1, '31.02.2023');
INSERT INTO Stock VALUES (2, '31.02.2023');
INSERT INTO Stock VALUES (2, '31.12.2021');
INSERT INTO Stock VALUES (3, '12.01.2022');
INSERT INTO Stock VALUES (4, '31.02.2023');
INSERT INTO Stock VALUES (5, '12.01.2023');
INSERT INTO Stock VALUES (5, '12.01.2022');
INSERT INTO Stock VALUES (5, '31.12.2021');
INSERT INTO Stock VALUES (6, '12.01.2023');
INSERT INTO Stock VALUES (7, '31.02.2023');
INSERT INTO Stock VALUES (8, '31.02.2023');
INSERT INTO Stock VALUES (9, '31.02.2023');
/*INSERT INTO Stock VALUES (10, '31.02.2023');
INSERT INTO Stock VALUES (11, '31.02.2023');
INSERT INTO Stock VALUES (12, '31.02.2023');*/ /* pas dispo */
INSERT INTO Stock VALUES (13, '31.02.2023');
INSERT INTO Stock VALUES (14, '31.02.2023');
INSERT INTO Stock VALUES (15, '31.02.2023');
INSERT INTO Stock VALUES (16, '31.02.2023');
INSERT INTO Stock VALUES (17, '31.02.2023');
INSERT INTO Stock VALUES (18, '31.12.2021');

/*================ Stock Chillout ====================*/
/* TODO faire attention à seulement insérer des couples idBoisson, date qui sont
dans Stock */
INSERT INTO StockChillout VALUES (1, '12.01.2022', 1.5);
INSERT INTO StockChillout VALUES (1, '31.02.2023', 2.0);
INSERT INTO StockChillout VALUES (2, '31.02.2023', 1.5);
INSERT INTO StockChillout VALUES (4, '31.02.2023', 1.6);
INSERT INTO StockChillout VALUES (5, '12.01.2023', 4.2);
INSERT INTO StockChillout VALUES (5, '12.01.2022', 3.7);
INSERT INTO StockChillout VALUES (5, '31.12.2021', 3.2);
INSERT INTO StockChillout VALUES (7, '31.02.2023', 2.3);

/*================ Stock Fournisseur ====================*/
/* TODO vérifier que le fournisseur fournit la bière */
INSERT INTO StockFournisseur VALUES (1, '31.02.2023', 10, '');
INSERT INTO StockFournisseur VALUES (2, '31.02.2023', 10, '');
INSERT INTO StockFournisseur VALUES (2, '31.12.2021', 10);
INSERT INTO StockFournisseur VALUES (3, '12.01.2022', 10);
INSERT INTO StockFournisseur VALUES (4, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (5, '12.01.2023', 10);
INSERT INTO StockFournisseur VALUES (5, '12.01.2022', 10);
INSERT INTO StockFournisseur VALUES (5, '31.12.2021', 10);
INSERT INTO StockFournisseur VALUES (6, '12.01.2023', 10);
INSERT INTO StockFournisseur VALUES (7, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (8, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (9, '31.02.2023', 10);
/*INSERT INTO StockFournisseur VALUES (10, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (11, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (12, '31.02.2023', 10);*/ /* pas dispo */
INSERT INTO StockFournisseur VALUES (13, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (14, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (15, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (16, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (17, '31.02.2023', 10);
INSERT INTO StockFournisseur VALUES (18, '31.12.2021', 10);


/*================ Commande Stock ====================*/

INSERT INTO Commande_Stock VALUES (1, '12.01.2022', 10);
INSERT INTO Commande_Stock VALUES (2, '31.02.2023', 11);
INSERT INTO Commande_Stock VALUES (3, '31.02.2023', 12);
INSERT INTO Commande_Stock VALUES (4, '31.02.2023', 6);
INSERT INTO Commande_Stock VALUES (4, '12.01.2023', 6);
INSERT INTO Commande_Stock VALUES (4, '12.01.2022', 6);
INSERT INTO Commande_Stock VALUES (4, '31.12.2021', 6);
INSERT INTO Commande_Stock VALUES (4, '31.02.2023', 6);