package tour.javafx;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

public class App001 extends Application {
  public static void main(String[] args) {
    Application.launch(args);
  }

  @Override
  public void start(Stage primaryStage) throws Exception {
    primaryStage.setTitle("JavaFX App 001");

    Label label = new Label("Show JavaFX");
    Scene scene = new Scene(label, 400, 200);
    primaryStage.setScene(scene);

    primaryStage.show();
  }
}
