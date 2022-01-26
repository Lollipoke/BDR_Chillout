package ch.heig.data;

public class Vin extends BoissonAlcoolisee {
    private final String type;
    private final int année;

    public Vin(int id, String nom, int contenance, boolean disponibilité, double tauxAlcool,
               int ageMin, String pays, String région, String type, int année) {
        super(id, nom, contenance, disponibilité, tauxAlcool, ageMin, pays, région);
        this.type = type;
        this.année = année;
    }

    public String getType() {
        return type;
    }

    public int getAnnée() {
        return année;
    }
}
