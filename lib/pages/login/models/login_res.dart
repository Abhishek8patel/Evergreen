// // To parse this JSON data, do
// //
// //     final loginRes = loginResFromJson(jsonString);
//
// import 'dart:convert';
//
// LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));
//
// String loginResToJson(LoginRes data) => json.encode(data.toJson());
//
// class LoginRes {
//   Userdata userdata;
//   String token;
//   bool status;
//
//   LoginRes({
//     required this.userdata,
//     required this.token,
//     required this.status,
//   });
//
//   factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
//     userdata: Userdata.fromJson(json["userdata"]),
//     token: json["token"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userdata": userdata.toJson(),
//     "token": token,
//     "status": status,
//   };
// }
//
// class Userdata {
//   String id;
//   String fullName;
//   String deviceId;
//   int mobile;
//   String otp;
//   int otpVerified;
//   String pic;
//   dynamic deletedAt;
//   String role;
//   List<dynamic> siteId;
//   String datetime;
//   int v;
//
//   Userdata({
//     required this.id,
//     required this.fullName,
//     required this.deviceId,
//     required this.mobile,
//     required this.otp,
//     required this.otpVerified,
//     required this.pic,
//     required this.deletedAt,
//     required this.role,
//     required this.siteId,
//     required this.datetime,
//     required this.v,
//   });
//
//   factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
//     id: json["_id"],
//     fullName: json["full_name"],
//     deviceId: json["deviceId"],
//     mobile: json["mobile"],
//     otp: json["otp"],
//     otpVerified: json["otp_verified"],
//     pic: json["pic"],
//     deletedAt: json["deleted_at"],
//     role: json["role"],
//     siteId: List<dynamic>.from(json["site_id"].map((x) => x)),
//     datetime: json["datetime"],
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "full_name": fullName,
//     "deviceId": deviceId,
//     "mobile": mobile,
//     "otp": otp,
//     "otp_verified": otpVerified,
//     "pic": pic,
//     "deleted_at": deletedAt,
//     "role": role,
//     "site_id": List<dynamic>.from(siteId.map((x) => x)),
//     "datetime": datetime,
//     "__v": v,
//   };
// }
// To parse this JSON data, do
//
//     final loginRes = loginResFromJson(jsonString);

import 'dart:convert';

LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
  Userdata userdata;
  String token;
  bool status;

  LoginRes({
    required this.userdata,
    required this.token,
    required this.status,
  });

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
    userdata: Userdata.fromJson(json["userdata"]),
    token: json["token"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "userdata": userdata.toJson(),
    "token": token,
    "status": status,
  };
}

class Userdata {
  String id;
  String fullName;
  String deviceId;
  int mobile;
  String otp;
  int otpVerified;
  String pic;
  dynamic deletedAt;
  String role;
  List<dynamic> siteId;
  String datetime;
  int v;

  Userdata({
    required this.id,
    required this.fullName,
    required this.deviceId,
    required this.mobile,
    required this.otp,
    required this.otpVerified,
    required this.pic,
    required this.deletedAt,
    required this.role,
    required this.siteId,
    required this.datetime,
    required this.v,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
    id: json["_id"],
    fullName: json["full_name"],
    deviceId: json["deviceId"],
    mobile: json["mobile"],
    otp: json["otp"],
    otpVerified: json["otp_verified"],
    pic: json["pic"],
    deletedAt: json["deleted_at"],
    role: json["role"],
    siteId: List<dynamic>.from(json["site_id"].map((x) => x)),
    datetime: json["datetime"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "full_name": fullName,
    "deviceId": deviceId,
    "mobile": mobile,
    "otp": otp,
    "otp_verified": otpVerified,
    "pic": pic,
    "deleted_at": deletedAt,
    "role": role,
    "site_id": List<dynamic>.from(siteId.map((x) => x)),
    "datetime": datetime,
    "__v": v,
  };
}
