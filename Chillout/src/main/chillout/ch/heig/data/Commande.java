package ch.heig.data;

import java.sql.Timestamp;

public class Commande {
    private final int id;
    private final Timestamp dateHeure;
    private final Personne personne;
    private final boolean commandeFournisseur;


    public Commande(int id, Timestamp dateHeure, Personne personne, boolean commandeFournisseur) {
        this.id = id;
        this.dateHeure = dateHeure;
        this.personne = personne;
        this.commandeFournisseur = commandeFournisseur;
    }

    public int getId() {
        return id;
    }

    public Timestamp getDateHeure() {
        return dateHeure;
    }

    public Personne getPersonne() {
        return personne;
    }

    public boolean isCommandeFournisseur() {
        return commandeFournisseur;
    }
}
