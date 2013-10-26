import 'dart:html';
import 'dart:convert';
import 'package:json_object/json_object.dart';

Element mainEl;
Element someDiv;
void main() {
  mainEl = querySelector("#sample_container_id");
  //loadNode("scene");
  ButtonElement b = querySelector("#button");
  b.onClick.listen(onButton);
}
loadNode(String nodeNumber){
  HttpRequest.getString(nodeNumber+'.json').then((response){
    var jsonRoot = new JsonObject.fromJsonString(response);
    print(jsonRoot.scene.possibilites.possibilite);
  });
}
onButton(MouseEvent e){
  DivElement aDiv = new DivElement();
  aDiv.text= "COUCOU JE SUIS UN DIV!";
  aDiv.classes.add("new");
  mainEl.append(aDiv);


  if(mainEl.children.length>5){
    mainEl.children.elementAt(0).classes.remove("new");
    mainEl.children.elementAt(0).classes.add("previous");
    //mainEl.children.elementAt(0).remove();
    mainEl.children.elementAt(0).onTransitionEnd(print("TATA"));
    //onTransitionEnd.listen(mainEl.children.elementAt(0).remove()); //mainEl.children.elementAt(0).remove());
  }
}