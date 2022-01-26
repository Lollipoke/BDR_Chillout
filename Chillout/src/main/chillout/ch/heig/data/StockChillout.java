package ch.heig.data;

import java.sql.Date;

public class StockChillout extends Stock{
    private final double prixDeVente;

    public StockChillout(Boisson boisson, Date datePéremption, int quantité, double prixDeVente) {
        super(boisson, datePéremption, quantité);
        this.prixDeVente = prixDeVente;
    }

    public double getPrixDeVente() {
        return prixDeVente;
    }
}
