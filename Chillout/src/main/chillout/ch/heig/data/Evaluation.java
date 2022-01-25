package ch.heig.data;

import java.sql.Date;

public class Evaluation {
    private final Boisson boisson;
    private final Membre membre;
    private final double note;
    private final Date date;


    public Evaluation(Boisson boisson, Membre membre, double note, Date date) {
        this.boisson = boisson;
        this.membre = membre;
        this.note = note;
        this.date = date;
    }

    public Boisson getBoisson() {
        return boisson;
    }

    public Membre getMembre() {
        return membre;
    }

    public double getNote() {
        return note;
    }

    public Date getDate() {
        return date;
    }
}
