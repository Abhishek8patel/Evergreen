// To parse this JSON data, do
//
//     final updateChemicalResponse = updateChemicalResponseFromJson(jsonString);

import 'dart:convert';

UpdateChemicalResponse updateChemicalResponseFromJson(String str) => UpdateChemicalResponse.fromJson(json.decode(str));

String updateChemicalResponseToJson(UpdateChemicalResponse data) => json.encode(data.toJson());

class UpdateChemicalResponse {
  String message;
  Site site;

  UpdateChemicalResponse({
    required this.message,
    required this.site,
  });

  factory UpdateChemicalResponse.fromJson(Map<String, dynamic> json) => UpdateChemicalResponse(
    message: json["message"],
    site: Site.fromJson(json["site"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "site": site.toJson(),
  };
}

class Site {
  String id;
  String clientId;
  String locationName;
  String siteName;
  int svVisit;
  String amc;
  String amcDescription;
  String workingHrs;
  String manPower;
  List<String> contractfile;
  String locationLat;
  String locationLong;
  String startDate;
  String endDate;
  int discount;
  String reportSubmit;
  List<Product> product;
  String datetime;
  int v;

  Site({
    required this.id,
    required this.clientId,
    required this.locationName,
    required this.siteName,
    required this.svVisit,
    required this.amc,
    required this.amcDescription,
    required this.workingHrs,
    required this.manPower,
    required this.contractfile,
    required this.locationLat,
    required this.locationLong,
    required this.startDate,
    required this.endDate,
    required this.discount,
    required this.reportSubmit,
    required this.product,
    required this.datetime,
    required this.v,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
    id: json["_id"],
    clientId: json["client_id"],
    locationName: json["location_name"],
    siteName: json["site_name"],
    svVisit: json["sv_visit"],
    amc: json["amc"],
    amcDescription: json["amc_description"],
    workingHrs: json["working_hrs"],
    manPower: json["man_power"],
    contractfile: List<String>.from(json["contractfile"].map((x) => x)),
    locationLat: json["location_lat"],
    locationLong: json["location_long"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    discount: json["discount"],
    reportSubmit: json["report_submit"],
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    datetime: json["datetime"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "client_id": clientId,
    "location_name": locationName,
    "site_name": siteName,
    "sv_visit": svVisit,
    "amc": amc,
    "amc_description": amcDescription,
    "working_hrs": workingHrs,
    "man_power": manPower,
    "contractfile": List<dynamic>.from(contractfile.map((x) => x)),
    "location_lat": locationLat,
    "location_long": locationLong,
    "start_date": startDate,
    "end_date": endDate,
    "discount": discount,
    "report_submit": reportSubmit,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
    "datetime": datetime,
    "__v": v,
  };
}

class Product {
  String id;
  int productQuantity;
  int usedQuantity;
  int remainingQuantity;
  int productMinQuantity;
  String workingStatus;
  List<String> maintenanceDate;
  List<dynamic> alreadyMaintenance;
  String maintenanceAlert;

  Product({
    required this.id,
    required this.productQuantity,
    required this.usedQuantity,
    required this.remainingQuantity,
    required this.productMinQuantity,
    required this.workingStatus,
    required this.maintenanceDate,
    required this.alreadyMaintenance,
    required this.maintenanceAlert,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    productQuantity: json["product_quantity"],
    usedQuantity:(json['used_quantity'] as num?)?.toInt()??0,
    remainingQuantity: (json['remaining_quantity'] as num?)?.toInt()??0,
    productMinQuantity: json["product_min_quantity"],
    workingStatus: json["working_status"],
    maintenanceDate: List<String>.from(json["maintenance_date"]?.map((x) => x)??{}),
    alreadyMaintenance: List<dynamic>.from(json["already_maintenance"].map((x) => x)),
    maintenanceAlert: json["maintenance_alert"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_quantity": productQuantity,
    "used_quantity": usedQuantity,
    "remaining_quantity": remainingQuantity,
    "product_min_quantity": productMinQuantity,
    "working_status": workingStatus,
    "maintenance_date": List<dynamic>.from(maintenanceDate.map((x) => x)),
    "already_maintenance": List<dynamic>.from(alreadyMaintenance.map((x) => x)),
    "maintenance_alert": maintenanceAlert,
  };
}
