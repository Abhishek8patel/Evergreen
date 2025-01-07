// To parse this JSON data, do
//
//     final settingResponse = settingResponseFromJson(jsonString);

import 'dart:convert';

SettingResponse settingResponseFromJson(String str) => SettingResponse.fromJson(json.decode(str));

String settingResponseToJson(SettingResponse data) => json.encode(data.toJson());

class SettingResponse {
  String content;
  bool status;

  SettingResponse({
    required this.content,
    required this.status,
  });

  factory SettingResponse.fromJson(Map<String, dynamic> json) => SettingResponse(
    content: json["content"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "status": status,
  };
}
