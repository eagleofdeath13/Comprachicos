import 'dart:html';
import 'dart:convert';
import 'scene.dart';
import 'package:json_object/json_object.dart';

DivElement mainEl;
void main() {
  mainEl = querySelector("#sample_container_id");
  startNode("C1Q1");
  ButtonElement b = querySelector("#button");
  b.onClick.listen(onButton);
}
startNode(String nodeNumber){
  HttpRequest.getString("scenes/"+nodeNumber+'.json').then((response){
    JsonObject jsonRoot = new JsonObject.fromJsonString(response);
    List<String> choix,valeur,feedback;/*
    choix[1]=jsonRoot.scene.possibilite.choix.1;
    choix[2]=jsonRoot.scene.possibilite.choix.2;
    choix[3]=jsonRoot.scene.possibilite.choix.3;
    valeur[1]=jsonRoot.scene.possibilite.valeur.1;
    valeur[2]=jsonRoot.scene.possibilite.valeur.2;
    valeur[3]=jsonRoot.scene.possibilite.valeur.3;
    feedback[1]=jsonRoot.scene.possibilite.feedback.1;
    feedback[2]=jsonRoot.scene.possibilite.feedback.2;
    feedback[3]=jsonRoot.scene.possibilite.feedback.3;
    }*/
    //Scene s = new Scene(jsonRoot.scene.texte);
   // writeSceneToBook(jsonRoot.scene);
    //print(jsonRoot.scene.suite.condition.scenes);
  });
}
onButton(MouseEvent e){
  /*DivElement aDiv = new DivElement();
  aDiv.text= "COUCOU JE SUIS UN DIV!";
  aDiv.classes.add("new");
  mainEl.append(aDiv);*/
}

writeSceneToBook(var scene){
  print(scene);
  DivElement sceneDiv = new DivElement();
  sceneDiv.appendText(scene.text.split("*")[0]);
  String a = "azeeazeaz*gfjdflgl";
  print(a.split("*"));
  //List<String> text = scene.text
}