// To parse this JSON data, do
//
//     final addCreditModel = addCreditModelFromJson(jsonString);

import 'dart:convert';

AddCreditModel addCreditModelFromJson(String str) => AddCreditModel.fromJson(json.decode(str));

String addCreditModelToJson(AddCreditModel data) => json.encode(data.toJson());

class AddCreditModel {
  AddCreditModel({
    this.data,
  });

  List<Datum> data;

  factory AddCreditModel.fromJson(Map<String, dynamic> json) => AddCreditModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.creditDate,
    this.creditAmount,
    this.creditDescription,
    this.notes,
    this.creditMonth,
    this.creditYear,
    this.creditedBy,
    this.creditImage,
    this.creditHostelId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String creditDate;
  String creditAmount;
  String creditDescription;
  String notes;
  String creditMonth;
  String creditYear;
  String creditedBy;
  String creditImage;
  String creditHostelId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    creditDate: json["credit_date"],
    creditAmount: json["credit_amount"],
    creditDescription: json["credit_description"],
    notes: json["notes"],
    creditMonth: json["credit_month"],
    creditYear: json["credit_year"],
    creditedBy: json["creditedBy"],
    creditImage: json["credit_image"],
    creditHostelId: json["credit_hostel_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "credit_date": creditDate,
    "credit_amount": creditAmount,
    "credit_description": creditDescription,
    "notes": notes,
    "credit_month": creditMonth,
    "credit_year": creditYear,
    "creditedBy": creditedBy,
    "credit_image": creditImage,
    "credit_hostel_id": creditHostelId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
