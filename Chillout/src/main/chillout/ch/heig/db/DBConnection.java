package ch.heig.db;

import ch.heig.data.Biere;
import ch.heig.data.BoissonSoft;
import ch.heig.data.Vin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
}
