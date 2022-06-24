// To parse this JSON data, do
//
//     final unAuthorizedModel = unAuthorizedModelFromJson(jsonString);

import 'dart:convert';

UnAuthorizedModel unAuthorizedModelFromJson(String str) => UnAuthorizedModel.fromJson(json.decode(str));

String unAuthorizedModelToJson(UnAuthorizedModel data) => json.encode(data.toJson());

class UnAuthorizedModel {
  UnAuthorizedModel({
    this.message,
  });

  String message;

  factory UnAuthorizedModel.fromJson(Map<String, dynamic> json) => UnAuthorizedModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
