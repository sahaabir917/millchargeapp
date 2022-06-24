// To parse this JSON data, do
//
//     final localGeneralInfoModel = localGeneralInfoModelFromJson(jsonString);

import 'dart:convert';

LocalGeneralInfoModel localGeneralInfoModelFromJson(String str) => LocalGeneralInfoModel.fromJson(json.decode(str));

String localGeneralInfoModelToJson(LocalGeneralInfoModel data) => json.encode(data.toJson());

class LocalGeneralInfoModel {
  LocalGeneralInfoModel({
    this.mytotaldebit,
    this.name,
    this.mytotalcredit,
    this.monthtotaldebit,
    this.monthtotalcredit,
    this.totalmills,
    this.mytotalmills,
    this.cashinhand,
    this.currentmillcharge,
    this.mytotalcost,
    this.back,
    this.addmore,
  });

  String mytotaldebit;
  String name;
  String mytotalcredit;
  String monthtotaldebit;
  String monthtotalcredit;
  String totalmills;
  String mytotalmills;
  int cashinhand;
  double currentmillcharge;
  double mytotalcost;
  double back;
  int addmore;

  factory LocalGeneralInfoModel.fromJson(Map<String, dynamic> json) => LocalGeneralInfoModel(
    mytotaldebit: json["mytotaldebit"],
    name: json["name"],
    mytotalcredit: json["mytotalcredit"],
    monthtotaldebit: json["monthtotaldebit"],
    monthtotalcredit: json["monthtotalcredit"],
    totalmills: json["totalmills"],
    mytotalmills: json["mytotalmills"],
    cashinhand: json["cashinhand"],
    currentmillcharge: json["currentmillcharge"].toDouble(),
    mytotalcost: json["mytotalcost"].toDouble(),
    back: json["back"].toDouble(),
    addmore: json["addmore"],
  );

  Map<String, dynamic> toJson() => {
    "mytotaldebit": mytotaldebit,
    "name": name,
    "mytotalcredit": mytotalcredit,
    "monthtotaldebit": monthtotaldebit,
    "monthtotalcredit": monthtotalcredit,
    "totalmills": totalmills,
    "mytotalmills": mytotalmills,
    "cashinhand": cashinhand,
    "currentmillcharge": currentmillcharge,
    "mytotalcost": mytotalcost,
    "back": back,
    "addmore": addmore,
  };
}
