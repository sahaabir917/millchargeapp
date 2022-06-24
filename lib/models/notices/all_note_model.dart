// To parse this JSON data, do
//
//     final allNotesModel = allNotesModelFromJson(jsonString);

import 'dart:convert';

AllNotesModel allNotesModelFromJson(String str) => AllNotesModel.fromJson(json.decode(str));

String allNotesModelToJson(AllNotesModel data) => json.encode(data.toJson());

class AllNotesModel {
  AllNotesModel({
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

  factory AllNotesModel.fromJson(Map<String, dynamic> json) => AllNotesModel(
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
    this.name,
    this.hostelName,
  });

  String id;
  String noticeDescription;
  String noticeDate;
  String noticeMonth;
  String noticeYear;
  String noticeStatus;
  String notedBy;
  String noteHostelId;
  dynamic createdAt;
  dynamic updatedAt;
  String name;
  String hostelName;

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
    name: json["name"],
    hostelName: json["hostel_name"],
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
    "name": name,
    "hostel_name": hostelName,
  };
}
