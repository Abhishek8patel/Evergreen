// To parse this JSON data, do
//
//     final siteProductDto = siteProductDtoFromJson(jsonString);

import 'dart:convert';

SiteProductDto siteProductDtoFromJson(String str) => SiteProductDto.fromJson(json.decode(str));

String siteProductDtoToJson(SiteProductDto data) => json.encode(data.toJson());

class SiteProductDto {
  Product product;
  String message;

  SiteProductDto({
    required this.product,
    required this.message,
  });

  factory SiteProductDto.fromJson(Map<String, dynamic> json) => SiteProductDto(
    product: Product.fromJson(json["Product"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "Product": product.toJson(),
    "message": message,
  };
}

class Product {
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
  dynamic reportSubmit;
  List<ProductElement> product;
  String datetime;
  int v;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    product: List<ProductElement>.from(json["product"].map((x) => ProductElement.fromJson(x))),
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

class ProductElement {
  Id? id;
  int productQuantity;

  ProductElement({
    required this.id,
    required this.productQuantity,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
    productQuantity: json["product_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id?.toJson(),
    "product_quantity": productQuantity,
  };
}

class Id {
  String id;
  String productId;
  String productName;
  String parameterMin;
  String parameterMax;
  String unite;
  String productQuantity;
  String minProductQuantity;
  String showSe;
  String preventiveMaintenance;
  int price;
  String descriptions;
  String categoryId;
  String hsnCode;
  String image;
  int tax;
  String warrenty;
  String workingStatus;
  String datetime;
  int v;

  Id({
    required this.id,
    required this.productId,
    required this.productName,
    required this.parameterMin,
    required this.parameterMax,
    required this.unite,
    required this.productQuantity,
    required this.minProductQuantity,
    required this.showSe,
    required this.preventiveMaintenance,
    required this.price,
    required this.descriptions,
    required this.categoryId,
    required this.hsnCode,
    required this.image,
    required this.tax,
    required this.warrenty,
    required this.workingStatus,
    required this.datetime,
    required this.v,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"],
    productId: json["productId"],
    productName: json["product_name"],
    parameterMin: json["parameter_min"],
    parameterMax: json["parameter_max"],
    unite: json["unite"],
    productQuantity: json["product_quantity"],
    minProductQuantity: json["min_product_quantity"],
    showSe: json["show_SE"],
    preventiveMaintenance: json["preventive_maintenance"],
    price: json["price"],
    descriptions: json["descriptions"],
    categoryId: json["category_id"],
    hsnCode: json["HSN_code"],
    image: json["image"],
    tax: json["tax"],
    warrenty: json["warrenty"],
    workingStatus: json["working_status"],
    datetime: json["datetime"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productId": productId,
    "product_name": productName,
    "parameter_min": parameterMin,
    "parameter_max": parameterMax,
    "unite": unite,
    "product_quantity": productQuantity,
    "min_product_quantity": minProductQuantity,
    "show_SE": showSe,
    "preventive_maintenance": preventiveMaintenance,
    "price": price,
    "descriptions": descriptions,
    "category_id": categoryId,
    "HSN_code": hsnCode,
    "image": image,
    "tax": tax,
    "warrenty": warrenty,
    "working_status": workingStatus,
    "datetime": datetime,
    "__v": v,
  };
}
