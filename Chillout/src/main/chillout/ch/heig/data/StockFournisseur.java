package ch.heig.data;

import java.sql.Date;

public class StockFournisseur extends Stock{
    private final Fournisseur fournisseur;

    public StockFournisseur(Boisson boisson, Date datePeremption, int quantite, Fournisseur fournisseur) {
        super(boisson, datePeremption, quantite);
        this.fournisseur = fournisseur;
    }

    public Fournisseur getFournisseur() {
        return fournisseur;
    }
}
