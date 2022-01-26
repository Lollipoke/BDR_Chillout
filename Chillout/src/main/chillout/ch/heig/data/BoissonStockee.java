package ch.heig.data;

import java.sql.Date;

public class BoissonStockee extends Boisson{
    private final Date datePéremption;

    public BoissonStockee(int id, String nom, int contenance, boolean disponibilité, Date datePéremption) {
        super(id, nom, contenance, disponibilité);
        this.datePéremption = datePéremption;
    }

    public Date getDatePéremption() {
        return datePéremption;
    }
}
