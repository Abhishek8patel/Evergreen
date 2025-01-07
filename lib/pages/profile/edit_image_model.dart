// To parse this JSON data, do
//
//     final editImgDto = editImgDtoFromJson(jsonString);

import 'dart:convert';

EditImgDto editImgDtoFromJson(String str) => EditImgDto.fromJson(json.decode(str));

String editImgDtoToJson(EditImgDto data) => json.encode(data.toJson());

class EditImgDto {
  String message;
  String profilePic;
  User user;

  EditImgDto({
    required this.message,
    required this.profilePic,
    required this.user,
  });

  factory EditImgDto.fromJson(Map<String, dynamic> json) => EditImgDto(
    message: json["message"],
    profilePic: json["profile_pic"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "profile_pic": profilePic,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String fullName;
  String deviceId;
  String email;
  int mobile;
  String address;
  String otp;
  int otpVerified;
  String pic;
  dynamic deletedAt;
  String role;
  dynamic firebaseToken;
  String pfNumber;
  String esic;
  String medicalCard;
  String identityCard;
  List<String> siteId;
  String datetime;
  int v;

  User({
    required this.id,
    required this.fullName,
    required this.deviceId,
    required this.email,
    required this.mobile,
    required this.address,
    required this.otp,
    required this.otpVerified,
    required this.pic,
    required this.deletedAt,
    required this.role,
    required this.firebaseToken,
    required this.pfNumber,
    required this.esic,
    required this.medicalCard,
    required this.identityCard,
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
    pfNumber: json["PF_number"],
    esic: json["ESIC"],
    medicalCard: json["medical_card"],
    identityCard: json["identity_card"],
    siteId: List<String>.from(json["site_id"].map((x) => x)),
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
    "PF_number": pfNumber,
    "ESIC": esic,
    "medical_card": medicalCard,
    "identity_card": identityCard,
    "site_id": List<dynamic>.from(siteId.map((x) => x)),
    "datetime": datetime,
    "__v": v,
  };
}
