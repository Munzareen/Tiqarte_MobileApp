// To parse this JSON data, do
//
//     final seeAllProductModel = seeAllProductModelFromJson(jsonString);

import 'dart:convert';

List<SeeAllProductModel> seeAllProductModelFromJson(List data) =>
    List<SeeAllProductModel>.from(
        data.map((x) => SeeAllProductModel.fromJson(x)));

String seeAllProductModelToJson(List<SeeAllProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeeAllProductModel {
  num? id;
  String? sku;
  String? productName;
  String? description;
  String? deliveryDetails;
  num? price;
  num? catagoryId;
  String? productFor;
  bool? isActive;
  num? promotorId;
  String? imageUrl;
  String? createdDate;

  SeeAllProductModel({
    this.id,
    this.sku,
    this.productName,
    this.description,
    this.deliveryDetails,
    this.price,
    this.catagoryId,
    this.productFor,
    this.isActive,
    this.promotorId,
    this.imageUrl,
    this.createdDate,
  });

  factory SeeAllProductModel.fromJson(Map<String, dynamic> json) =>
      SeeAllProductModel(
        id: json["Id"],
        sku: json["Sku"],
        productName: json["ProductName"],
        description: json["Description"],
        deliveryDetails: json["DeliveryDetails"],
        price: json["Price"],
        catagoryId: json["CatagoryId"],
        productFor: json["ProductFor"],
        isActive: json["isActive"],
        promotorId: json["PromotorId"],
        imageUrl: json["ImageURL"],
        createdDate: json["CreatedDate"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Sku": sku,
        "ProductName": productName,
        "Description": description,
        "DeliveryDetails": deliveryDetails,
        "Price": price,
        "CatagoryId": catagoryId,
        "ProductFor": productFor,
        "isActive": isActive,
        "PromotorId": promotorId,
        "ImageURL": imageUrl,
        "CreatedDate": createdDate,
      };
}
