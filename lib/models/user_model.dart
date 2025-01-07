// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  User user;
  bool status;

  Usermodel({
    required this.user,
    required this.status,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    user: User.fromJson(json["user"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "status": status,
  };
}

class User {
  String id;
  String fullName;
  String deviceId;
  String? email;
  int? mobile;
  String? address;
  String otp;
  int otpVerified;
  String pic;
  dynamic deletedAt;
  String role;
  dynamic firebaseToken;
  List<dynamic> siteId;
  String datetime;
  int v;

  User({
    required this.id,
    required this.fullName,
    required this.deviceId,
     this.email,
     this.mobile,
     this.address,
    required this.otp,
    required this.otpVerified,
    required this.pic,
    required this.deletedAt,
    required this.role,
    required this.firebaseToken,
    required this.siteId,
    required this.datetime,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    fullName: json["full_name"],
    deviceId: json["deviceId"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
    otp: json["otp"],
    otpVerified: json["otp_verified"],
    pic: json["pic"],
    deletedAt: json["deleted_at"],
    role: json["role"],
    firebaseToken: json["firebase_token"],
    siteId: List<dynamic>.from(json["site_id"].map((x) => x)),
    datetime: json["datetime"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "full_name": fullName,
    "deviceId": deviceId,
    "email": email,
    "mobile": mobile,
    "address": address,
    "otp": otp,
    "otp_verified": otpVerified,
    "pic": pic,
    "deleted_at": deletedAt,
    "role": role,
    "firebase_token": firebaseToken,
    "site_id": List<dynamic>.from(siteId.map((x) => x)),
    "datetime": datetime,
    "__v": v,
  };
}
