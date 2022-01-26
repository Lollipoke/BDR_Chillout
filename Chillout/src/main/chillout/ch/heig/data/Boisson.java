package ch.heig.data;

public class Boisson {
    private final int id;
    private final String nom;
    private final int contenance;
    private final boolean disponibilité;

    public Boisson(int id, String nom, int contenance, boolean disponibilité) {
        this.id = id;
        this.nom = nom;
        this.contenance = contenance;
        this.disponibilité = disponibilité;
    }

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public int getContenance() {
        return contenance;
    }

    public boolean getDisponibilité(){
        return disponibilité;
    }
}
