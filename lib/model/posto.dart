import 'package:intl/intl.dart';

class Posto {

  int id;
  String nome;
  double precoAlcool;
  double precoGasolina;
  //DateTime instante = DateTime.now();

  Posto.fromMap(Map map){
    id             = map["c_id"];
    nome           = map["c_nome"];
    precoAlcool    = map["c_precoAlcool"];
    precoGasolina  = map["c_precoGasolina"];
    //instante       = map["c_instante"];
    //instante       = DateTime.parse(map["c_instante"]);
  }

  Posto();

  Map toMap() {
    Map<String, dynamic> map = {
      "c_nome": nome,
      "c_precoAlcool": precoAlcool,
      "c_precoGasolina": precoGasolina
      //"c_instante": instante
      //"c_instante": new DateFormat("dd-MM-yyyy").format(instante)
    };
    if (id != null ) {
      map["c_id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Posto[ id: $id, "
        "nome: $nome, "
        "precoAlcool: $precoAlcool, "
        "precoGasolina: $precoGasolina "
       // "instante: $instante "
        "]";
  }
}