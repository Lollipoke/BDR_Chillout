package ch.heig.ui;

import ch.heig.App;
import ch.heig.data.*;
import ch.heig.db.DBConnection;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.HPos;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.*;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.util.List;

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
        TilePane loginChoices = new TilePane();

        Text getBoissonsText = new Text();
        getBoissonsText.setFont(new Font(20));
        getBoissonsText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getBoissonsText.setText("Liste des boissons du Chillout : ");
        Button getBoissonsBtn = new Button();
        getBoissonsBtn.setText("Boissons");
        getBoissonsBtn.setOnAction(event -> showBoissonsWindow(db));
        HBox hBoxBoissons = new HBox(10);
        hBoxBoissons.getChildren().add(getBoissonsText);
        hBoxBoissons.getChildren().add(getBoissonsBtn);

        Text getStatisticsText = new Text();
        getStatisticsText.setFont(new Font(20));
        getStatisticsText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getStatisticsText.setText("Statistiques du membre : ");
        Button getStatisticsBtn = new Button();
        getStatisticsBtn.setText("Statistiques");
        getStatisticsBtn.setOnAction(event -> showStatisticsWindow(db, p));
        HBox hBoxStatistics = new HBox(10);
        hBoxStatistics.getChildren().add(getStatisticsText);
        hBoxStatistics.getChildren().add(getStatisticsBtn);

        Text getCommandesText = new Text();
        getCommandesText.setFont(new Font(20));
        getCommandesText.setStyle("-fx-padding: 30px; -fx-alignment: center;");
        getCommandesText.setText("Liste des commandes du membre : ");
        Button getCommandesBtn = new Button();
        getCommandesBtn.setText("Commandes");
        getCommandesBtn.setOnAction(event -> showCommandesWindow(db, p));
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

    private static void showBoissonsWindow(DBConnection db) {
        List<Biere> bieres = db.getBieres();
        List<Vin> vins = db.getVins();
        List<BoissonSoft> softs = db.getSofts();

        ObservableList<Biere> biereObservableList = FXCollections.observableArrayList(bieres);
        TableView<Biere> biereTableView = createBieresTableView(biereObservableList);

        ObservableList<Vin> vinsObservableList = FXCollections.observableArrayList(vins);
        TableView<Vin> vinsTableView = createVinsTableView(vinsObservableList);

        ObservableList<BoissonSoft> softsObservableList = FXCollections.observableArrayList(softs);
        TableView<BoissonSoft> softsTableView = createSoftsTableView(softsObservableList);

        Stage stage = new Stage();
        VBox box = new VBox();
        box.setPadding(new Insets(10));

        // How to center align content in a layout manager in JavaFX
        box.setAlignment(Pos.CENTER);

        Label labelBieres = new Label("Bières :");
        labelBieres.setFont(new Font(20));

        Label labelVins = new Label("Vins :");
        labelVins.setFont(new Font(20));

        Label labelSofts = new Label("Softs :");
        labelSofts.setFont(new Font(20));

        box.getChildren().add(labelBieres);
        box.getChildren().add(biereTableView);
        box.getChildren().add(labelVins);
        box.getChildren().add(vinsTableView);
        box.getChildren().add(labelSofts);
        box.getChildren().add(softsTableView);

        box.setAlignment(Pos.CENTER_LEFT);

        Scene scene = new Scene(box, 1000, 700);
        stage.setScene(scene);
        stage.setTitle("Boissons proposées par le Chillout");
        stage.setResizable(false);
        stage.show();
    }

    private static TableView<Biere> createBieresTableView(ObservableList<Biere> bieres) {
        TableView<Biere> bieresTableView = new TableView<>();

        bieresTableView.setItems(bieres);

        TableColumn<Biere, String> idCol = new TableColumn<>("Id");
        TableColumn<Biere, String> nomCol = new TableColumn<>("Nom");
        TableColumn<Biere, String> contenanceCol = new TableColumn<>("Contenance");
        TableColumn<Biere, String> disponibiliteCol = new TableColumn<>("Disponible");
        TableColumn<Biere, String> tauxAlcoolCol = new TableColumn<>("Taux alcool");
        TableColumn<Biere, String> ageMinCol = new TableColumn<>("Age légal");
        TableColumn<Biere, String> paysCol = new TableColumn<>("Pays");
        TableColumn<Biere, String> regionCol = new TableColumn<>("Région");
        TableColumn<Biere, String> typeCol = new TableColumn<>("Type");

        //aliasNameCol.setEditable(true);

        idCol.setCellValueFactory(new PropertyValueFactory<>("id"));
        nomCol.setCellValueFactory(new PropertyValueFactory<>("nom"));
        contenanceCol.setCellValueFactory(new PropertyValueFactory<>("contenance"));
        disponibiliteCol.setCellValueFactory(new PropertyValueFactory<>("disponibilité"));
        tauxAlcoolCol.setCellValueFactory(new PropertyValueFactory<>("tauxAlcool"));
        ageMinCol.setCellValueFactory(new PropertyValueFactory<>("ageMin"));
        paysCol.setCellValueFactory(new PropertyValueFactory<>("pays"));
        regionCol.setCellValueFactory(new PropertyValueFactory<>("région"));
        typeCol.setCellValueFactory(new PropertyValueFactory<>("type"));

        bieresTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibiliteCol,
                tauxAlcoolCol, ageMinCol, paysCol, regionCol, typeCol);

        return bieresTableView;
    }

    private static TableView<Vin> createVinsTableView(ObservableList<Vin> vins) {
        TableView<Vin> vinsTableView = new TableView<>();

        vinsTableView.setItems(vins);

        TableColumn<Vin, String> idCol = new TableColumn<>("Id");
        TableColumn<Vin, String> nomCol = new TableColumn<>("Nom");
        TableColumn<Vin, String> contenanceCol = new TableColumn<>("Contenance");
        TableColumn<Vin, String> disponibiliteCol = new TableColumn<>("Disponible");
        TableColumn<Vin, String> tauxAlcoolCol = new TableColumn<>("Taux alcool");
        TableColumn<Vin, String> ageMinCol = new TableColumn<>("Age légal");
        TableColumn<Vin, String> paysCol = new TableColumn<>("Pays");
        TableColumn<Vin, String> regionCol = new TableColumn<>("Région");
        TableColumn<Vin, String> typeCol = new TableColumn<>("Type");
        TableColumn<Vin, String> anneeCol = new TableColumn<>("Année");

        //aliasNameCol.setEditable(true);

        idCol.setCellValueFactory(new PropertyValueFactory<>("id"));
        nomCol.setCellValueFactory(new PropertyValueFactory<>("nom"));
        contenanceCol.setCellValueFactory(new PropertyValueFactory<>("contenance"));
        disponibiliteCol.setCellValueFactory(new PropertyValueFactory<>("disponibilité"));
        tauxAlcoolCol.setCellValueFactory(new PropertyValueFactory<>("tauxAlcool"));
        ageMinCol.setCellValueFactory(new PropertyValueFactory<>("ageMin"));
        paysCol.setCellValueFactory(new PropertyValueFactory<>("pays"));
        regionCol.setCellValueFactory(new PropertyValueFactory<>("région"));
        typeCol.setCellValueFactory(new PropertyValueFactory<>("type"));
        anneeCol.setCellValueFactory(new PropertyValueFactory<>("année"));

        vinsTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibiliteCol,
                tauxAlcoolCol, ageMinCol, paysCol, regionCol, typeCol, anneeCol);

        return vinsTableView;
    }

    private static TableView<BoissonSoft> createSoftsTableView(ObservableList<BoissonSoft> softs) {
        TableView<BoissonSoft> softsTableView = new TableView<>();

        softsTableView.setItems(softs);

        TableColumn<BoissonSoft, String> idCol = new TableColumn<>("Id");
        TableColumn<BoissonSoft, String> nomCol = new TableColumn<>("Nom");
        TableColumn<BoissonSoft, String> contenanceCol = new TableColumn<>("Contenance");
        TableColumn<BoissonSoft, String> disponibiliteCol = new TableColumn<>("Disponible");

        //aliasNameCol.setEditable(true);

        idCol.setCellValueFactory(new PropertyValueFactory<>("id"));
        nomCol.setCellValueFactory(new PropertyValueFactory<>("nom"));
        contenanceCol.setCellValueFactory(new PropertyValueFactory<>("contenance"));
        disponibiliteCol.setCellValueFactory(new PropertyValueFactory<>("disponibilité"));

        softsTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibiliteCol);

        return softsTableView;
    }


    private static void showStatisticsWindow(DBConnection db, Personne p) {

    }

    private static void showCommandesWindow(DBConnection db, Personne p) {
        List<Commande> commandes = db.getCommandes(p, false);

        ObservableList<Commande> commandesObservableList = FXCollections.observableArrayList(commandes);

        //ObservableList<BoissonStockee> boissonStockeesObservableList = FXCollections.observableList(commandes)
        ListView<Commande> commandesListView = createCommandesListView(commandesObservableList);

        ObservableList<BoissonStockee> boissonStockes = FXCollections.observableArrayList();
        TableView<BoissonStockee> boissonStockeeTableView = createBoissonsCommandesTableView(boissonStockes);


        Stage stage = new Stage();
        GridPane gridpane = new GridPane();

        Label labelCommandes = new Label("Commandes :");
        labelCommandes.setFont(new Font(20));
        Label labelBoissons = new Label("Boissons :");
        labelBoissons.setFont(new Font(20));

        GridPane.setHalignment(labelCommandes, HPos.CENTER);
        gridpane.add(labelCommandes, 0, 0);
        gridpane.add(commandesListView, 0, 1);

        GridPane.setHalignment(labelBoissons, HPos.CENTER);
        gridpane.add(labelBoissons, 2, 0);
        gridpane.add(boissonStockeeTableView, 2, 1);

        commandesListView
                .getSelectionModel()
                .selectedItemProperty()
                .addListener((observable, oldValue, newValue) -> {
                    if (observable != null && observable.getValue() != null) {
                        boissonStockes.clear();
                        boissonStockes.addAll(observable.getValue().getBoissonsStockées().keySet());
                    }
                });

        Scene scene = new Scene(gridpane, 1000, 700);
        stage.setScene(scene);
        stage.setTitle("Commandes passées par le membre");
        stage.setResizable(false);
        stage.show();
    }

    private static TableView<BoissonStockee> createBoissonsCommandesTableView(ObservableList<BoissonStockee> boissonStockees) {
        TableView<BoissonStockee> boissonsCommandéesTableView = new TableView<>();

        boissonsCommandéesTableView.setItems(boissonStockees);

        TableColumn<BoissonStockee, String> idCol = new TableColumn<>("Id");
        TableColumn<BoissonStockee, String> nomCol = new TableColumn<>("Nom");
        TableColumn<BoissonStockee, String> contenanceCol = new TableColumn<>("Contenance");
        TableColumn<BoissonStockee, String> disponibilitéCol = new TableColumn<>("Disponibilité");
        TableColumn<BoissonStockee, String> datePéremptionCol = new TableColumn<>("Date Péremption");

        idCol.setCellValueFactory(new PropertyValueFactory<>("id"));
        nomCol.setCellValueFactory(new PropertyValueFactory<>("nom"));
        contenanceCol.setCellValueFactory(new PropertyValueFactory<>("contenance"));
        disponibilitéCol.setCellValueFactory(new PropertyValueFactory<>("disponibilité"));
        datePéremptionCol.setCellValueFactory(new PropertyValueFactory<>("datePéremption"));

        boissonsCommandéesTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibilitéCol, datePéremptionCol);

        return boissonsCommandéesTableView;
    }

    private static ListView<Commande> createCommandesListView(ObservableList<Commande> commandes) {
        ListView<Commande> commandesListView = new ListView<>(commandes);
        commandesListView.setPrefWidth(150);
        commandesListView.setMaxWidth(Double.MAX_VALUE);
        commandesListView.setPrefHeight(150);

        commandesListView.setCellFactory(new Callback<>() {
            @Override
            public ListCell<Commande> call(ListView<Commande> param) {
                ListCell<Commande> cell = new ListCell<Commande>() {
                    @Override
                    public void updateItem(Commande item, boolean empty) {
                        super.updateItem(item, empty);
                        if (item != null) {
                            setText(item.getId() + " " + item.getDateHeure());
                        }
                    }
                };
                return cell;
            }

        });
        return commandesListView;
    }

}
