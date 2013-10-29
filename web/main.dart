import 'dart:html';
import 'dart:convert';
import 'dart:json';
import 'comprachicos.dart';

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
    window.scrollTo(window.scrollX,window.innerHeight);
  });
}
onNextPage(MouseEvent e){
  SelectElement se = querySelector("#conjugaison");
  int selectedIndex = se.selectedIndex;
  incrementValues(currentScene.increments.elementAt(selectedIndex));
  DivElement de = new DivElement();
  de.classes.add("wrap");
  de.appendHtml(currentScene.text.replaceAll("*","<p class='nort'>"+se.item(selectedIndex).text+"</p>"));
  de.id=currentNode+"div";
  querySelector("#"+currentNode+"div").remove();
  mainEl.append(de);
  writeFeedbackToBook(currentScene.feedback.elementAt(selectedIndex));
  String str = sceneSuivante();
  print("SceneSuivante");
  print(str);
  print("toto");
}

writeSceneToBook(Scene scene){
  DivElement sceneDiv = new DivElement();
  currentSceneDiv = sceneDiv;
  sceneDiv.classes.add("wrap");
  sceneDiv.classes.add("question");
  sceneDiv.id = currentNode+"div";
  List<String> textParts = scene.text.split("*");
  sceneDiv.appendHtml(textParts.elementAt(0));
  SelectElement se = new SelectElement();
  se.id = "conjugaison";
  print(scene.choix);
  scene.choix.forEach((String s){
    OptionElement oe = new OptionElement();
    oe.value = scene.valeur.elementAt(scene.choix.indexOf(s));
    oe.text = s;
    se.append(oe);
  });
  se.classes.add("nort");
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
    String sc;
    Map sceneMap = parse(response)["scene"];
    sceneMap["possibilite"]["suites"].forEach((suite){
      print("pos");
      if(sc == null){
        print("suite");
        print(suite);
        sc=suite["sceneSuivante"];
        print("true");
        suite["conditions"].forEach((condition){
          if(storage[condition[0]] < int.parse(condition[1])){
            sc = null;
          }
        });
        if(sc != null){
          currentNode = suite["sceneSuivante"];
          print("On a retour");
          print(suite["sceneSuivante"]);
          startNode(suite["sceneSuivante"]);
          print(storage["s"]);
          return suite["sceneSuivante"];
        }
      }
    });
  });
}