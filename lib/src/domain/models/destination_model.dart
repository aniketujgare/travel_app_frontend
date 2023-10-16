// To parse this JSON data, do
//
//     final destinationModel = destinationModelFromJson(jsonString);

import 'dart:convert';

List<DestinationModel> destinationModelFromJson(String str) =>
    List<DestinationModel>.from(
        json.decode(str).map((x) => DestinationModel.fromJson(x)));

String destinationModelToJson(List<DestinationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationModel {
  final String id;
  final List<String> images;
  final String name;
  final String shortDescription;
  final List<String> keyAttractions;

  DestinationModel({
    required this.id,
    required this.images,
    required this.name,
    required this.shortDescription,
    required this.keyAttractions,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        id: json["_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        name: json["name"],
        shortDescription: json["shortDescription"],
        keyAttractions: List<String>.from(json["keyAttractions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "shortDescription": shortDescription,
        "keyAttractions": List<dynamic>.from(keyAttractions.map((x) => x)),
      };
}
