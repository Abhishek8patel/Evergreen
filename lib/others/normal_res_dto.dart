// To parse this JSON data, do
//
//     final normalResponse = normalResponseFromJson(jsonString);

import 'dart:convert';

NormalResponse normalResponseFromJson(String str) => NormalResponse.fromJson(json.decode(str));

String normalResponseToJson(NormalResponse data) => json.encode(data.toJson());

class NormalResponse {
  String message;
  bool status;

  NormalResponse({
    required this.message,
    required this.status,
  });

  factory NormalResponse.fromJson(Map<String, dynamic> json) => NormalResponse(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
