// To parse this JSON data, do
//
//     final forgetPwRes = forgetPwResFromJson(jsonString);

import 'dart:convert';

ForgetPwRes forgetPwResFromJson(String str) => ForgetPwRes.fromJson(json.decode(str));

String forgetPwResToJson(ForgetPwRes data) => json.encode(data.toJson());

class ForgetPwRes {
  String newPassword;
  String mobile;
  String otp;

  ForgetPwRes({
    required this.newPassword,
    required this.mobile,
    required this.otp,
  });

  factory ForgetPwRes.fromJson(Map<String, dynamic> json) => ForgetPwRes(
    newPassword: json["newPassword"],
    mobile: json["mobile"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "newPassword": newPassword,
    "mobile": mobile,
    "otp": otp,
  };
}
