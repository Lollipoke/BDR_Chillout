package ch.heig.data;

public class Fournisseur {
    private final String nom;
    private final String nomRue;
    private final int numRue;
    private final int codePostal;
    private final String localite;
    private final double fraisLivraison;

    public Fournisseur(String nom, String nomRue, int numRue, int codePostal, String localite, double fraisLivraison) {
        this.nom = nom;
        this.nomRue = nomRue;
        this.numRue = numRue;
        this.codePostal = codePostal;
        this.localite = localite;
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

    public String getLocalite() {
        return localite;
    }

    public double getFraisLivraison() {
        return fraisLivraison;
    }
}
