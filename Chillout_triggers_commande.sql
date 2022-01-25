set client_encoding to 'UTF8';

/*=============================== Check insertion date TRIGGER ==========================*/
CREATE OR REPLACE FUNCTION function_check_dateHeure_commande() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$BODY$
    BEGIN
    IF new.dateHeure = to_timestamp(CURRENT_TIMESTAMP::text,'YYYY-MM-DD') THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Invalid dateHeure';
	END IF;
    END;
$BODY$;

CREATE OR REPLACE TRIGGER check_dateHeure_before_insert_or_update_Commande
AFTER INSERT OR UPDATE
ON Commande
FOR EACH ROW
EXECUTE FUNCTION function_check_dateHeure_commande();