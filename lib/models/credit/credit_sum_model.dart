// To parse this JSON data, do
//
//     final creditSumModel = creditSumModelFromJson(jsonString);

import 'dart:convert';

CreditSumModel creditSumModelFromJson(String str) => CreditSumModel.fromJson(json.decode(str));

String creditSumModelToJson(CreditSumModel data) => json.encode(data.toJson());

class CreditSumModel {
  CreditSumModel({
    this.data,
  });

  List<Datum> data;

  factory CreditSumModel.fromJson(Map<String, dynamic> json) => CreditSumModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.name,
    this.totalCredit,
  });

  String name;
  String totalCredit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    totalCredit: json["total_credit"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "total_credit": totalCredit,
  };
}
