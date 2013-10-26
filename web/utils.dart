import 'scene.dart';
import 'package:json_object/json_object.dart';

class Utils {
  utils();
  static Scene jsonObjectToScene(String json){
    JsonObject jsonRoot = new JsonObject.fromJsonString(json);
    List<String> choix = new List<String>();
    List<String> valeur = new List<String>();
    List<String> feedback = new List<String>();
    choix.add(jsonRoot.scene.possibilite.choix[0]);
    choix.add(jsonRoot.scene.possibilite.choix[1]);
    choix.add(jsonRoot.scene.possibilite.choix[2]);
    valeur.add(jsonRoot.scene.possibilite.valeur[0]);
    valeur.add(jsonRoot.scene.possibilite.valeur[1]);
    valeur.add(jsonRoot.scene.possibilite.valeur[2]);
    feedback.add(jsonRoot.scene.possibilite.feedback[0]);
    feedback.add(jsonRoot.scene.possibilite.feedback[1]);
    feedback.add(jsonRoot.scene.possibilite.feedback[2]);
    return new Scene(jsonRoot.scene.texte,choix,valeur,feedback);
  }
}
