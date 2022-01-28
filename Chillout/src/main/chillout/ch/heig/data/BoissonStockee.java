package ch.heig.data;

import java.sql.Date;

public class BoissonStockee extends Boisson{
    private final Date datePéremption;
    private final int quantité;
    private String quantitéSouhaitée;

    public BoissonStockee(int id, String nom, int contenance, boolean disponibilité, Date datePéremption, int quantité) {
        super(id, nom, contenance, disponibilité);
        this.datePéremption = datePéremption;
        this.quantité = quantité;
        this.quantitéSouhaitée = "0";
    }

    public Date getDatePéremption() {
        return datePéremption;
    }

    public int getQuantité() {
        return quantité;
    }

    public String getQuantitéSouhaitée() {
        return quantitéSouhaitée;
    }

    public void setQuantitéSouhaitée(String quantitéSouhaitée) {
        this.quantitéSouhaitée = quantitéSouhaitée;
    }
}
