import java.sql.*;

public class App {
    private static final String URL =
            "jdbc:postgresql://localhost/chillout"; // chillout = le nom de la base
    private static final String USR = "postgres";
    private static final String PASSWORD = ""; // Remplacer ici par le mdp

    public static void main(String[] args) {
        App app = new App();
        app.getBoissons();
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

    private void getBoissons() {
        String SQL = "SELECT * FROM Boisson";
        try (Connection conn = this.connect();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            System.out.println(SQL);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                System.out.printf("%s %d%n", rs.getString("nom"), rs.getInt("contenance"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}