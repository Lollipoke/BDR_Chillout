package ch.heig.data;

public class Vin extends BoissonAlcoolisee {
    private final String type;
    private final int annee;

    public Vin(int id, String nom, int contenance, boolean disponibilite, double tauxAlcool, int ageMin, String pays, String region, String type, int annee) {
        super(id, nom, contenance, disponibilite, tauxAlcool, ageMin, pays, region);
        this.type = type;
        this.annee = annee;
    }

    public String getType() {
        return type;
    }

    public int getAnnee() {
        return annee;
    }
}
