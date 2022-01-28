package ch.heig.ui;

import ch.heig.data.*;
import ch.heig.db.DBConnection;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.stage.Stage;

import java.util.List;

import static java.lang.Integer.parseInt;

public class BoissonsUI {
    public static void showBoissonsWindow(DBConnection db, Personne p) {
        List<Biere> bieres = db.getBieres();
        List<Vin> vins = db.getVins();
        List<BoissonSoft> softs = db.getSofts();

        ObservableList<Biere> biereObservableList = FXCollections.observableArrayList(bieres);
        TableView<Biere> biereTableView = createBieresTableView(biereObservableList, db, p);

        ObservableList<Vin> vinsObservableList = FXCollections.observableArrayList(vins);
        TableView<Vin> vinsTableView = createVinsTableView(vinsObservableList, db, p);

        ObservableList<BoissonSoft> softsObservableList = FXCollections.observableArrayList(softs);
        TableView<BoissonSoft> softsTableView = createSoftsTableView(softsObservableList, db, p);

        Stage stage = new Stage();
        VBox box = new VBox();
        box.setPadding(new Insets(10));

        // How to center align content in a layout manager in JavaFX
        box.setAlignment(Pos.CENTER);

        Label labelInfo = new Label("Cliquez sur une ligne pour accéder aux évaluations.");
        labelInfo.setFont(new Font(20));

        Label labelBieres = new Label("Bières :");
        labelBieres.setFont(new Font(20));

        Label labelVins = new Label("Vins :");
        labelVins.setFont(new Font(20));

        Label labelSofts = new Label("Softs :");
        labelSofts.setFont(new Font(20));

        box.getChildren().add(labelInfo);
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

    private static TableView<Biere> createBieresTableView(ObservableList<Biere> bieres, DBConnection db, Personne p) {
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

        bieresTableView.setRowFactory( tv -> {
            TableRow<Biere> row = new TableRow<>();
            row.setOnMouseClicked(e -> {
                if(!row.isEmpty()) {
                    openEvaluationWindow(row.getItem(), db, p);
                }
            });
            return row;
        });

        bieresTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibiliteCol,
                tauxAlcoolCol, ageMinCol, paysCol, regionCol, typeCol);

        return bieresTableView;
    }

    private static TableView<Vin> createVinsTableView(ObservableList<Vin> vins, DBConnection db, Personne p) {
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

        vinsTableView.setRowFactory( tv -> {
            TableRow<Vin> row = new TableRow<>();
            row.setOnMouseClicked(e -> {
                if(!row.isEmpty()) {
                    openEvaluationWindow(row.getItem(), db, p);
                }
            });
            return row;
        });

        vinsTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibiliteCol,
                tauxAlcoolCol, ageMinCol, paysCol, regionCol, typeCol, anneeCol);

        return vinsTableView;
    }

    private static TableView<BoissonSoft> createSoftsTableView(ObservableList<BoissonSoft> softs, DBConnection db, Personne p) {
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

        softsTableView.setRowFactory( tv -> {
            TableRow<BoissonSoft> row = new TableRow<>();
            row.setOnMouseClicked(e -> {
                if(!row.isEmpty()) {
                    openEvaluationWindow(row.getItem(), db, p);
                }
            });
            return row;
        });

        softsTableView.getColumns().setAll(idCol, nomCol, contenanceCol, disponibiliteCol);

        return softsTableView;
    }

    private static void openEvaluationWindow(Boisson boisson, DBConnection db, Personne p) {
        Stage stage = new Stage();
        GridPane gridpane = new GridPane();
        gridpane.setHgap(10);
        gridpane.setVgap(20);
        gridpane.setPadding(new Insets(30, 0, 0, 30));

        Label labelBoisson = new Label("Boisson : " + boisson.getNom());
        labelBoisson.setFont(new Font(20));
        Label labelNoteEx = new Label("Note moyenne : ");
        labelNoteEx.setFont(new Font(10));
        Label labelNote = new Label(Double.toString(db.getNoteMoyenne(boisson)));
        labelNote.setFont(new Font(10));

        gridpane.add(labelBoisson, 0, 0);
        gridpane.add(labelNoteEx, 0, 1);
        gridpane.add(labelNote, 1, 1);

        Integer note = db.getNote(boisson, p);
        if(note == null) {
            GridPane pane2 = new GridPane();
            pane2.setHgap(2);
            pane2.setVgap(10);
            //gridpane.setPadding(new Insets(30, 0, 0, 30));

            RadioButton rb1 = new RadioButton("1");
            RadioButton rb2 = new RadioButton("2");
            RadioButton rb3 = new RadioButton("3");
            RadioButton rb4 = new RadioButton("4");
            RadioButton rb5 = new RadioButton("5");

            ToggleGroup group = new ToggleGroup();
            rb1.setToggleGroup(group);
            rb2.setToggleGroup(group);
            rb3.setToggleGroup(group);
            rb3.setSelected(true);
            rb4.setToggleGroup(group);
            rb5.setToggleGroup(group);

            Button btn = new Button();
            btn.setText("Noter");
            btn.setOnAction(event -> {
                int choix = parseInt( ((RadioButton)group.getSelectedToggle()).getText());
                db.addEvaluation(boisson, p, choix);

                // Update view
                gridpane.getChildren().remove(pane2);

                Label noteUtilisateur = new Label(" Note membre : ");
                noteUtilisateur.setFont(new Font(10));
                Label labelNoteUtilisateur = new Label(Integer.toString(choix));
                labelNoteUtilisateur.setFont(new Font(10));
                gridpane.add(noteUtilisateur, 0, 2);
                gridpane.add(labelNoteUtilisateur, 1, 2);

                labelNote.setText(Double.toString(db.getNoteMoyenne(boisson)));
            });
            pane2.add(rb1, 0, 0);
            pane2.add(rb2, 1, 0);
            pane2.add(rb3, 2, 0);
            pane2.add(rb4, 3, 0);
            pane2.add(rb5, 4, 0);
            pane2.add(btn, 0, 1);
            gridpane.add(pane2, 0, 2);
        } else {
            Label noteUtilisateur = new Label(" Note membre : ");
            noteUtilisateur.setFont(new Font(10));
            Label labelNoteUtilisateur = new Label(note.toString());
            labelNoteUtilisateur.setFont(new Font(10));
            gridpane.add(noteUtilisateur, 0, 2);
            gridpane.add(labelNoteUtilisateur, 1, 2);
        }
        Scene scene = new Scene(gridpane, 300, 300);
        stage.setScene(scene);
        stage.setTitle("Boisson " + boisson.getNom());
        stage.setResizable(false);
        stage.show();
    }
}
