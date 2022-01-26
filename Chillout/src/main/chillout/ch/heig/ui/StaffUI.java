package ch.heig.ui;

import ch.heig.data.Personne;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.*;
import javafx.scene.text.Font;
import javafx.scene.text.Text;

public class StaffUI {
    public static Scene createStaffWindow(Personne p) {
        Pane titlePane = createTitlePane(p.getPrénom() + " " + p.getNom());
        Pane staffPane = createStaffPane();

        // A layout container for UI controls
        BorderPane mainStack = new BorderPane();
        mainStack.setTop(titlePane);
        mainStack.setCenter(staffPane);

        // Top level container for all view content
        return new Scene(mainStack, 1000, 700);
    }

    private static Pane createTitlePane(String name) {
        TilePane welcomePane = new TilePane();
        welcomePane.setPadding(new Insets(10, 10, 10, 10));
        welcomePane.setPrefColumns(2);
        HBox hbox2 = new HBox(20); // spacing = 8
        Text welcomeText = new Text();
        welcomeText.setFont(new Font(30));
        welcomeText.setText("Bienvenue " + name + " dans l'espace staff !");
        hbox2.getChildren().addAll(welcomeText);
        welcomePane.setStyle("-fx-background-color: #9FDFC8;");
        welcomePane.getChildren().add(hbox2);
        return welcomePane;
    }

    private static Pane createStaffPane() {
        TilePane loginChoices = new TilePane();

        Text getPersonnesText = new Text();
        getPersonnesText.setFont(new Font(20));
        getPersonnesText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getPersonnesText.setText("Liste des personnes : ");
        Button getPersonnesBtn = new Button();
        getPersonnesBtn.setText("Personnes");
        getPersonnesBtn.setOnAction(event -> showCommandesWindow());
        HBox hBoxPersonnes = new HBox(10);
        hBoxPersonnes.getChildren().add(getPersonnesText);
        hBoxPersonnes.getChildren().add(getPersonnesBtn);

        Text getBoissonsText = new Text();
        getBoissonsText.setFont(new Font(20));
        getBoissonsText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getBoissonsText.setText("Liste des boissons du Chillout : ");
        Button getBoissonsBtn = new Button();
        getBoissonsBtn.setText("Boissons");
        getBoissonsBtn.setOnAction(event -> showBoissonsWindow());
        HBox hBoxBoissons = new HBox(10);
        hBoxBoissons.getChildren().add(getBoissonsText);
        hBoxBoissons.getChildren().add(getBoissonsBtn);

        Text getStatisticsText = new Text();
        getStatisticsText.setFont(new Font(20));
        getStatisticsText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getStatisticsText.setText("Statistiques : ");
        Button getStatisticsBtn = new Button();
        getStatisticsBtn.setText("Statistiques");
        getStatisticsBtn.setOnAction(event -> showStatisticsWindow());
        HBox hBoxStatistics = new HBox(10);
        hBoxStatistics.getChildren().add(getStatisticsText);
        hBoxStatistics.getChildren().add(getStatisticsBtn);

        Text getCommandesMembresText = new Text();
        getCommandesMembresText.setFont(new Font(20));
        getCommandesMembresText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getCommandesMembresText.setText("Liste des commandes client : ");
        Button getCommandesMembresBtn = new Button();
        getCommandesMembresBtn.setText("Commandes clients");
        getCommandesMembresBtn.setOnAction(event -> showCommandesWindow());
        HBox hBoxCommandesMembres = new HBox(10);
        hBoxCommandesMembres.getChildren().add(getCommandesMembresText);
        hBoxCommandesMembres.getChildren().add(getCommandesMembresBtn);

        Text getCommandesStaffText = new Text();
        getCommandesStaffText.setFont(new Font(20));
        getCommandesStaffText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getCommandesStaffText.setText("Liste des commandes fournisseurs : ");
        Button getCommandesStaffBtn = new Button();
        getCommandesStaffBtn.setText("Commandes fournisseurs");
        getCommandesStaffBtn.setOnAction(event -> showCommandesWindow());
        HBox hBoxCommandesStaff = new HBox(10);
        hBoxCommandesStaff.getChildren().add(getCommandesStaffText);
        hBoxCommandesStaff.getChildren().add(getCommandesStaffBtn);

        Text getFournisseursText = new Text();
        getFournisseursText.setFont(new Font(20));
        getFournisseursText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getFournisseursText.setText("Liste des fournisseurs : ");
        Button getFournisseursBtn = new Button();
        getFournisseursBtn.setText("Fournisseurs");
        getFournisseursBtn.setOnAction(event -> showCommandesWindow());
        HBox hBoxFournisseurs = new HBox(10);
        hBoxFournisseurs.getChildren().add(getFournisseursText);
        hBoxFournisseurs.getChildren().add(getFournisseursBtn);

        VBox vbox = new VBox(40);
        vbox.getChildren().add(hBoxPersonnes);
        vbox.getChildren().add(hBoxBoissons);
        vbox.getChildren().add(hBoxStatistics);
        vbox.getChildren().add(hBoxCommandesMembres);
        vbox.getChildren().add(hBoxCommandesStaff);
        vbox.getChildren().add(hBoxFournisseurs);
        vbox.setAlignment(Pos.CENTER_LEFT);

        loginChoices.getChildren().add(vbox);
        loginChoices.setStyle("-fx-padding: 30px;");
        loginChoices.setAlignment(Pos.CENTER_LEFT);
        return loginChoices;
    }

    private static void showBoissonsWindow() {

    }

    private static void showStatisticsWindow() {

    }

    private static void showCommandesWindow() {

    }
}
