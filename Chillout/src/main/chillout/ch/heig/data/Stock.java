package ch.heig.data;

import java.sql.Date;

public class Stock {
    private final Boisson boisson;
    private final Date datePéremption;
    private final int quantité;

    public Stock(Boisson boisson, Date datePéremption, int quantité) {
        this.boisson = boisson;
        this.datePéremption = datePéremption;
        this.quantité = quantité;
    }

    public Boisson getBoisson() {
        return boisson;
    }

    public Date getDatePéremption() {
        return datePéremption;
    }

    public int getQuantité() {
        return quantité;
    }
}
