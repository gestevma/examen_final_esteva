import 'dart:convert';

import 'package:examen_final_esteva/model/plats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FireBaseProvider extends ChangeNotifier {
  final String _baseUrl =
      "examen-practic-sim-default-rtdb.europe-west1.firebasedatabase.app";
  final List<Plat> platsList = [];

  static Plat selectedPlat = Plat(
      descripcio: "",
      disponible: true,
      geo: "",
      nom: "",
      restaurant: "",
      tipus: "");

  bool isLoading = true;
  bool isSaving = false;

  FireBaseProvider() {
    getData();
  }

  //Retorna les dades de la base de firebase
  Future getData() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, "plats.json");
    final resp = await http.get(url);

    if (json.decode(resp.body) != null) {
      final Map<String, dynamic> dataMap = json.decode(resp.body);
      dataMap.forEach((key, value) {
        final tempData = Plat.fromMap(value);
        platsList.add(tempData);
      });
    }

    isLoading = false;
    notifyListeners();
  }
}
