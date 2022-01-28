package ch.heig.ui;

import ch.heig.data.BoissonStockee;
import ch.heig.data.Commande;
import ch.heig.data.Personne;
import ch.heig.db.DBConnection;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.HPos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

public class ListeCommandesUI {
    public static void showCommandesWindow(DBConnection db, Personne p) {
        List<Commande> commandes = db.getCommandes(p, false);

        ObservableList<Commande> commandesObservableList = FXCollections.observableArrayList(commandes);

        ListView<Commande> commandesListView = createCommandesListView(commandesObservableList);

        ObservableList<BoissonStockee> boissonStockes = FXCollections.observableArrayList();
        ObservableList<BoissonStockee> quantités = FXCollections.observableArrayList();
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
                        boissonStockes.addAll(observable.getValue().getBoissonsStockées());
                    }
                });

        Scene scene = new Scene(gridpane, 1000, 500);
        stage.setScene(scene);
        stage.setTitle("Commandes passées par le membre");
        stage.setResizable(false);
        stage.show();
    }

    private static TableView<BoissonStockee> createBoissonsCommandesTableView(ObservableList<BoissonStockee> boissonStockees) {
        TableView<BoissonStockee> boissonsCommandéesTableView = new TableView<>();
        boissonsCommandéesTableView.setPrefWidth(700);

        boissonsCommandéesTableView.setItems(boissonStockees);

        TableColumn<BoissonStockee, String> idCol = new TableColumn<>("Id");
        TableColumn<BoissonStockee, String> nomCol = new TableColumn<>("Nom");
        TableColumn<BoissonStockee, String> contenanceCol = new TableColumn<>("Contenance");
        TableColumn<BoissonStockee, String> disponibilitéCol = new TableColumn<>("Disponibilité");
        TableColumn<BoissonStockee, String> datePéremptionCol = new TableColumn<>("Date Péremption");
        TableColumn<BoissonStockee, String> quantitéCol = new TableColumn<>("Quantité");

        idCol.setCellValueFactory(new PropertyValueFactory<>("id"));
        nomCol.setCellValueFactory(new PropertyValueFactory<>("nom"));
        contenanceCol.setCellValueFactory(new PropertyValueFactory<>("contenance"));
        disponibilitéCol.setCellValueFactory(new PropertyValueFactory<>("disponibilité"));
        datePéremptionCol.setCellValueFactory(new PropertyValueFactory<>("datePéremption"));
        quantitéCol.setCellValueFactory(new PropertyValueFactory<>("quantité"));

        idCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth()/6);
        nomCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth()/6);
        contenanceCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth()/6);
        disponibilitéCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth()/6);
        datePéremptionCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth()/6);
        quantitéCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth()/6);

        boissonsCommandéesTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibilitéCol, datePéremptionCol, quantitéCol);

        return boissonsCommandéesTableView;
    }

    private static ListView<Commande> createCommandesListView(ObservableList<Commande> commandes) {
        ListView<Commande> commandesListView = new ListView<>(commandes);
        commandesListView.setMinWidth(100);
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
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                            SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
                            Timestamp dateHeure = item.getDateHeure();
                            setText("Commande " + item.getId() + " le " + sdf.format(dateHeure) +
                                    " à " + sdf2.format(dateHeure));
                        }
                    }
                };
                return cell;
            }

        });
        return commandesListView;
    }

}
