import 'dart:convert';

class Plat {
  String descripcio;
  bool disponible;
  String? foto;
  String geo;
  String nom;
  String restaurant;
  String tipus;

  Plat({
    required this.descripcio,
    required this.disponible,
    this.foto,
    required this.geo,
    required this.nom,
    required this.restaurant,
    required this.tipus,
  });

  factory Plat.fromJson(String str) => Plat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Plat.fromMap(Map<String, dynamic> json) => Plat(
        descripcio: json["descripcio"],
        disponible: json["disponible"],
        foto: json["foto"],
        geo: json["geo"],
        nom: json["nom"],
        restaurant: json["restaurant"],
        tipus: json["tipus"],
      );

  Map<String, dynamic> toMap() => {
        "descripcio": descripcio,
        "disponible": disponible,
        "foto": foto,
        "geo": geo,
        "nom": nom,
        "restaurant": restaurant,
        "tipus": tipus,
      };
}
