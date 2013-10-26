import 'dart:html';
import 'dart:convert';
import 'scene.dart';
import 'package:json_object/json_object.dart';
import 'utils.dart';

String currentNode = "";
Scene currentScene;
DivElement mainEl;
DivElement currentSceneDiv;
void main() {
  currentNode = "C1Q1";
  window.localStorage.clear;
  mainEl = querySelector("#sample_container_id");
  startNode(currentNode);
  ButtonElement b = querySelector("#nextPageButton");
  b.onClick.listen(onNextPage);
}
startNode(String nodeNumber){
  HttpRequest.getString("scenes/"+nodeNumber+'.json').then((response){
    currentScene = Utils.jsonObjectToScene(response);
    writeSceneToBook(currentScene);
  });
}
onNextPage(MouseEvent e){
  SelectElement se = querySelector("#conjugaison");
  int selectedIndex = se.selectedIndex;
  window.localStorage[currentNode] = se.item(selectedIndex).value;
  DivElement de = new DivElement();
  de.appendText(currentScene.text.replaceAll("*",se.item(selectedIndex).text));
  de.id=currentNode+"div";
  //currentSceneDiv.appendText(se.item(selectedIndex).text);
  //se.parent.insertBefore(de,se);
  querySelector("#"+currentNode+"div").remove();
  mainEl.append(de);
  writeFeedbackToBook(currentScene.feedback.elementAt(selectedIndex));
  print(window.localStorage[currentNode]);
}

writeSceneToBook(Scene scene){
  DivElement sceneDiv = new DivElement();
  currentSceneDiv = sceneDiv;
  sceneDiv.id = currentNode+"div";
  List<String> textParts = scene.text.split("*");
  sceneDiv.appendText(textParts.elementAt(0));
  SelectElement se = new SelectElement();
  se.id = "conjugaison";
  scene.choix.forEach((String s){
    OptionElement oe = new OptionElement();
    oe.value = scene.valeur.elementAt(scene.choix.indexOf(s));
    oe.text = s;
    se.append(oe);
  });
  sceneDiv.append(se);
  sceneDiv.appendText(textParts.elementAt(1));
  mainEl.append(sceneDiv);
}
writeFeedbackToBook(String feedback){
  DivElement feedbackDiv = new DivElement();
  feedbackDiv.appendText(feedback);
  mainEl.append(feedbackDiv);
}
rewriteDiv(String choix){

}