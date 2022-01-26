package ch.heig.data;

import java.sql.Date;

public class StockFournisseur extends Stock{
    private final Fournisseur fournisseur;

    public StockFournisseur(Boisson boisson, Date datePéremption, int quantité, Fournisseur fournisseur) {
        super(boisson, datePéremption, quantité);
        this.fournisseur = fournisseur;
    }

    public Fournisseur getFournisseur() {
        return fournisseur;
    }
}
