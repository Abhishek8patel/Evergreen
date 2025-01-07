// To parse this JSON data, do
//
//     final signupRes = signupResFromJson(jsonString);

import 'dart:convert';

SignupRes signupResFromJson(String str) => SignupRes.fromJson(json.decode(str));

String signupResToJson(SignupRes data) => json.encode(data.toJson());

class SignupRes {
  String id;
  String fullName;
  int mobile;
  String profilePic;
  String email;
  String address;
  int otpVerified;
  String? otp;
  bool status;

  SignupRes({
    required this.id,
    required this.fullName,
    required this.mobile,
    required this.profilePic,
    required this.email,
    required this.address,
    required this.otpVerified,
    this.otp,

    required this.status,
  });

  factory SignupRes.fromJson(Map<String, dynamic> json) => SignupRes(
    id: json["_id"],
    fullName: json["full_name"],
    mobile: json["mobile"],
    profilePic: json["profile_pic"],
    email: json["email"],
    address: json["address"],
    otpVerified: json["otp_verified"],
    otp: json["otp"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "full_name": fullName,
    "mobile": mobile,
    "profile_pic": profilePic,
    "email": email,
    "address": address,
    "otp_verified": otpVerified,
    "otp":otp,
    "status": status,
  };
}
