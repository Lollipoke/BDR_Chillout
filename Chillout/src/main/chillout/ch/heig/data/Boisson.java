package ch.heig.data;

public class Boisson {
    private final int id;
    private final String nom;
    private final int contenance;
    private final boolean disponibilite;

    public Boisson(int id, String nom, int contenance, boolean disponibilite) {
        this.id = id;
        this.nom = nom;
        this.contenance = contenance;
        this.disponibilite = disponibilite;
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

    public boolean isDisponibilite(){
        return disponibilite;
    }
}
