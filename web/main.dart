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
    List<String> choix = new List<String>();
    List<String> valeur = new List<String>();
    List<String> feedback = new List<String>();
    print(jsonRoot.scene.possibilite.choix[0]);
    choix.add(jsonRoot.scene.possibilite.choix[0]);
    choix.add(jsonRoot.scene.possibilite.choix[1]);
    choix.add(jsonRoot.scene.possibilite.choix[2]);
    valeur.add(jsonRoot.scene.possibilite.valeur[0]);
    valeur.add(jsonRoot.scene.possibilite.valeur[1]);
    valeur.add(jsonRoot.scene.possibilite.valeur[2]);
    feedback.add(jsonRoot.scene.possibilite.feedback[0]);
    feedback.add(jsonRoot.scene.possibilite.feedback[1]);
    feedback.add(jsonRoot.scene.possibilite.feedback[2]);
    Scene s = new Scene(jsonRoot.scene.texte,choix,valeur,feedback);
    writeSceneToBook(s);
  });
}
onButton(MouseEvent e){

}

writeSceneToBook(Scene scene){
  DivElement sceneDiv = new DivElement();
  List<String> textParts = scene.text.split("*");
  sceneDiv.appendText(textParts.elementAt(0));
  SelectElement se = new SelectElement();
  scene.choix.forEach((String s){
    OptionElement oe = new OptionElement();
    oe.text = s;
    oe.value = s;
    se.append(oe);
  });
  sceneDiv.append(se);
  sceneDiv.appendText(textParts.elementAt(1));
  mainEl.append(sceneDiv);
}