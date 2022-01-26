package ch.heig.data;

public class Fournisseur {
    private final String nom;
    private final String nomRue;
    private final int numRue;
    private final int codePostal;
    private final String localité;
    private final double fraisLivraison;

    public Fournisseur(String nom, String nomRue, int numRue, int codePostal, String localité, double fraisLivraison) {
        this.nom = nom;
        this.nomRue = nomRue;
        this.numRue = numRue;
        this.codePostal = codePostal;
        this.localité = localité;
        this.fraisLivraison = fraisLivraison;
    }

    public String getNom() {
        return nom;
    }

    public String getNomRue() {
        return nomRue;
    }

    public int getNumRue() {
        return numRue;
    }

    public int getCodePostal() {
        return codePostal;
    }

    public String getLocalité() {
        return localité;
    }

    public double getFraisLivraison() {
        return fraisLivraison;
    }
}
