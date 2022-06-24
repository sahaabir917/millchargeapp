// To parse this JSON data, do
//
//     final generalInfoModel = generalInfoModelFromJson(jsonString);

import 'dart:convert';

GeneralInfoModel generalInfoModelFromJson(String str) => GeneralInfoModel.fromJson(json.decode(str));

String generalInfoModelToJson(GeneralInfoModel data) => json.encode(data.toJson());

class GeneralInfoModel {
  GeneralInfoModel({
    this.mytotaldebit,
    this.mytotalcredit,
    this.monthTotaldebit,
    this.monthTotalCredit,
    this.monthsTotalMill,
    this.mytotalmill,
    this.cashinhand,
    this.currentMillCharge,
    this.mytotalcost,
    this.back,
    this.addmore,
  });

  Mytotaldebit mytotaldebit;
  List<Mytotalcredit> mytotalcredit;
  MonthTotaldebit monthTotaldebit;
  MonthTotalCredit monthTotalCredit;
  MonthsTotalMill monthsTotalMill;
  Mytotalmill mytotalmill;
  int cashinhand;
  double currentMillCharge;
  double mytotalcost;
  double back;
  int addmore;

  factory GeneralInfoModel.fromJson(Map<String, dynamic> json) => GeneralInfoModel(
    mytotaldebit: Mytotaldebit.fromJson(json["mytotaldebit"]),
    mytotalcredit: List<Mytotalcredit>.from(json["mytotalcredit"].map((x) => Mytotalcredit.fromJson(x))),
    monthTotaldebit: MonthTotaldebit.fromJson(json["monthTotaldebit"]),
    monthTotalCredit: MonthTotalCredit.fromJson(json["monthTotalCredit"]),
    monthsTotalMill: MonthsTotalMill.fromJson(json["monthsTotalMill"]),
    mytotalmill: Mytotalmill.fromJson(json["mytotalmill"]),
    cashinhand: json["cashinhand"],
    currentMillCharge: json["currentMillCharge"].toDouble(),
    mytotalcost: json["mytotalcost"].toDouble(),
    back: json["back"].toDouble(),
    addmore: json["addmore"],
  );

  Map<String, dynamic> toJson() => {
    "mytotaldebit": mytotaldebit.toJson(),
    "mytotalcredit": List<dynamic>.from(mytotalcredit.map((x) => x.toJson())),
    "monthTotaldebit": monthTotaldebit.toJson(),
    "monthTotalCredit": monthTotalCredit.toJson(),
    "monthsTotalMill": monthsTotalMill.toJson(),
    "mytotalmill": mytotalmill.toJson(),
    "cashinhand": cashinhand,
    "currentMillCharge": currentMillCharge,
    "mytotalcost": mytotalcost,
    "back": back,
    "addmore": addmore,
  };
}

class MonthTotalCredit {
  MonthTotalCredit({
    this.name,
    this.monthTotalCredit,
  });

  String name;
  String monthTotalCredit;

  factory MonthTotalCredit.fromJson(Map<String, dynamic> json) => MonthTotalCredit(
    name: json["name"],
    monthTotalCredit: json["month_total_credit"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "month_total_credit": monthTotalCredit,
  };
}

class MonthTotaldebit {
  MonthTotaldebit({
    this.name,
    this.monthTotalDebit,
  });

  String name;
  String monthTotalDebit;

  factory MonthTotaldebit.fromJson(Map<String, dynamic> json) => MonthTotaldebit(
    name: json["name"],
    monthTotalDebit: json["month_total_debit"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "month_total_debit": monthTotalDebit,
  };
}

class MonthsTotalMill {
  MonthsTotalMill({
    this.totalMills,
  });

  String totalMills;

  factory MonthsTotalMill.fromJson(Map<String, dynamic> json) => MonthsTotalMill(
    totalMills: json["total_mills"],
  );

  Map<String, dynamic> toJson() => {
    "total_mills": totalMills,
  };
}

class Mytotalcredit {
  Mytotalcredit({
    this.name,
    this.myTotalCredit,
  });

  String name;
  String myTotalCredit;

  factory Mytotalcredit.fromJson(Map<String, dynamic> json) => Mytotalcredit(
    name: json["name"],
    myTotalCredit: json["my_total_credit"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "my_total_credit": myTotalCredit,
  };
}

class Mytotaldebit {
  Mytotaldebit({
    this.name,
    this.myTotalDebit,
  });

  String name;
  String myTotalDebit;

  factory Mytotaldebit.fromJson(Map<String, dynamic> json) => Mytotaldebit(
    name: json["name"],
    myTotalDebit: json["my_total_debit"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "my_total_debit": myTotalDebit,
  };
}

class Mytotalmill {
  Mytotalmill({
    this.name,
    this.myTotalMills,
  });

  String name;
  String myTotalMills;

  factory Mytotalmill.fromJson(Map<String, dynamic> json) => Mytotalmill(
    name: json["name"],
    myTotalMills: json["my_total_mills"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "my_total_mills": myTotalMills,
  };
}
