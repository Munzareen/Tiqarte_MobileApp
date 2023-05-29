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
  num? eventId;
  String? name;
  num? price;
  String? imageUrl;
  num? catagoryId;
  String? createdDate;
  String? updatedDate;

  SeeAllProductModel({
    this.id,
    this.eventId,
    this.name,
    this.price,
    this.imageUrl,
    this.catagoryId,
    this.createdDate,
    this.updatedDate,
  });

  factory SeeAllProductModel.fromJson(Map<String, dynamic> json) =>
      SeeAllProductModel(
        id: json["Id"],
        eventId: json["EventId"],
        name: json["Name"],
        price: json["Price"],
        imageUrl: json["ImageURL"],
        catagoryId: json["CatagoryId"],
        createdDate: json["CreatedDate"],
        updatedDate: json["UpdatedDate"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "EventId": eventId,
        "Name": name,
        "Price": price,
        "ImageURL": imageUrl,
        "CatagoryId": catagoryId,
        "CreatedDate": createdDate,
        "UpdatedDate": updatedDate,
      };
}
