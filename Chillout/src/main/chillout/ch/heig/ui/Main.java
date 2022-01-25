package ch.heig.ui;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.*;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public final class Main extends Application {
    private String loggedInUser;
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {TilePane welcomePane = new TilePane();
        welcomePane.setPadding(new Insets(10, 10, 10, 10));
        welcomePane.setPrefColumns(2);
        HBox hbox2 = new HBox(20); // spacing = 8
        Text welcomeText = new Text();
        welcomeText.setFont(new Font(30));
        welcomeText.setText("Bienvenue sur l'application du Chillout !");
        hbox2.getChildren().addAll(welcomeText);
        welcomePane.setStyle("-fx-background-color: #9FDFC8;");
        welcomePane.getChildren().add(hbox2);

        TilePane loginChoices = new TilePane();
        Text loginText = new Text();
        loginText.setFont(new Font(12));
        loginText.setStyle("-fx-padding: 15px; -fx-alignment: left;");
        loginText.setText("Veuillez vous loger pour utiliser l'application : ");
        Button btnLogin = new Button();
        btnLogin.setText("Login");
        btnLogin.setOnAction(event -> showLoginScreen());
        loginChoices.getChildren().add(loginText);
        loginChoices.getChildren().add(btnLogin);
        loginChoices.setStyle("-fx-padding: 30px;");

        // A layout container for UI controls
        BorderPane mainStack = new BorderPane();
        mainStack.setCenter(loginChoices);
        mainStack.setTop(welcomePane);

        // Top level container for all view content
        Scene scene = new Scene(mainStack, 800, 500);

        // primaryStage is the main top level window created by platform
        primaryStage.setTitle("Chillout App");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public void setLoggedInUser(String user) {
        loggedInUser = user;

        Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle("Successful login");
        alert.setHeaderText("Successful login");
        String s = user + " logged in!";
        alert.setContentText(s);
        alert.show();
    }

    public void showLoginScreen() {
        Stage stage = new Stage();

        VBox box = new VBox();
        box.setPadding(new Insets(10));

        // How to center align content in a layout manager in JavaFX
        box.setAlignment(Pos.CENTER);

        Label label = new Label("Entrez votre nom et votre id");

        TextField textUser = new TextField();
        textUser.setPromptText("Entrez votre nom");
        TextField textPass = new TextField();
        textPass.setPromptText("Entrez votre id");

        Button btnLogin = new Button();
        btnLogin.setText("Login");

        btnLogin.setOnAction(event -> {
            // Assume success always!
            setLoggedInUser(textUser.getText());
            stage.close(); // return to main window
        });

        box.getChildren().add(label);
        box.getChildren().add(textUser);
        box.getChildren().add(textPass);
        box.getChildren().add(btnLogin);
        Scene scene = new Scene(box, 250, 150);
        stage.setScene(scene);
        stage.show();
    }
}