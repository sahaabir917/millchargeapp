// To parse this JSON data, do
//
//     final noticeModel = noticeModelFromJson(jsonString);

import 'dart:convert';

NoticeModel noticeModelFromJson(String str) => NoticeModel.fromJson(json.decode(str));

String noticeModelToJson(NoticeModel data) => json.encode(data.toJson());

class NoticeModel {
  NoticeModel({
    this.data,
  });

  List<Datum> data;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.noticeDescription,
    this.noticeDate,
    this.noticeMonth,
    this.noticeYear,
    this.noticeStatus,
    this.notedBy,
    this.noteHostelId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String noticeDescription;
  String noticeDate;
  String noticeMonth;
  String noticeYear;
  String noticeStatus;
  String notedBy;
  String noteHostelId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    noticeDescription: json["notice_description"],
    noticeDate: json["notice_date"],
    noticeMonth: json["notice_month"],
    noticeYear: json["notice_year"],
    noticeStatus: json["notice_status"],
    notedBy: json["notedBy"],
    noteHostelId: json["note_hostel_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notice_description": noticeDescription,
    "notice_date": noticeDate,
    "notice_month": noticeMonth,
    "notice_year": noticeYear,
    "notice_status": noticeStatus,
    "notedBy": notedBy,
    "note_hostel_id": noteHostelId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
