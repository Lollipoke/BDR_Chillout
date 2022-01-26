package ch.heig.data;

import java.sql.Date;

public class Membre extends Personne{
    private final String libelléFilière;

    public Membre(int id, String nom, String prénom, Date dateNaissance, Date dateArrivée, boolean actif, String libelléFilière) {
        super(id, nom, prénom, dateNaissance, dateArrivée, actif);
        this.libelléFilière = libelléFilière;
    }

    public String getLibelléFilière() {
        return libelléFilière;
    }
}
