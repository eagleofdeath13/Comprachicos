import 'dart:html';
import 'dart:convert';
import 'scene.dart';
import 'package:json_object/json_object.dart';
import 'utils.dart';

String currentNode = "";
Scene currentScene;
DivElement mainEl;
DivElement currentSceneDiv;
Map storage = new Map();
void main(){
  storage["a"]=0;
  String a="a";
  print(storage[a]);
  currentNode = "C1Q1";
  window.localStorage.clear;
  initLocalStorage();
  mainEl = querySelector("#sample_container_id");
  startNode(currentNode);
  ButtonElement b = querySelector("#nextPageButton");
  b.onClick.listen(onNextPage);
}//*/
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
  de.classes.add("wrap");
  de.appendHtml(currentScene.text.replaceAll("*",se.item(selectedIndex).text));
  de.id=currentNode+"div";
  querySelector("#"+currentNode+"div").remove();
  mainEl.append(de);
  writeFeedbackToBook(currentScene.feedback.elementAt(selectedIndex));
  
  if(currentScene.scenesSuivantes.length == 1){
    startNode(currentScene.scenesSuivantes[0]);
    currentNode = currentScene.scenesSuivantes[0];
  }
}

writeSceneToBook(Scene scene){
  DivElement sceneDiv = new DivElement();
  //sceneDiv.classes
  currentSceneDiv = sceneDiv;
  sceneDiv.classes.add("wrap");
  sceneDiv.id = currentNode+"div";
  List<String> textParts = scene.text.split("*");
  sceneDiv.appendHtml(textParts.elementAt(0));
  SelectElement se = new SelectElement();
  se.id = "conjugaison";
  scene.choix.forEach((String s){
    OptionElement oe = new OptionElement();
    oe.value = scene.valeur.elementAt(scene.choix.indexOf(s));
    oe.text = s;
    se.append(oe);
  });
  sceneDiv.append(se);
  sceneDiv.appendHtml(textParts.elementAt(1));
  mainEl.append(sceneDiv);
}

writeFeedbackToBook(String feedback){
  DivElement feedbackDiv = new DivElement();
  feedbackDiv.classes.add("wrap");
  feedbackDiv.appendHtml(feedback);
  mainEl.append(feedbackDiv);
}

initLocalStorage(){
  window.localStorage.clear;
  HttpRequest.getString("conf.json").then((response){
      JsonObject jsonRoot = new JsonObject.fromJsonString(response);
      print("jsonRoot");
      Map keys = jsonRoot.keys;
      print(keys);
      jsonRoot.keys.forEach((key){
        String str = "a";
        window.localStorage.str = "0";
        window.localStorage.keys[key] = "0";
        print(jsonRoot.keys[0]);
      });
  });
  print("Local Storage done");
}

incrementValues(){
  JsonObject jsonRoot = new JsonObject.fromJsonString('{"increments":[[{"key":"MH","value":"1"},{"key":"MP","value":"2"},{"key":"MM","value":"1"}],[{"key":"MH","value":"1"},{"key":"MP","value":"2"},{"key":"MM","value":"1"}],[{"key":"MH","value":"1"},{"key":"MP","value":"2"},{"key":"MM","value":"1"}]]}');
  jsonRoot.increments[0].forEach((keyValuePair){
    StringBuffer sb = new StringBuffer();
    sb.write(int.parse(window.localStorage[keyValuePair.key]) + int.parse(keyValuePair.value));
    window.localStorage[keyValuePair.key] = sb.toString();
    print("Stored value");
    print(window.localStorage[keyValuePair.key]);
  });
}