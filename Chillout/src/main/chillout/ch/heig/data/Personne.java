package ch.heig.data;

import java.sql.Date;

public class Personne {
    private final int id;
    private final String nom;
    private final String prénom;
    private final Date dateNaissance;
    private final Date dateArrivée;
    private final boolean actif;

    public Personne(int id, String nom, String prénom, Date dateNaissance, Date dateArrivée, boolean actif) {
        this.id = id;
        this.nom = nom;
        this.prénom = prénom;
        this.dateNaissance = dateNaissance;
        this.dateArrivée = dateArrivée;
        this.actif = actif;
    }

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public String getPrénom() {
        return prénom;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public Date getDateArrivée() {
        return dateArrivée;
    }

    public boolean getActif() {
        return actif;
    }
}
