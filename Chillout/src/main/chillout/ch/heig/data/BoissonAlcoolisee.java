package ch.heig.data;

public class BoissonAlcoolisee extends Boisson {
    private final double tauxAlcool;
    private final int ageMin;
    private final String pays;
    private final String region;


    public BoissonAlcoolisee(int id, String nom, int contenance, boolean disponibilite, double tauxAlcool, int ageMin, String pays, String region) {
        super(id, nom, contenance, disponibilite);
        this.tauxAlcool = tauxAlcool;
        this.ageMin = ageMin;
        this.pays = pays;
        this.region = region;
    }

    public double getTauxAlcool() {
        return tauxAlcool;
    }

    public int getAgeMin() {
        return ageMin;
    }

    public String getPays() {
        return pays;
    }

    public String getRegion() {
        return region;
    }
}
