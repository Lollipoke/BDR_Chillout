package ch.heig.data;

public class Biere extends BoissonAlcoolisee{
    private final String type;

    public Biere(int id, String nom, int contenance, boolean disponibilité, double tauxAlcool, int ageMin, String pays, String région, String type) {
        super(id, nom, contenance, disponibilité, tauxAlcool, ageMin, pays, région);
        this.type = type;
    }

    public String getType() {
        return type;
    }
}
