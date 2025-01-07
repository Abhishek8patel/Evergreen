// To parse this JSON data, do
//
//     final notiResponse = notiResponseFromJson(jsonString);

import 'dart:convert';

NotiResponse notiResponseFromJson(String str) => NotiResponse.fromJson(json.decode(str));

String notiResponseToJson(NotiResponse data) => json.encode(data.toJson());

class NotiResponse {
  bool status;
  List<Notification> notifications;

  NotiResponse({
    required this.status,
    required this.notifications,
  });

  factory NotiResponse.fromJson(Map<String, dynamic> json) => NotiResponse(
    status: json["status"],
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
  };
}

class Notification {
  String id;
  Sender sender;
  String message;
  dynamic metadata;
  String type;
  String time;
  String date;

  Notification({
    required this.id,
    required this.sender,
    required this.message,
    required this.metadata,
    required this.type,
    required this.time,
    required this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["_id"],
    sender: Sender.fromJson(json["sender"]),
    message: json["message"],
    metadata: json["metadata"],
    type: json["type"],
    time: json["time"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender.toJson(),
    "message": message,
    "metadata": metadata,
    "type": type,
    "time": time,
    "date": date,
  };
}

class Sender {
  String id;
  String pic;

  Sender({
    required this.id,
    required this.pic,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    pic: json["pic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "pic": pic,
  };
}
