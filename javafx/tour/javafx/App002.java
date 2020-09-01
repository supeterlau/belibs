package tour.javafx;

import javafx.application.Application;
import javafx.stage.Stage;
import javafx.stage.Modality;
import javafx.stage.StageStyle;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;

public class App002 extends Application {
  public static void main(String[] args) {
    Application.launch(args);
  }

  @Override
  public void start(Stage primaryStage) throws Exception {
    VBox vBox = new VBox(new Label("JavaFX App002"));

    Scene scene = new Scene(vBox);

    primaryStage.setScene(scene);

    // set title
    primaryStage.setTitle("JavaFX App002 Window Title");

    // set position
    primaryStage.setX(100);
    primaryStage.setY(100);

    primaryStage.setWidth(600);
    primaryStage.setHeight(480);

    // fullsccreen mode: 必须 setScene
    primaryStage.setFullScreen(true);

    Stage stage = new Stage();
    stage.setTitle("new stage title");
    // Modality.APPLICATION_MODAL 阻塞全部 windows (wizards dialogs)
    // WINDOW_MODAL 仅阻塞 owns 新创建 Stage 的 window
    // NONE 不阻塞任何 window 如 browser window
    // stage.initModality(Modality.APPLICATION_MODAL);
    stage.initModality(Modality.WINDOW_MODAL);

    // stage owner
    // 一个 stage 可以被其他 stage 所有 owned
    stage.initOwner(primaryStage);

    // stage style
    // stage.initStyle(StageStyle.DECORATED);
    stage.initStyle(StageStyle.UNDECORATED);
    // stage.initStyle(StageStyle.TRANSPARENT);
    // stage.initStyle(StageStyle.UNIFIED);
    // stage.initStyle(StageStyle.UNILITY);


    primaryStage.show();
    
    stage.showAndWait();
  }
}
