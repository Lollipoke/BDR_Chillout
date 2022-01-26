package ch.heig.data;

public class BoissonAlcoolisee extends Boisson {
    private final double tauxAlcool;
    private final int ageMin;
    private final String pays;
    private final String région;


    public BoissonAlcoolisee(int id, String nom, int contenance, boolean disponibilite,
                             double tauxAlcool, int ageMin, String pays, String région) {
        super(id, nom, contenance, disponibilite);
        this.tauxAlcool = tauxAlcool;
        this.ageMin = ageMin;
        this.pays = pays;
        this.région = région;
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

    public String getRégion() {
        return région;
    }
}
