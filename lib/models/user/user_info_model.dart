// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  UserInfoModel({
    this.accessToken,
    this.tokenType,
    this.userinfo,
    this.expiresAt,
  });

  String accessToken;
  String tokenType;
  Userinfo userinfo;
  DateTime expiresAt;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    userinfo: Userinfo.fromJson(json["userinfo"]),
    expiresAt: DateTime.parse(json["expires_at"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "userinfo": userinfo.toJson(),
    "expires_at": expiresAt.toIso8601String(),
  };
}

class Userinfo {
  Userinfo({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String type;
  dynamic createdAt;
  dynamic updatedAt;

  factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    type: json["type"],
    createdAt: json["created_at"] ==null ?DateTime.now(): DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] ==null ? DateTime.now():DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "type": type,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
