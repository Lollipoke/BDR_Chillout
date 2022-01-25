package ch.heig.data;

import java.sql.Date;

public class Membre extends Personne{
    private final String libelleFiliere;

    public Membre(int id, String nom, String prenom, Date dateNaissance, Date dateArrivee, boolean actif, String libelleFiliere) {
        super(id, nom, prenom, dateNaissance, dateArrivee, actif);
        this.libelleFiliere = libelleFiliere;
    }

    public String getLibelleFiliere() {
        return libelleFiliere;
    }
}
