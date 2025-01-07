// To parse this JSON data, do
//
//     final attendanceRes = attendanceResFromJson(jsonString);

import 'dart:convert';

AttendanceRes attendanceResFromJson(String str) => AttendanceRes.fromJson(json.decode(str));

String attendanceResToJson(AttendanceRes data) => json.encode(data.toJson());

class AttendanceRes {
  String id;
  String date;
  String userId;
  String? timeIn;
  dynamic? timeOut;
  String siteId;
  String? picIn;
  dynamic? picOut;
  String entry;
  bool status;

  AttendanceRes({
    required this.id,
    required this.date,
    required this.userId,
     this.timeIn,
     this.timeOut,
    required this.siteId,
     this.picIn,
     this.picOut,
    required this.entry,
    required this.status,
  });

  factory AttendanceRes.fromJson(Map<String, dynamic> json) => AttendanceRes(
    id: json["_id"],
    date: json["date"],
    userId: json["userId"],
    timeIn: json["timeIn"],
    timeOut: json["timeOut"],
    siteId: json["site_id"],
    picIn: json["picIn"],
    picOut: json["picOut"],
    entry: json["entry"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date,
    "userId": userId,
    "timeIn": timeIn,
    "timeOut": timeOut,
    "site_id": siteId,
    "picIn": picIn,
    "picOut": picOut,
    "entry": entry,
    "status": status,
  };
}
