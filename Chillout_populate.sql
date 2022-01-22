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

INSERT INTO BoissonSoft (idBoisson) VALUES (1);
INSERT INTO BoissonSoft (idBoisson) VALUES (2);
INSERT INTO BoissonSoft (idBoisson) VALUES (3);
INSERT INTO BoissonSoft (idBoisson) VALUES (4);


/*================ Boisson alcoolisée ====================*/

/* - Bières - */

INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (5, 4.8, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (6, 4.8, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (7, 5.4, 16, 'Ecosse', 'Highland');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (8, 6.1, 18, 'Suisse', 'Valais');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (9, 4.8, 16, 'Suisse', 'Fribourg');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (10, 5.0, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (11, 8.0, 16, 'Belgique', 'Namur');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (12, 6.1, 16, 'Pays-Bas', 'Hollande');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (13, 8.8, 16, 'Irlande', 'Galway');

/* - Vin - */

INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (14, 10.1, 16, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (15, 11.0, 16, 'Portugais', 'Algarve');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (16, 12.0, 16, 'Suisse', 'Valais');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (17, 13.3, 16, 'France', 'Bordeaux');
INSERT INTO BoissonAlcoolisée (idBoisson, tauxAlcool, ageMin, pays, région) VALUES (18, 16.1, 18, 'Pays-Bas', 'Hollande');


/*================ Bière ====================*/

INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (5, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (6, 'Blanche');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (7, 'IPA');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (8, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (9, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (10, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (11, 'IPA');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (12, 'Blonde');
INSERT INTO Bière (idBoissonAlcoolisée, type) VALUES (13, 'Stout');


/*================ Vin ====================*/

INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (14, 'Blanc', 2011);
INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (15, 'Rosé', 2011);
INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (16, 'Blanc', 2013);
INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (17, 'Rouge', 1983);
INSERT INTO Vin (idBoissonAlcoolisée, type, année) VALUES (18, 'Blanc', 2008);


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

INSERT INTO Filière (libellé) VALUES ('COMEM+');
INSERT INTO Filière (libellé) VALUES ('EC+G');
INSERT INTO Filière (libellé) VALUES ('HEG');
INSERT INTO Filière (libellé) VALUES ('TIC');
INSERT INTO Filière (libellé) VALUES ('TIN');


/*================ Membre ====================*/

INSERT INTO Membre (idPersonne, libelléFilière) VALUES (1, 'COMEM+');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (2, 'TIC');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (3, 'TIC');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (4, 'TIC');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (5, 'TIN');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (6, 'EC+G');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (7, 'TIN'); 
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (8, 'EC+G');
INSERT INTO Membre (idPersonne, libelléFilière) VALUES (9, 'TIC');


/*================ Staff ====================*/

INSERT INTO Staff (idPersonne) VALUES (10);
INSERT INTO Staff (idPersonne) VALUES (11);
INSERT INTO Staff (idPersonne) VALUES (12);
INSERT INTO Staff (idPersonne) VALUES (13);
INSERT INTO Staff (idPersonne) VALUES (6);
INSERT INTO Staff (idPersonne) VALUES (7);


/*================ Evaluation ====================*/
/* TODO check les dates d'évaluations avec dateArrivée des Membres */
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 1, 4, '2021-03-13');
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 2, 4, '2021-03-13');
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (5, 2, 5, '2021-03-13');
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 3, 4, '2018-07-11');
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 4, 4, '2019-04-11');
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (5, 4, 5, '2021-03-13');
INSERT INTO Evaluation (idBoisson, idMembre, note, date) VALUES (1, 5, 4, '2018-09-01');
/*INSERT INTO Evaluation(1, 6, 4, '2019-04-10');*/ /* Membre actif qui n'a pas noté */


/*================ Fournisseur ====================*/

INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Ammstein', 'Rue des Champignons',  34, 1400, 'Yverdon-les-Bains', 4.9);
INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Landi', 'Impasse de la bonne affaire', 17, 1400, 'Yverdon-les-Bains', 0.0);
INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Alloboissons', 'Route du Bois',  3, 1753, 'Matran', 7.9);
INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Aligro', 'Avenue de la Concorde',  6, 1022, 'Chavannes-près-Renens', 4.9);
INSERT INTO Fournisseur (nom, nomRue, numRue, codePostal, localité, fraisLivraison) VALUES ('Use Less Eco', 'Chemin du port', 15, 1400, 'Yverdon-les-Bains', 2.9);


/*================ Boisson Fournisseur ====================*/

INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (1, 'Ammstein', 1.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (2, 'Ammstein', 1.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (3, 'Ammstein', 1.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (4, 'Ammstein', 1.4);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (5, 'Ammstein', 3.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (6, 'Ammstein', 3.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (7, 'Ammstein', 2.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (8, 'Ammstein', 4.8);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (9, 'Ammstein', 4.8);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (10, 'Ammstein', 1.9);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (11, 'Ammstein', 2.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (12, 'Ammstein', 2.8);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (13, 'Ammstein', 3.4);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (14, 'Ammstein', 5.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (15, 'Ammstein', 2.1);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (16, 'Ammstein', 3.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (17, 'Ammstein', 14.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (18, 'Ammstein', 10.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (1, 'Landi', 1.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (3, 'Landi', 1.3);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (5, 'Landi', 3.3);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (7, 'Landi', 1.5);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (9, 'Landi', 5.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (11, 'Landi', 2.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (13, 'Landi', 3.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (15, 'Landi', 2.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (17, 'Landi', 12.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (1, 'Alloboissons', 0.9);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (2, 'Alloboissons', 1.4);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (3, 'Alloboissons', 1.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (4, 'Alloboissons', 1.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (5, 'Alloboissons', 2.0);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (6, 'Alloboissons', 3.7);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (7, 'Alloboissons', 2.1);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (8, 'Alloboissons', 5.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (9, 'Alloboissons', 5.1);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (1, 'Aligro', 1.1);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (5, 'Aligro', 2.8);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (10, 'Aligro', 1.3);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (11, 'Aligro', 2.2);
INSERT INTO Boisson_Fournisseur (idBoisson, nomFournisseur, prixUnitaire) VALUES (15, 'Aligro', 2.0);


/*================ Commande ====================*/

/* - Fournisseur - */

INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('12.01.2022', 10, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('01.01.2022', 11, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('31.12.2021', 12, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 6, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 6, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 7, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 6, TRUE);
INSERT INTO Commande (dateHeure, idPersonne, commandeFournisseur) VALUES ('21.12.2021', 3, TRUE);
/* - Client - */



/*================ Stock ====================*/

INSERT INTO Stock (idBoisson, datePéremption) VALUES (1, '13.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (1, '14.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (2, '13.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (2, '31.12.2021');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (3, '12.01.2022');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (4, '18.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (5, '12.01.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (5, '12.01.2022');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (5, '31.12.2021');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (6, '12.01.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (7, '12.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (8, '16.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (9, '16.02.2023');
/*INSERT INTO Stock (idBoisson, datePéremption) VALUES (10, '31.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (11, '31.02.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (12, '31.02.2023');*/ /* pas dispo */
INSERT INTO Stock (idBoisson, datePéremption) VALUES (13, '31.03.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (14, '31.03.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (15, '31.05.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (16, '31.05.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (17, '31.07.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (17, '01.08.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (17, '02.08.2023');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (18, '31.12.2021');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (18, '01.01.2022');
INSERT INTO Stock (idBoisson, datePéremption) VALUES (18, '02.01.2022');


/*================ Stock Chillout ====================*/
/* TODO faire attention à seulement insérer des couples idBoisson, date qui sont dans Stock */
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (1, '13.02.2023', 1.5);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (1, '14.02.2023', 1.5);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (2, '13.02.2023', 1.5);
/*INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (3, '12.01.2022', 1.5);*/ 
/* pas dispo au chillout mais dispo chez fournisseur */
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (4, '18.02.2023', 1.6);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (5, '12.01.2023', 4.2);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (5, '12.01.2022', 3.7);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (5, '31.12.2021', 3.2);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (7, '12.02.2023', 2.3);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (8, '16.02.2023', 5.2);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (13, '31.03.2023', 3.0);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (14, '31.03.2023', 6.3);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (15, '31.05.2023', 2.3);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (16, '31.05.2023', 3.5);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (17, '31.07.2023', 16.0);
INSERT INTO StockChillout (idBoissonStock, datePéremptionStock, prixDeVente) VALUES (18, '31.12.2021', 14.0);

/*================ Stock Fournisseur ====================*/
/* TODO vérifier que le fournisseur fournit la bière */
/* TODO faire attention à seulement insérer des couples idBoisson, date qui sont dans Stock */
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (1, '13.02.2023', 10, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (2, '13.02.2023', 2, 'Ammstein');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (3, '12.01.2022', 50, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (4, '18.02.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (5, '12.01.2023', 20, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (5, '12.01.2022', 10, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (5, '31.12.2021', 10, 'Aligro');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (6, '12.01.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (7, '12.02.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (8, '16.02.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (9, '16.02.2023', 2, 'Landi');
/*INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (10, '31.02.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (11, '31.02.2023', 2, 'Ammstein');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (12, '31.02.2023', 2, 'Landi');*/ /* pas dispo */
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (13, '31.03.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (14, '31.03.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (15, '31.05.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (16, '31.05.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (17, '31.07.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (17, '01.08.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (17, '02.08.2023', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (18, '31.12.2021', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (18, '01.01.2022', 2, 'Landi');
INSERT INTO StockFournisseur (idBoissonStock, datePéremptionStock, quantité, nomFournisseur) VALUES (18, '02.01.2022', 2, 'Landi');


/*================ Commande Stock ====================*/

INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (1, 1, '13.02.2023', 10);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (2, 1, '14.02.2023', 11);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (3, 2, '13.02.2023', 12);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (4, 2, '31.12.2021', 6);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (5, 3, '12.01.2022', 6);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (6, 4, '18.02.2023', 6);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (7, 5, '12.01.2023', 6);
INSERT INTO Commande_Stock (idCommande, idBoissonStock, datePéremptionStock, quantité) VALUES (8, 6, '12.01.2023', 6);