package ch.heig.ui;

import ch.heig.data.BoissonStockee;
import ch.heig.data.Personne;
import ch.heig.db.DBConnection;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.HPos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Font;
import javafx.stage.Stage;

import java.util.ArrayList;
import java.util.List;

import static java.lang.Integer.parseInt;

public class PasserCommandeUI {
    public static void showCommandesWindow(DBConnection db, Personne p) {
        List<BoissonStockee> listeBoissons = db.getStockChillout();
        ObservableList<BoissonStockee> listeBoissonStockes = FXCollections.observableArrayList(listeBoissons);
        TableView<BoissonStockee> boissonStockeeTableView = createListeBoissonsDisponiblesTableView(listeBoissonStockes);


        Stage stage = new Stage();
        GridPane gridpane = new GridPane();
        gridpane.setHgap(10);
        gridpane.setVgap(10);

        Label labelBoissonsDisponibles = new Label("Boissons disponibles :");
        labelBoissonsDisponibles.setFont(new Font(20));

        Button commanderBtn = new Button("Commander");
        commanderBtn.setOnAction(e -> {
            passerCommande(boissonStockeeTableView, p, db);
            stage.close();
        });

        GridPane.setHalignment(labelBoissonsDisponibles, HPos.CENTER);
        gridpane.add(labelBoissonsDisponibles, 0, 0);
        gridpane.add(boissonStockeeTableView, 0, 1);
        gridpane.add(commanderBtn, 1, 1);


        Scene scene = new Scene(gridpane, 1000, 400);
        stage.setScene(scene);
        stage.setTitle("Passer une commande");
        stage.setResizable(false);
        stage.show();
    }

    private static void passerCommande(TableView tv, Personne p, DBConnection db) {
        ArrayList<BoissonStockee> boissonsACommander = new ArrayList<>();
        ObservableList<TableColumn> cols = tv.getColumns();
        TableColumn quantitéSouhaitéeCol = cols.get(6);
        for (Object row : tv.getItems()) {
            int val = parseInt((String)quantitéSouhaitéeCol.getCellObservableValue(row).getValue());
            if(val > 0) {
                boissonsACommander.add((BoissonStockee)row);
            }
        }

        if(boissonsACommander.size() > 0) {
            db.addNewCommande(boissonsACommander, p);
        }
    }

    private static TableView<BoissonStockee> createListeBoissonsDisponiblesTableView(ObservableList<BoissonStockee> listeBoissons) {
        TableView<BoissonStockee> boissonsCommandéesTableView = new TableView<>();
        boissonsCommandéesTableView.setPrefWidth(800);

        boissonsCommandéesTableView.setItems(listeBoissons);

        TableColumn<BoissonStockee, String> idCol = new TableColumn<>("Id");
        TableColumn<BoissonStockee, String> nomCol = new TableColumn<>("Nom");
        TableColumn<BoissonStockee, String> contenanceCol = new TableColumn<>("Contenance");
        TableColumn<BoissonStockee, String> disponibilitéCol = new TableColumn<>("Disponibilité");
        TableColumn<BoissonStockee, String> datePéremptionCol = new TableColumn<>("Date Péremption");
        TableColumn<BoissonStockee, String> quantitéDispoCol = new TableColumn<>("Quantité disponible");
        TableColumn<BoissonStockee, String> quantitéSouhaitéeCol = new TableColumn<>("Quantité souhaitée");

        idCol.setCellValueFactory(new PropertyValueFactory<>("id"));
        nomCol.setCellValueFactory(new PropertyValueFactory<>("nom"));
        contenanceCol.setCellValueFactory(new PropertyValueFactory<>("contenance"));
        disponibilitéCol.setCellValueFactory(new PropertyValueFactory<>("disponibilité"));
        datePéremptionCol.setCellValueFactory(new PropertyValueFactory<>("datePéremption"));
        quantitéDispoCol.setCellValueFactory(new PropertyValueFactory<>("quantité"));
        quantitéSouhaitéeCol.setCellValueFactory(new PropertyValueFactory<>("quantitéSouhaitée"));

        idCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth() / 7);
        nomCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth() / 7);
        contenanceCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth() / 7);
        disponibilitéCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth() / 7);
        datePéremptionCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth() / 7);
        quantitéDispoCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth() / 7);
        quantitéSouhaitéeCol.setPrefWidth(boissonsCommandéesTableView.getPrefWidth() / 7);

        quantitéSouhaitéeCol.setCellFactory(TextFieldTableCell.forTableColumn());

        quantitéSouhaitéeCol.setOnEditCommit(e -> {
            if (parseInt(e.getNewValue()) <= e.getRowValue().getQuantité()) {
                boissonsCommandéesTableView.getItems().get(e.getTablePosition().getRow()).setQuantitéSouhaitée(e.getNewValue());
            } else {
                boissonsCommandéesTableView.getItems().get(e.getTablePosition().getRow()).setQuantitéSouhaitée("0");
                boissonsCommandéesTableView.getColumns().get(6).setVisible(false);
                boissonsCommandéesTableView.getColumns().get(6).setVisible(true);
            }
        });

        quantitéSouhaitéeCol.setEditable(true);
        boissonsCommandéesTableView.setEditable(true);

        boissonsCommandéesTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibilitéCol,
                datePéremptionCol, quantitéDispoCol, quantitéSouhaitéeCol);

        return boissonsCommandéesTableView;
    }
}
