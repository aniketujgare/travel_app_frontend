// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String token;
  final String email;
  final String userId;

  UserModel({
    required this.token,
    required this.email,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        email: json["email"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "email": email,
        "userId": userId,
      };
}
