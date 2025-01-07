// To parse this JSON data, do
//
//     final selfiResponse = selfiResponseFromJson(jsonString);

import 'dart:convert';

SelfiResponse selfiResponseFromJson(String str) => SelfiResponse.fromJson(json.decode(str));

String selfiResponseToJson(SelfiResponse data) => json.encode(data.toJson());

class SelfiResponse {
  String message;
  SelfieData selfieData;
  bool status;

  SelfiResponse({
    required this.message,
    required this.selfieData,
    required this.status,
  });

  factory SelfiResponse.fromJson(Map<String, dynamic> json) => SelfiResponse(
    message: json["message"],
    selfieData: SelfieData.fromJson(json["Selfie_data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Selfie_data": selfieData.toJson(),
    "status": status,
  };
}

class SelfieData {
  String userId;
  String siteId;
  String pic;
  String datetime;
  String id;
  int v;

  SelfieData({
    required this.userId,
    required this.siteId,
    required this.pic,
    required this.datetime,
    required this.id,
    required this.v,
  });

  factory SelfieData.fromJson(Map<String, dynamic> json) => SelfieData(
    userId: json["userId"],
    siteId: json["site_id"],
    pic: json["pic"],
    datetime: json["datetime"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "site_id": siteId,
    "pic": pic,
    "datetime": datetime,
    "_id": id,
    "__v": v,
  };
}
