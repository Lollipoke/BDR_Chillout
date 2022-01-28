package ch.heig.db;

import ch.heig.data.*;

import java.nio.file.FileSystemNotFoundException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBConnection {
    private static final String URL =
            "jdbc:postgresql://localhost/"; // chillout = le nom de la base
    private final String dbName;
    private final String usr;
    private final String pwd;
    private final Connection connection;

    public DBConnection(String dbName, String user, String mdp) {
        this.dbName = dbName;
        this.usr = user;
        this.pwd = mdp;
        this.connection = connect();
    }

    private Connection connect() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL + dbName, usr, pwd);
            System.out.println("Connected to the PostgreSQL server successfully.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.exit(1);
        }

        return conn;
    }

    public List<Biere> getBieres() {
        ArrayList<Biere> bieres = new ArrayList<>();
        String request = "SELECT Boisson.id, Boisson.nom, Boisson.contenance, Boisson.disponibilité,\n" +
                "BoissonAlcoolisée.tauxAlcool, BoissonAlcoolisée.ageMin, BoissonAlcoolisée.pays,\n" +
                "BoissonAlcoolisée.région, Bière.type\n" +
                "FROM Bière\n" +
                "INNER JOIN BoissonAlcoolisée\n" +
                "ON BoissonAlcoolisée.idBoisson = Bière.idBoissonAlcoolisée\n" +
                "INNER JOIN Boisson\n" +
                "ON Boisson.id = BoissonAlcoolisée.idBoisson;";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                bieres.add(new Biere(rs.getInt("id"), rs.getString("nom"), rs.getInt("contenance"),
                        rs.getBoolean("disponibilité"), rs.getDouble("tauxAlcool"), rs.getInt("ageMin"),
                        rs.getString("pays"), rs.getString("région"), rs.getString("type")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return bieres;
    }

    public List<Vin> getVins() {
        ArrayList<Vin> vin = new ArrayList<>();
        String request = "SELECT Boisson.id, Boisson.nom, Boisson.contenance, Boisson.disponibilité, \n" +
                "BoissonAlcoolisée.tauxAlcool, BoissonAlcoolisée.ageMin, BoissonAlcoolisée.pays,\n" +
                "BoissonAlcoolisée.région, Vin.type, Vin.année\n" +
                "FROM Vin\n" +
                "INNER JOIN BoissonAlcoolisée\n" +
                "ON BoissonAlcoolisée.idBoisson = Vin.idBoissonAlcoolisée\n" +
                "INNER JOIN Boisson\n" +
                "ON Boisson.id = BoissonAlcoolisée.idBoisson;";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                vin.add(new Vin(rs.getInt("id"), rs.getString("nom"), rs.getInt("contenance"),
                        rs.getBoolean("disponibilité"), rs.getDouble("tauxAlcool"), rs.getInt("ageMin"),
                        rs.getString("pays"), rs.getString("région"), rs.getString("type"), rs.getInt("année")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return vin;
    }

    public List<BoissonSoft> getSofts() {
        ArrayList<BoissonSoft> softs = new ArrayList<>();
        String request = "SELECT Boisson.id, Boisson.nom, Boisson.contenance, Boisson.disponibilité\n" +
                "FROM BoissonSoft\n" +
                "INNER JOIN Boisson\n" +
                "ON Boisson.id = BoissonSoft.idBoisson;";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                softs.add(new BoissonSoft(rs.getInt("id"), rs.getString("nom"), rs.getInt("contenance"),
                        rs.getBoolean("disponibilité")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return softs;
    }

    public boolean getStaffLoginValidity(String nom, int id) {
        return getLoginValidity("staff", nom, id);
    }

    public boolean getMembreLoginValidity(String nom, int id) {
        return getLoginValidity("membre", nom, id);
    }

    private boolean getLoginValidity(String category, String nom, int id) {
        boolean result = false;
        try (CallableStatement loginValidity = connection.prepareCall("{ ? = call " + category + "_exists(?, ?) }")) {
            loginValidity.registerOutParameter(1, Types.BOOLEAN);
            loginValidity.setString(2, nom);
            loginValidity.setObject(3, id, Types.SMALLINT);
            loginValidity.execute();
            result = loginValidity.getBoolean(1);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    public List<Commande> getCommandes(Personne p, boolean commandeFournisseur) {
        ArrayList<Commande> commandes = new ArrayList<>();
        String request = "SELECT Commande.id, Commande.dateHeure, Commande.idPersonne,\n" +
                "array_agg(Commande_Stock.idBoissonStock) AS idBoissonStock, array_agg(Commande_Stock.datePéremptionStock) AS datePéremption, \n" +
                "array_agg(Boisson.nom) AS nom, \n" +
                "array_agg(Boisson.contenance) AS contenance, array_agg(Boisson.disponibilité) AS disponibilité, \n" +
                "array_agg(Commande_stock.quantité) AS quantité\n" +
                "FROM Commande\n" +
                "INNER JOIN Commande_Stock\n" +
                "ON Commande_Stock.idCommande = Commande.id\n" +
                "INNER JOIN Boisson\n" +
                "ON Boisson.id = Commande_Stock.idBoissonStock\n" +
                "WHERE Commande.idPersonne = " + p.getId() + " AND Commande.commandeFournisseur = " + commandeFournisseur + "\n" +
                "GROUP BY commande.id,  commande.dateheure, commande.idpersonne;";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Commande c = new Commande(rs.getInt("id"), rs.getTimestamp("dateHeure"),
                        p, commandeFournisseur);
                Short[] idBoissonStock = (Short[])(rs.getArray("idBoissonStock").getArray());
                Date[] datePéremption = (Date[])(rs.getArray("datePéremption").getArray());
                String[] nom = (String[])(rs.getArray("nom").getArray());
                Short[] contenance = (Short[])(rs.getArray("contenance").getArray());
                Boolean[] disponibilité = (Boolean[])(rs.getArray("disponibilité").getArray());
                Short[] quantité = (Short[])(rs.getArray("quantité").getArray());
                ArrayList<BoissonStockee> boissonsStockées = new ArrayList<>();
                for(int i = 0; i < idBoissonStock.length; i++){
                    BoissonStockee bs = new BoissonStockee(idBoissonStock[i], nom[i], contenance[i], disponibilité[i], datePéremption[i], quantité[i]);
                    boissonsStockées.add(bs);
                }
                c.setBoissonsStockées(boissonsStockées);
                commandes.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return commandes;
    }

    public Personne getPersonne(int id, boolean membre) {
        return membre ? getMembre(id) : getStaff(id);
    }

    private Membre getMembre(int id) {
        Membre membre = null;
        String request = "SELECT Personne.id, Personne.nom, Personne.prénom, \n" +
                "Personne.dateNaissance, Personne.dateArrivée, Personne.actif,\n" +
                "Membre.libelléFilière\n" +
                "FROM Membre\n" +
                "INNER JOIN Personne\n" +
                "ON Personne.id = Membre.idPersonne\n" +
                "WHERE Personne.id = " + id + ";";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                membre = new Membre(rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("prénom"),
                        rs.getDate("dateNaissance"),
                        rs.getDate("dateArrivée"),
                        rs.getBoolean("actif"),
                        rs.getString("libelléFilière"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return membre;
    }

    private Staff getStaff(int id) {
        Staff staff = null;
        String request = "SELECT Personne.id, Personne.nom, Personne.prénom, \n" +
                "Personne.dateNaissance, Personne.dateArrivée, Personne.actif\n" +
                "FROM Staff\n" +
                "INNER JOIN Personne\n" +
                "ON Personne.id = Staff.idPersonne\n" +
                "WHERE Personne.id =" + id + ";";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                staff = new Staff(rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("prénom"),
                        rs.getDate("dateNaissance"),
                        rs.getDate("dateArrivée"),
                        rs.getBoolean("actif"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return staff;
    }

    public double getNoteMoyenne(Boisson boisson) {
        double noteMoyenne = 0.;
        String request = "SELECT COALESCE(ROUND(AVG(note), 2), 0.00) AS noteMoyenne\n" +
                "FROM Evaluation\n" +
                "WHERE idBoisson = " + boisson.getId() + ";";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                noteMoyenne = rs.getDouble("noteMoyenne");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return noteMoyenne;
    }

    public Integer getNote(Boisson boisson, Personne p) {
        Integer note = null;
        String request = "SELECT note\n" +
                "FROM Evaluation\n" +
                "WHERE idBoisson = " + boisson.getId() + " AND idMembre = "+ p.getId() + " ;";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                note = rs.getInt("note");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return note;
    }

    public void addEvaluation(Boisson boisson, Personne p, int note) {
        String request = "INSERT INTO Evaluation VALUES ("+boisson.getId()+", "
                +p.getId()+", "+ note + ", current_timestamp);";
        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            pstmt.executeQuery();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public List<BoissonStockee> getStockChillout() {
        ArrayList<BoissonStockee> listeBoissons = new ArrayList<>();
        int nbBoissons = getNbBoissonsDisponibles();
        for(int i = 0; i < nbBoissons; i++) {
            int nextId = getIdBoissonDisponible(i);
            String request = "SELECT Boisson.id, Boisson.nom, Boisson.contenance, \n" +
                    "Boisson.disponibilité, Stock.datePéremption, get_current_ChilloutStock("+nextId+", Stock.datePéremption) AS quantité\n" +
                    "FROM Boisson\n" +
                    "INNER JOIN Stock\n" +
                    "ON Stock.idBoisson = Boisson.id\n" +
                    "WHERE Boisson.id = "+nextId+";";
            try (PreparedStatement pstmt = connection.prepareStatement(request)) {
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    if(rs.getInt("quantité") > 0) {
                        BoissonStockee bs = new BoissonStockee(rs.getInt("id"), rs.getString("nom"),
                                rs.getInt("contenance"), rs.getBoolean("disponibilité"),
                                rs.getDate("datePéremption"), rs.getInt("quantité"));
                        listeBoissons.add(bs);
                    }
                }
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
        return listeBoissons;
    }

    private int getNbBoissonsDisponibles() {
        int nbBoissons = 0;
        String request = "SELECT COUNT(*) AS nbBoissons\n" +
                "FROM Boisson\n" +
                "WHERE Boisson.disponibilité = 'TRUE';";

        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                nbBoissons = rs.getInt("nbBoissons");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return nbBoissons;
    }

    private int getIdBoissonDisponible(int place) {
        int id = -1;
        String request = "SELECT id\n" +
                "FROM Boisson\n" +
                "WHERE Boisson.disponibilité = 'TRUE'\n" +
                "OFFSET "+ place + " LIMIT 1;";
        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return id;
    }

    public void addNewCommande(List<BoissonStockee> boissons, Personne p) {
        String request = "INSERT INTO COMMANDE (dateHeure, idPersonne, commandeFournisseur) VALUES (current_timestamp, "+ p.getId()+ ", 'FALSE');";
        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            pstmt.executeQuery();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        // Get the id of the command
        int commandId = 0;
        request = "SELECT id FROM Commande WHERE idPersonne = "
                + p.getId() + " ORDER BY dateHeure DESC LIMIT 1" ;
        try (PreparedStatement pstmt = connection.prepareStatement(request)) {
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                commandId = rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        for(BoissonStockee bs : boissons) {
            request = "INSERT INTO Commande_Stock VALUES ("+commandId+", "+
                    bs.getId()+ ", TO_DATE('" + bs.getDatePéremption()+ "', 'YYYY-MM-DD'), "+bs.getQuantitéSouhaitée()+")";
            try (PreparedStatement pstmt = connection.prepareStatement(request)) {
                pstmt.executeQuery();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
    }

}
