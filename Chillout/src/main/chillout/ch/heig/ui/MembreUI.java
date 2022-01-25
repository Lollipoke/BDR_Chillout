package ch.heig.ui;

import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.*;
import javafx.scene.text.Font;
import javafx.scene.text.Text;

public class MembreUI {
    public static Scene createMembreWindow(String name) {
        Pane titlePane = createTitlePane(name);
        Pane membrePane = createMembrePane();

        // A layout container for UI controls
        BorderPane mainStack = new BorderPane();
        mainStack.setTop(titlePane);
        mainStack.setCenter(membrePane);

        // Top level container for all view content
        return new Scene(mainStack, 800, 500);
    }

    private static Pane createTitlePane(String name) {
        TilePane welcomePane = new TilePane();
        welcomePane.setPadding(new Insets(10, 10, 10, 10));
        welcomePane.setPrefColumns(2);
        HBox hbox2 = new HBox(20); // spacing = 8
        Text welcomeText = new Text();
        welcomeText.setFont(new Font(30));
        welcomeText.setText("Bienvenue " + name + " dans l'espace Membre!");
        hbox2.getChildren().addAll(welcomeText);
        welcomePane.setStyle("-fx-background-color: #9FDFC8;");
        welcomePane.getChildren().add(hbox2);
        return welcomePane;
    }

    private static Pane createMembrePane() {
        TilePane loginChoices = new TilePane();

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
        getStatisticsText.setText("Statistiques du membre : ");
        Button getStatisticsBtn = new Button();
        getStatisticsBtn.setText("Statistiques");
        getStatisticsBtn.setOnAction(event -> showStatisticsWindow());
        HBox hBoxStatistics = new HBox(10);
        hBoxStatistics.getChildren().add(getStatisticsText);
        hBoxStatistics.getChildren().add(getStatisticsBtn);

        Text getCommandesText = new Text();
        getCommandesText.setFont(new Font(20));
        getCommandesText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getCommandesText.setText("Liste des commandes du membre : ");
        Button getCommandesBtn = new Button();
        getCommandesBtn.setText("Commandes");
        getCommandesBtn.setOnAction(event -> showCommandesWindow());
        HBox hBoxCommandes = new HBox(10);
        hBoxCommandes.getChildren().add(getCommandesText);
        hBoxCommandes.getChildren().add(getCommandesBtn);

        VBox vbox = new VBox(50);
        vbox.getChildren().add(hBoxBoissons);
        vbox.getChildren().add(hBoxStatistics);
        vbox.getChildren().add(hBoxCommandes);
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
