package ch.heig.data;

import java.sql.Date;

public class StockChillout extends Stock{
    private final double prixDeVente;

    public StockChillout(Boisson boisson, Date datePeremption, int quantite, double prixDeVente) {
        super(boisson, datePeremption, quantite);
        this.prixDeVente = prixDeVente;
    }

    public double getPrixDeVente() {
        return prixDeVente;
    }
}
