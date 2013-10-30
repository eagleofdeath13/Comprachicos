part of comprachicos;

class Utils {
  utils();
  static Scene jsonObjectToScene(String json){
    Map scene = JSON.parse(json)['scene'];
    List<String> choix = scene["possibilite"]["choix"];
    List<String> valeur = scene["possibilite"]["valeur"];
    List<String> feedback = scene["possibilite"]["feedback"];
    List<Map<String,int>> increments = new List();
    scene["possibilite"]["increments"].forEach((a){
      Map<String,int> increment = new Map<String,int>();
      increment[a[0][0]] = int.parse(a[0][1]);
      increments.add(increment);
    });
    return new Scene(scene["texte"],choix,valeur,feedback,increments);
  }
}
