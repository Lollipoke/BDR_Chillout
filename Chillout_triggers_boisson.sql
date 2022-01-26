/*=============================== Check insertion annee Vin TRIGGER ==========================*/
CREATE OR REPLACE FUNCTION function_check_annee_vin() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    BEGIN
    IF NEW.année <= CAST(EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS SMALLINT) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Invalid annee';
	END IF;
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_dateHeure_before_insert_or_update_Commande
BEFORE INSERT OR UPDATE
ON Vin
FOR EACH ROW
EXECUTE FUNCTION function_check_annee_vin();

