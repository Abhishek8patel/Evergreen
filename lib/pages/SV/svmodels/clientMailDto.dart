// To parse this JSON data, do
//
//     final svClientMailDto = svClientMailDtoFromJson(jsonString);

import 'dart:convert';

SvClientMailDto svClientMailDtoFromJson(String str) => SvClientMailDto.fromJson(json.decode(str));

String svClientMailDtoToJson(SvClientMailDto data) => json.encode(data.toJson());

class SvClientMailDto {
  Emails emails;

  SvClientMailDto({
    required this.emails,
  });

  factory SvClientMailDto.fromJson(Map<String, dynamic> json) => SvClientMailDto(
    emails: Emails.fromJson(json["emails"]),
  );

  Map<String, dynamic> toJson() => {
    "emails": emails.toJson(),
  };
}

class Emails {
  String id;
  List<EmailDatum> emailData;

  Emails({
    required this.id,
    required this.emailData,
  });

  factory Emails.fromJson(Map<String, dynamic> json) => Emails(
    id: json["_id"],
    emailData: List<EmailDatum>.from(json["emailData"].map((x) => EmailDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "emailData": List<dynamic>.from(emailData.map((x) => x.toJson())),
  };
}

class EmailDatum {
  String email;
  String id;
  String? name;
  String? designation;
  String? mobile;

  EmailDatum({
    required this.email,
    required this.id,
    this.name,
    this.designation,
    this.mobile,
  });

  factory EmailDatum.fromJson(Map<String, dynamic> json) => EmailDatum(
    email: json["email"],
    id: json["_id"],
    name: json["name"],
    designation: json["designation"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "_id": id,
    "name": name,
    "designation": designation,
    "mobile": mobile,
  };
}
