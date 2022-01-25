package ch.heig.data;

import java.sql.Date;

public class Staff extends Personne{
    public Staff(int id, String nom, String prenom, Date dateNaissance, Date dateArrivee, boolean actif) {
        super(id, nom, prenom, dateNaissance, dateArrivee, actif);
    }
}
