// To parse this JSON data, do
//
//     final sliders = slidersFromJson(jsonString);

import 'dart:convert';

List<Sliders> slidersFromJson(String str) => List<Sliders>.from(json.decode(str).map((x) => Sliders.fromJson(x)));

String slidersToJson(List<Sliders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sliders {
  final int? id;
  final String? title;
  final String? image;
  final String? description;

  Sliders({
    this.id,
    this.title,
    this.image,
    this.description,
  });

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
  };
}
