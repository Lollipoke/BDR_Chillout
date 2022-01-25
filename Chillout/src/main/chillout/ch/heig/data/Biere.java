package ch.heig.data;

public class Biere extends BoissonAlcoolisee{
    private final String type;

    public Biere(int id, String nom, int contenance, boolean disponibilite, double tauxAlcool, int ageMin, String pays, String region, String type) {
        super(id, nom, contenance, disponibilite, tauxAlcool, ageMin, pays, region);
        this.type = type;
    }

    public String getType() {
        return type;
    }
}
