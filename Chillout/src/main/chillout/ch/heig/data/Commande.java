package ch.heig.data;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class Commande {
    private final int id;
    private final Timestamp dateHeure;
    private final Personne personne;
    private final boolean commandeFournisseur;
    private Map<BoissonStockee, Integer> boissonsStockées;


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

    public boolean getCommandeFournisseur() {
        return commandeFournisseur;
    }

    public void setBoissonsStockées(Map<BoissonStockee, Integer> boissonsStockées) {
        this.boissonsStockées = boissonsStockées;
    }

    public Map<BoissonStockee, Integer> getBoissonsStockées() {
        return boissonsStockées;
    }
}
