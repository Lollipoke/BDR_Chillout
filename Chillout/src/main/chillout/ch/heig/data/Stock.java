package ch.heig.data;

import java.sql.Date;

public class Stock {
    private final Boisson boisson;
    private final Date datePeremption;
    private final int quantite;

    public Stock(Boisson boisson, Date datePeremption, int quantite) {
        this.boisson = boisson;
        this.datePeremption = datePeremption;
        this.quantite = quantite;
    }

    public Boisson getBoisson() {
        return boisson;
    }

    public Date getDatePeremption() {
        return datePeremption;
    }

    public int getQuantite() {
        return quantite;
    }
}
