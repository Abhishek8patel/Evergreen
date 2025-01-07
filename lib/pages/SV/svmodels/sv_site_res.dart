// To parse this JSON data, do
//
//     final svSiteResponse = svSiteResponseFromJson(jsonString);

import 'dart:convert';

SvSiteResponse svSiteResponseFromJson(String str) => SvSiteResponse.fromJson(json.decode(str));

String svSiteResponseToJson(SvSiteResponse data) => json.encode(data.toJson());

class SvSiteResponse {
  List<UserDatum> userData;
  String message;

  SvSiteResponse({
    required this.userData,
    required this.message,
  });

  factory SvSiteResponse.fromJson(Map<String, dynamic> json) => SvSiteResponse(
    userData: List<UserDatum>.from(json["userData"].map((x) => UserDatum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "userData": List<dynamic>.from(userData.map((x) => x.toJson())),
    "message": message,
  };
}

class UserDatum {
  String date;
  List<Site> sites;

  UserDatum({
    required this.date,
    required this.sites,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    date: json["date"],
    sites: List<Site>.from(json["sites"].map((x) => Site.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "sites": List<dynamic>.from(sites.map((x) => x.toJson())),
  };
}

class Site {
  String id;
  String siteName;
  String amc;
  String workingHrs;
  String manPower;
  String locationLat;
  String locationLong;
  String startDate;
  String endDate;
  int discount;
  ReportSubmit? reportSubmit;

  Site({
    required this.id,
    required this.siteName,
    required this.amc,
    required this.workingHrs,
    required this.manPower,
    required this.locationLat,
    required this.locationLong,
    required this.startDate,
    required this.endDate,
    required this.discount,
    required this.reportSubmit,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
    id: json["_id"],
    siteName: json["site_name"],
    amc: json["amc"],
    workingHrs: json["working_hrs"],
    manPower: json["man_power"],
    locationLat: json["location_lat"],
    locationLong: json["location_long"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    discount: json["discount"],
    reportSubmit: json["report_submit"]  == null ? null : ReportSubmit.fromJson(json["report_submit"] ??""),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "site_name": siteName,
    "amc": amc,
    "working_hrs": workingHrs,
    "man_power": manPower,
    "location_lat": locationLat,
    "location_long": locationLong,
    "start_date": startDate,
    "end_date": endDate,
    "discount": discount,
    "report_submit": reportSubmit?.toJson(),
  };
}

class ReportSubmit {
  String id;
  String fullName;

  ReportSubmit({
    required this.id,
    required this.fullName,
  });

  factory ReportSubmit.fromJson(Map<String, dynamic> json) => ReportSubmit(
    id: json["_id"],
    fullName: json["full_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "full_name": fullName,
  };
}
