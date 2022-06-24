// To parse this JSON data, do
//
//     final userHostelModel = userHostelModelFromJson(jsonString);

import 'dart:convert';

UserHostelModel userHostelModelFromJson(String str) => UserHostelModel.fromJson(json.decode(str));

String userHostelModelToJson(UserHostelModel data) => json.encode(data.toJson());

class UserHostelModel {
  UserHostelModel({
    this.userhostel,
  });

  List<Userhostel> userhostel;

  factory UserHostelModel.fromJson(Map<String, dynamic> json) => UserHostelModel(
    userhostel: List<Userhostel>.from(json["userhostel"].map((x) => Userhostel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userhostel": List<dynamic>.from(userhostel.map((x) => x.toJson())),
  };
}

class Userhostel {
  Userhostel({
    this.hostelId,
  });

  String hostelId;

  factory Userhostel.fromJson(Map<String, dynamic> json) => Userhostel(
    hostelId: json["hostel_id"],
  );

  Map<String, dynamic> toJson() => {
    "hostel_id": hostelId,
  };
}
