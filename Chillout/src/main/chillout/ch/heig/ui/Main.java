package ch.heig.ui;

import ch.heig.db.DBConnection;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.layout.*;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.util.Objects;
import java.util.Optional;

import static java.lang.Integer.parseInt;

public final class Main extends Application {
    private DBConnection db;
    private static String dbName;
    private static String user;
    private static String mdp;
    private Stage primaryStage;

    public static void main(String[] args) {
        if(args.length != 3) {
            throw new RuntimeException("Besoin de 2 arguments : <nom bd> <user> <mdp>.");
        }
        dbName = args[0];
        user = args[1];
        mdp = args[2];
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        this.primaryStage = primaryStage;
        Pane welcomePane = createTitlePane();
        Pane loginChoices = createLoginPane();

        // A layout container for UI controls
        BorderPane mainStack = new BorderPane();
        mainStack.setCenter(loginChoices);
        mainStack.setTop(welcomePane);

        // Top level container for all view content
        Scene scene = new Scene(mainStack, 1000, 700);

        // primaryStage is the main top level window created by platform
        primaryStage.setTitle("Chillout App");
        primaryStage.setScene(scene);
        primaryStage.setResizable(false);
        primaryStage.show();

        // Start DB connexion
        db = new DBConnection(dbName, user, mdp);
    }

    private Pane createTitlePane() {
        TilePane welcomePane = new TilePane();
        welcomePane.setPadding(new Insets(10, 10, 10, 10));
        welcomePane.setPrefColumns(2);
        HBox hbox2 = new HBox(20); // spacing = 8
        Text welcomeText = new Text();
        welcomeText.setFont(new Font(30));
        welcomeText.setText("Bienvenue sur l'application du Chillout !");
        hbox2.getChildren().addAll(welcomeText);
        welcomePane.setStyle("-fx-background-color: #9FDFC8;");
        welcomePane.getChildren().add(hbox2);
        return welcomePane;
    }

    private Pane createLoginPane() {
        TilePane loginChoices = new TilePane();
        Text loginText = new Text();
        loginText.setFont(new Font(20));
        loginText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        loginText.setText("Veuillez vous logger pour utiliser l'application : ");

        VBox vbox = new VBox();

        GridPane gridPane = new GridPane();
        gridPane.setHgap(10);
        gridPane.setVgap(10);

        // How to center align content in a layout manager in JavaFX
        gridPane.setAlignment(Pos.CENTER);

        Label label = new Label("Entrez votre nom et votre id");

        TextField textUser = new TextField();
        textUser.setPromptText("Entrez votre nom");
        TextField textPass = new TextField();
        textPass.setPromptText("Entrez votre id");

        Button btnLogin = new Button();
        btnLogin.setText("Login");

        btnLogin.setOnAction(event -> {
            String nom = textUser.getText();
            int id = 0;
            try {
                id = parseInt(textPass.getText());
            } catch (NumberFormatException e) {
                System.out.println(e.getMessage());
            }

            if (nom != null && id > 0) {
                boolean staffValid = db.getStaffLoginValidity(nom, id);
                boolean membreValid = db.getMembreLoginValidity(nom, id);
                if (staffValid && membreValid) {
                    setLoggedInUserChoice(nom, id);
                } else if (staffValid) {
                    primaryStage.setScene(StaffUI.createStaffWindow(db.getPersonne(id, false)));
                } else if(membreValid) {
                    primaryStage.setScene(MembreUI.createMembreWindow(db.getPersonne(id, true), db));
                } else {
                    setLoggingInvalid(nom, id);
                }
            }
        });

        gridPane.add(label, 0, 0);
        gridPane.add(textUser, 1, 0);
        gridPane.add(textPass, 1, 1);
        gridPane.add(btnLogin, 1, 2);

        vbox.getChildren().add(loginText);
        vbox.getChildren().add(gridPane);
        loginChoices.getChildren().add(vbox);
        loginChoices.setStyle("-fx-padding: 30px;");

        return loginChoices;
    }

    public void setLoggedInUserChoice(String nom, int id) {
        ButtonType membreButton = new ButtonType("Membre");
        ButtonType staffButton = new ButtonType("Staff");
        Alert choiceDialog = new Alert(AlertType.CONFIRMATION);
        choiceDialog.setTitle("Connection valide");
        choiceDialog.setHeaderText("Bienvenue " + nom + "!\nVeuillez choisir votre mode de connexion.");
        String s = "Choix : ";
        choiceDialog.setContentText(s);
        choiceDialog.getButtonTypes().setAll(membreButton, staffButton);
        Optional<ButtonType> choice = choiceDialog.showAndWait();
        choice.ifPresent(e -> {
            if(Objects.equals(e.getText(), "Staff")) {
                primaryStage.setScene(StaffUI.createStaffWindow(db.getPersonne(id, false)));
            } else {

                primaryStage.setScene(MembreUI.createMembreWindow(db.getPersonne(id, true), db));
            }
        });
    }

    private void setLoggingInvalid(String nom, int id) {
        Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle("Connection invalide");
        alert.setHeaderText("Erreur !");
        String s = "Impossible de trouver : " + nom + ", " + id;
        alert.setContentText(s);
        alert.show();
    }

}