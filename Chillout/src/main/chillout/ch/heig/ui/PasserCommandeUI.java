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
        TableColumn quantit??Souhait??eCol = cols.get(6);
        for (Object row : tv.getItems()) {
            int val = parseInt((String)quantit??Souhait??eCol.getCellObservableValue(row).getValue());
            if(val > 0) {
                boissonsACommander.add((BoissonStockee)row);
            }
        }

        if(boissonsACommander.size() > 0) {
            db.addNewCommande(boissonsACommander, p);
        }
    }

    private static TableView<BoissonStockee> createListeBoissonsDisponiblesTableView(ObservableList<BoissonStockee> listeBoissons) {
        TableView<BoissonStockee> boissonsCommand??esTableView = new TableView<>();
        boissonsCommand??esTableView.setPrefWidth(800);

        boissonsCommand??esTableView.setItems(listeBoissons);

        TableColumn<BoissonStockee, String> idCol = new TableColumn<>("Id");
        TableColumn<BoissonStockee, String> nomCol = new TableColumn<>("Nom");
        TableColumn<BoissonStockee, String> contenanceCol = new TableColumn<>("Contenance");
        TableColumn<BoissonStockee, String> disponibilit??Col = new TableColumn<>("Disponibilit??");
        TableColumn<BoissonStockee, String> dateP??remptionCol = new TableColumn<>("Date P??remption");
        TableColumn<BoissonStockee, String> quantit??DispoCol = new TableColumn<>("Quantit?? disponible");
        TableColumn<BoissonStockee, String> quantit??Souhait??eCol = new TableColumn<>("Quantit?? souhait??e");

        idCol.setCellValueFactory(new PropertyValueFactory<>("id"));
        nomCol.setCellValueFactory(new PropertyValueFactory<>("nom"));
        contenanceCol.setCellValueFactory(new PropertyValueFactory<>("contenance"));
        disponibilit??Col.setCellValueFactory(new PropertyValueFactory<>("disponibilit??"));
        dateP??remptionCol.setCellValueFactory(new PropertyValueFactory<>("dateP??remption"));
        quantit??DispoCol.setCellValueFactory(new PropertyValueFactory<>("quantit??"));
        quantit??Souhait??eCol.setCellValueFactory(new PropertyValueFactory<>("quantit??Souhait??e"));

        idCol.setPrefWidth(boissonsCommand??esTableView.getPrefWidth() / 7);
        nomCol.setPrefWidth(boissonsCommand??esTableView.getPrefWidth() / 7);
        contenanceCol.setPrefWidth(boissonsCommand??esTableView.getPrefWidth() / 7);
        disponibilit??Col.setPrefWidth(boissonsCommand??esTableView.getPrefWidth() / 7);
        dateP??remptionCol.setPrefWidth(boissonsCommand??esTableView.getPrefWidth() / 7);
        quantit??DispoCol.setPrefWidth(boissonsCommand??esTableView.getPrefWidth() / 7);
        quantit??Souhait??eCol.setPrefWidth(boissonsCommand??esTableView.getPrefWidth() / 7);

        quantit??Souhait??eCol.setCellFactory(TextFieldTableCell.forTableColumn());

        quantit??Souhait??eCol.setOnEditCommit(e -> {
            if (parseInt(e.getNewValue()) <= e.getRowValue().getQuantit??()) {
                boissonsCommand??esTableView.getItems().get(e.getTablePosition().getRow()).setQuantit??Souhait??e(e.getNewValue());
            } else {
                boissonsCommand??esTableView.getItems().get(e.getTablePosition().getRow()).setQuantit??Souhait??e("0");
                boissonsCommand??esTableView.getColumns().get(6).setVisible(false);
                boissonsCommand??esTableView.getColumns().get(6).setVisible(true);
            }
        });

        quantit??Souhait??eCol.setEditable(true);
        boissonsCommand??esTableView.setEditable(true);

        boissonsCommand??esTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibilit??Col,
                dateP??remptionCol, quantit??DispoCol, quantit??Souhait??eCol);

        return boissonsCommand??esTableView;
    }
}
