package ch.heig.db;

import java.sql.*;

public class DBConnection {
    private static final String URL =
            "jdbc:postgresql://localhost/chillout"; // chillout = le nom de la base
    private static final String USR = "postgres";
    private static final String PASSWORD = "2755"; // Remplacer ici par le mdp
    private final Connection connection;

    public DBConnection() {
        this.connection = connect();
    }

    private Connection connect() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USR, PASSWORD);
            System.out.println("Connected to the PostgreSQL server successfully.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return conn;
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
