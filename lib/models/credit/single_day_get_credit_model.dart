// To parse this JSON data, do
//
//     final singleDayGetCreditModel = singleDayGetCreditModelFromJson(jsonString);

import 'dart:convert';

SingleDayGetCreditModel singleDayGetCreditModelFromJson(String str) => SingleDayGetCreditModel.fromJson(json.decode(str));

String singleDayGetCreditModelToJson(SingleDayGetCreditModel data) => json.encode(data.toJson());

class SingleDayGetCreditModel {
  SingleDayGetCreditModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory SingleDayGetCreditModel.fromJson(Map<String, dynamic> json) => SingleDayGetCreditModel(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    this.creditDate,
    this.creditAmount,
    this.creditDescription,
    this.notes,
    this.creditMonth,
    this.creditYear,
    this.creditedBy,
    this.creditImage,
    this.creditHostelId,
    this.hostelName,
    this.name,
  });

  String creditDate;
  String creditAmount;
  String creditDescription;
  String notes;
  String creditMonth;
  String creditYear;
  String creditedBy;
  String creditImage;
  String creditHostelId;
  String hostelName;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    creditDate: json["credit_date"],
    creditAmount: json["credit_amount"],
    creditDescription: json["credit_description"],
    notes: json["notes"],
    creditMonth: json["credit_month"],
    creditYear: json["credit_year"],
    creditedBy: json["creditedBy"],
    creditImage: json["credit_image"],
    creditHostelId: json["credit_hostel_id"],
    hostelName: json["hostel_name"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "credit_date": creditDate,
    "credit_amount": creditAmount,
    "credit_description": creditDescription,
    "notes": notes,
    "credit_month": creditMonth,
    "credit_year": creditYear,
    "creditedBy": creditedBy,
    "credit_image": creditImage,
    "credit_hostel_id": creditHostelId,
    "hostel_name": hostelName,
    "name": name,
  };
}
