package ch.heig.data;

import java.sql.Date;

public class Personne {
    private final int id;
    private final String nom;
    private final String prenom;
    private final Date dateNaissance;
    private final Date dateArrivee;
    private final boolean actif;

    public Personne(int id, String nom, String prenom, Date dateNaissance, Date dateArrivee, boolean actif) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.dateNaissance = dateNaissance;
        this.dateArrivee = dateArrivee;
        this.actif = actif;
    }

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public Date getDateArrivee() {
        return dateArrivee;
    }

    public boolean isActif() {
        return actif;
    }
}
