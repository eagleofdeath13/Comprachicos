import 'dart:html';
import 'dart:convert';
import 'scene.dart';
import 'package:json_object/json_object.dart';
import 'utils.dart';

String currentNode = "";
Scene currentScene;
DivElement mainEl;
DivElement currentSceneDiv;
Map<String,int> storage = new Map<String,int>();
String currentJson = "";
void main(){
  storage["s"]=0;
  storage["mh"]=0;
  storage["mp"]=0;
  storage["r"]=0;
  currentNode = "C1Q1";
  mainEl = querySelector("#sample_container_id");
  startNode(currentNode);
  ButtonElement b = querySelector("#nextPageButton");
  b.onClick.listen(onNextPage);
}
startNode(String nodeNumber){
  print("startNode");
  print(nodeNumber);
  HttpRequest.getString("scenes/"+nodeNumber+'.json').then((response){
    currentJson = response;
    currentScene = Utils.jsonObjectToScene(response);
    writeSceneToBook(currentScene);
  });
}
onNextPage(MouseEvent e){
  SelectElement se = querySelector("#conjugaison");
  int selectedIndex = se.selectedIndex;
  incrementValues(currentScene.increments.elementAt(selectedIndex));
  DivElement de = new DivElement();
  de.classes.add("wrap");
  de.appendHtml(currentScene.text.replaceAll("*",se.item(selectedIndex).text));
  de.id=currentNode+"div";
  querySelector("#"+currentNode+"div").remove();
  mainEl.append(de);
  writeFeedbackToBook(currentScene.feedback.elementAt(selectedIndex));
  String str = sceneSuivante();
  print("SceneSuivante");
  print(str);
  print("toto");
  //startNode(str);


  /*if(currentScene.scenesSuivantes.length == 1){
    startNode(currentScene.scenesSuivantes[0]);
    currentNode = currentScene.scenesSuivantes[0];
  }*/
}

writeSceneToBook(Scene scene){
  DivElement sceneDiv = new DivElement();
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
  feedbackDiv.classes.add("feedback");
  feedbackDiv.appendHtml(feedback);
  mainEl.append(feedbackDiv);
}

incrementValues(Map<String, int> increments){
  print(increments);
  print(increments.keys);
  increments.keys.forEach((a){
    print("foreach");
    print(a);
    storage[a] += increments[a];
  });
}

String sceneSuivante(){
  print("Début suivante");
  HttpRequest.getString("scenes/"+currentNode+'.json').then((response){
    JsonObject scene = new JsonObject.fromJsonString(response).scene;
    bool test = true;
    scene.possibilite.suites.forEach((suite){
      print("pos");
      if(test == true){
        print("true");
      try{
        //print(suite.conditions);
      suite.conditions.forEach((condition){
        if(storage[condition[0]] < int.parse(condition[1])){
          test = false;
        }
      });
      }
      catch(e){
        print("erreur");
        print(e);
        currentNode = suite.sceneSuivante;
        startNode(suite.sceneSuivante);
        print(storage["s"]);
        test = false;
      };
      if(test == true){
        currentNode = suite.sceneSuivante;
        print("On a retour");
        print(suite.sceneSuivante);
        startNode(suite.sceneSuivante);
        print(storage["s"]);
        test = false;
        return suite.sceneSuivante;
      }
      }
    });
    //writeSceneToBook(currentScene);

  });
}