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
INSERT INTO BoissonAlcoolisée VALUES (6, 4,8, 16, 'Suisse', 'Berne');
INSERT INTO BoissonAlcoolisée VALUES (7, 5.4, 16, 'Ecosse', 'Highland');
INSERT INTO BoissonAlcoolisée VALUES (8, 6.1, 18, 'Suisse', 'Valais');
INSERT INTO BoissonAlcoolisée VALUES (9, 4.8, 'Suisse', 'Fribourg');
INSERT INTO BoissonAlcoolisée VALUES (10, 5.0, 'Suisse', 'Vaud');
INSERT INTO BoissonAlcoolisée VALUES (11, 8.0, 'Belgique', 'Namur');
INSERT INTO BoissonAlcoolisée VALUES (12, 6.1, 'Pays-Bas', 'Hollande');
/*add by yaya*/
INSERT INTO BoissonAlcoolisée VALUES (13, 4.8, 16, 'Irlande', 'Dublin');
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
INSERT INTO Bière VALUES (12, 'Stout');


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
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Lavalée', 'Thibault', '2001-09-13', '2021-11-03', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Lauzier', 'Laetitia', '1997-05-12', '2021-06-07', true);
INSERT INTO Personne (nom, prénom, dateNaissance, dateArrivée, actif) VALUES ('Leroy', 'Arnaud', '2002-05-25', '2019-08-14', false);


/*================ Filière ====================*/

INSERT INTO Filière VALUES ('COMEM+');
INSERT INTO Filière VALUES ('EC+G');
INSERT INTO Filière VALUES ('HEG');
INSERT INTO Filière VALUES ('TIC');
INSERT INTO Filière VALUES ('TIN');


/*================ Membre Filière ====================*/

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
INSERT INTO Evaluation(1, 1, 4, '2021-03-13')
INSERT INTO Evaluation(1, 2, 4, '2021-03-13')
INSERT INTO Evaluation(2, 2, 5, '2021-03-13')
INSERT INTO Evaluation(1, 3, 4, '2018-07-11')
INSERT INTO Evaluation(1, 4, 4, '2019-04-11')


/*================ Fournisseur ====================*/

INSERT INTO Fournisseur VALUES ('Ammstein', 'Rue des Champignons',  34, , ,);


/*================ Boisson Fournisseur ====================*/


/*================ Stock ====================*/


/*================ Stock Chillout ====================*/


/*================ Stock Fournisseur ====================*/


/*================ Commande ====================*/


/*================ Commande Stock ====================*/