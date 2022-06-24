// To parse this JSON data, do
//
//     final singleCreditModel = singleCreditModelFromJson(jsonString);

import 'dart:convert';

SingleCreditModel singleCreditModelFromJson(String str) => SingleCreditModel.fromJson(json.decode(str));

String singleCreditModelToJson(SingleCreditModel data) => json.encode(data.toJson());

class SingleCreditModel {
  SingleCreditModel({
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

  String id;
  String creditDate;
  String creditAmount;
  String creditDescription;
  String notes;
  String creditMonth;
  String creditYear;
  dynamic creditedBy;
  String creditImage;
  dynamic creditHostelId;
  dynamic createdAt;
  dynamic updatedAt;

  factory SingleCreditModel.fromJson(Map<String, dynamic> json) => SingleCreditModel(
    id: json["id"],
    creditDate: json["creditDate"],
    creditAmount: json["creditAmount"],
    creditDescription: json["creditDescription"],
    notes: json["notes"],
    creditMonth: json["creditMonth"],
    creditYear: json["creditYear"],
    creditedBy: json["creditedBy"],
    creditImage: json["creditImage"],
    creditHostelId: json["creditHostel_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "creditDate": creditDate,
    "creditAmount": creditAmount,
    "creditDescription": creditDescription,
    "notes": notes,
    "creditMonth": creditMonth,
    "creditYear": creditYear,
    "creditedBy": creditedBy,
    "creditImage": creditImage,
    "creditHostel_id": creditHostelId,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
