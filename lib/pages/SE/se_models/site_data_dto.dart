// To parse this JSON data, do
//
//     final siteDataDto = siteDataDtoFromJson(jsonString);

import 'dart:convert';

SiteDataDto siteDataDtoFromJson(String str) => SiteDataDto.fromJson(json.decode(str));

String siteDataDtoToJson(SiteDataDto data) => json.encode(data.toJson());

class SiteDataDto {
  UserData userData;
  String message;

  SiteDataDto({
    required this.userData,
    required this.message,
  });

  factory SiteDataDto.fromJson(Map<String, dynamic> json) => SiteDataDto(
    userData: UserData.fromJson(json["userData"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "userData": userData.toJson(),
    "message": message,
  };
}

class UserData {
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
  List<SiteId> siteId;
  String datetime;
  int v;

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
    siteId: List<SiteId>.from(json["site_id"].map((x) => SiteId.fromJson(x))),
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
    "site_id": List<dynamic>.from(siteId.map((x) => x.toJson())),
    "datetime": datetime,
    "__v": v,
  };
}

class SiteId {
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
  ReportSubmit reportSubmit;
  List<Product> product;
  String datetime;
  int v;

  SiteId({
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

  factory SiteId.fromJson(Map<String, dynamic> json) => SiteId(
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
    reportSubmit: ReportSubmit.fromJson(json["report_submit"]),
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
    "report_submit": reportSubmit.toJson(),
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
  List<dynamic> maintenanceDate;
  String maintenanceAlert;
  List<dynamic> alreadyMaintenance;

  Product({
    required this.id,
    required this.productQuantity,
    required this.usedQuantity,
    required this.remainingQuantity,
    required this.productMinQuantity,
    required this.workingStatus,
    required this.maintenanceDate,
    required this.maintenanceAlert,
    required this.alreadyMaintenance,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    productQuantity: json["product_quantity"],
    usedQuantity: json["used_quantity"],
    remainingQuantity: json["remaining_quantity"],
    productMinQuantity: json["product_min_quantity"],
    workingStatus: json["working_status"],
    maintenanceDate: List<dynamic>.from(json["maintenance_date"].map((x) => x)),
    maintenanceAlert: json["maintenance_alert"],
    alreadyMaintenance: List<dynamic>.from(json["already_maintenance"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_quantity": productQuantity,
    "used_quantity": usedQuantity,
    "remaining_quantity": remainingQuantity,
    "product_min_quantity": productMinQuantity,
    "working_status": workingStatus,
    "maintenance_date": List<dynamic>.from(maintenanceDate.map((x) => x)),
    "maintenance_alert": maintenanceAlert,
    "already_maintenance": List<dynamic>.from(alreadyMaintenance.map((x) => x)),
  };
}

class ReportSubmit {
  String id;
  String fullName;
  String pic;

  ReportSubmit({
    required this.id,
    required this.fullName,
    required this.pic,
  });

  factory ReportSubmit.fromJson(Map<String, dynamic> json) => ReportSubmit(
    id: json["_id"],
    fullName: json["full_name"],
    pic: json["pic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "full_name": fullName,
    "pic": pic,
  };
}
