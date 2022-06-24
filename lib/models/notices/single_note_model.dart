// To parse this JSON data, do
//
//     final singleNoteModel = singleNoteModelFromJson(jsonString);

import 'dart:convert';

SingleNoteModel singleNoteModelFromJson(String str) => SingleNoteModel.fromJson(json.decode(str));

String singleNoteModelToJson(SingleNoteModel data) => json.encode(data.toJson());

class SingleNoteModel {
  SingleNoteModel({
    this.id,
    this.noticeDescription,
    this.noticeDate,
    this.noticeMonth,
    this.noticeYear,
    this.noticeStatus,
    this.notedBy,
    this.noteHostelId,
    this.name,
  });

  String id;
  String noticeDescription;
  String noticeDate;
  String noticeMonth;
  String noticeYear;
  String noticeStatus;
  String notedBy;
  String noteHostelId;
  String name;

  factory SingleNoteModel.fromJson(Map<String, dynamic> json) => SingleNoteModel(
    id: json["id"],
    noticeDescription: json["notice_description"],
    noticeDate: json["notice_date"],
    noticeMonth: json["notice_month"],
    noticeYear: json["notice_year"],
    noticeStatus: json["notice_status"],
    notedBy: json["notedBy"],
    noteHostelId: json["note_hostel_id"],
    name: json["name"],
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
    "name": name,
  };
}
