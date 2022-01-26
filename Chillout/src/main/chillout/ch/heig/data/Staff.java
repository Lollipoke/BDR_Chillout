package ch.heig.data;

import java.sql.Date;

public class Staff extends Personne{
    public Staff(int id, String nom, String prénom, Date dateNaissance, Date dateArrivée, boolean actif) {
        super(id, nom, prénom, dateNaissance, dateArrivée, actif);
    }
}
