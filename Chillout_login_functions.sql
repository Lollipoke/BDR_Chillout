CREATE OR REPLACE FUNCTION staff_exists(nomUser IN VARCHAR, idUser IN SMALLINT) RETURNS boolean
LANGUAGE plpgsql
AS
$BODY$
DECLARE staff_exists boolean;
BEGIN
    staff_exists := FALSE;

    IF EXISTS (SELECT 1 
        FROM Staff 
            INNER JOIN Personne 
                ON Personne.id = Staff.idPersonne 
        WHERE Staff.idPersonne = idUser AND Personne.nom = nomUser)
    THEN staff_exists := TRUE;
    END IF;
    RETURN staff_exists;    
END; 
$BODY$;


CREATE OR REPLACE FUNCTION membre_exists(nomUser IN VARCHAR, idUser IN SMALLINT) RETURNS boolean
LANGUAGE plpgsql
AS
$BODY$
DECLARE membre_exists boolean;
BEGIN
    membre_exists := FALSE;

    IF EXISTS (SELECT 1 
        FROM Membre
            INNER JOIN Personne 
                ON Personne.id = Membre.idPersonne 
        WHERE Membre.idPersonne = idUser AND Personne.nom = nomUser)
    THEN membre_exists := TRUE;
    END IF;
    RETURN membre_exists;    
END; 
$BODY$;