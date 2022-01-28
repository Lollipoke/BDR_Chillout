package ch.heig.ui;

import ch.heig.data.Personne;
import ch.heig.db.DBConnection;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.*;
import javafx.scene.text.Font;
import javafx.scene.text.Text;

public class MembreUI {
    public static Scene createMembreWindow(Personne p, DBConnection db) {
        Pane titlePane = createTitlePane(p.getPrénom() + " " + p.getNom());
        Pane membrePane = createMembrePane(db, p);

        // A layout container for UI controls
        BorderPane mainStack = new BorderPane();
        mainStack.setTop(titlePane);
        mainStack.setCenter(membrePane);

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
        welcomeText.setText("Bienvenue " + name + " dans l'espace membre !");
        hbox2.getChildren().addAll(welcomeText);
        welcomePane.setStyle("-fx-background-color: #9FDFC8;");
        welcomePane.getChildren().add(hbox2);
        return welcomePane;
    }

    private static Pane createMembrePane(DBConnection db, Personne p) {
        GridPane gridpane = new GridPane();
        gridpane.setHgap(20);
        gridpane.setVgap(60);
        gridpane.setAlignment(Pos.CENTER_LEFT);
        gridpane.setPadding(new Insets(0, 0, 0, 30));

        Text getBoissonsText = new Text();
        getBoissonsText.setFont(new Font(20));
        getBoissonsText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getBoissonsText.setText("Liste des boissons du Chillout : ");
        Button getBoissonsBtn = new Button();
        getBoissonsBtn.setText("Boissons");
        getBoissonsBtn.setOnAction(event -> BoissonsUI.showBoissonsWindow(db, p));


        Text getStatisticsText = new Text();
        getStatisticsText.setFont(new Font(20));
        getStatisticsText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getStatisticsText.setText("Statistiques du membre : ");
        Button getStatisticsBtn = new Button();
        getStatisticsBtn.setText("Statistiques");
        getStatisticsBtn.setOnAction(event -> StatisticsUI.showStatisticsWindow(db, p));

        Text getCommandesText = new Text();
        getCommandesText.setFont(new Font(20));
        getCommandesText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getCommandesText.setText("Liste des commandes du membre : ");
        Button getCommandesBtn = new Button();
        getCommandesBtn.setText("Commandes");
        getCommandesBtn.setOnAction(event -> ListeCommandesUI.showCommandesWindow(db, p));

        Text passerCommandeText = new Text();
        passerCommandeText.setFont(new Font(20));
        passerCommandeText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        passerCommandeText.setText("Passer une commande : ");
        Button passerCommandeBtn = new Button();
        passerCommandeBtn.setText("Commander");
        passerCommandeBtn.setOnAction(event -> PasserCommandeUI.showCommandesWindow(db, p));

        gridpane.add(getBoissonsText, 0, 0);
        gridpane.add(getBoissonsBtn, 1, 0);

        gridpane.add(getCommandesText, 0, 1);
        gridpane.add(getCommandesBtn, 1, 1);

        gridpane.add(getStatisticsText, 0, 2);
        gridpane.add(getStatisticsBtn, 1, 2);

        gridpane.add(passerCommandeText, 0, 3);
        gridpane.add(passerCommandeBtn, 1, 3);

        return gridpane;
    }
}
