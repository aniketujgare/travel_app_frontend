// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

import 'dart:convert';

WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  final String id;
  final String userid;
  final List<Destination> destinations;

  WishlistModel({
    required this.id,
    required this.userid,
    required this.destinations,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        id: json["_id"],
        userid: json["userid"],
        destinations: List<Destination>.from(
            json["destinations"].map((x) => Destination.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "destinations": List<dynamic>.from(destinations.map((x) => x.toJson())),
      };
}

class Destination {
  final String id;
  final List<String> images;
  final String name;
  final String shortDescription;

  Destination({
    required this.id,
    required this.images,
    required this.name,
    required this.shortDescription,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json["_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        name: json["name"],
        shortDescription: json["shortDescription"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "shortDescription": shortDescription,
      };
}
