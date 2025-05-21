// To parse this JSON data, do

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    List<Superhero> superheros;

    Welcome({
        required this.superheros,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        superheros: List<Superhero>.from(json["superheros"].map((x) => Superhero.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "superheros": List<dynamic>.from(superheros.map((x) => x.toJson())),
    };
}

class Superhero {
    String name;
    String power;
    String url;

    Superhero({
        required this.name,
        required this.power,
        required this.url,
    });

    factory Superhero.fromJson(Map<String, dynamic> json) => Superhero(
        name: json["name"],
        power: json["power"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "power": power,
        "url": url,
    };
}
