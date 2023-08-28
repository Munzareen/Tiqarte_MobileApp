// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

List<FavoriteModel> favoriteModelFromJson(List data) =>
    List<FavoriteModel>.from(data.map((x) => FavoriteModel.fromJson(x)));

String favoriteModelToJson(List<FavoriteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavoriteModel {
  num? eventId;
  String? name;
  String? compnayName;
  String? discription;
  String? location;
  String? city;
  String? eventDate;
  num? creationUserId;
  num? eventStatusId;
  num? eventTypeId;
  List<String>? postEventImages;
  List<String>? preEventImages;
  dynamic catagoryId;
  num? price;
  num? organizerId;

  FavoriteModel({
    this.eventId,
    this.name,
    this.compnayName,
    this.discription,
    this.location,
    this.city,
    this.eventDate,
    this.creationUserId,
    this.eventStatusId,
    this.eventTypeId,
    this.postEventImages,
    this.preEventImages,
    this.catagoryId,
    this.price,
    this.organizerId,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        eventId: json["EventId"],
        name: json["Name"],
        compnayName: json["CompnayName"],
        discription: json["Discription"],
        location: json["Location"],
        city: json["City"],
        eventDate: json["EventDate"],
        creationUserId: json["CreationUserId"],
        eventStatusId: json["EventStatusId"],
        eventTypeId: json["EventTypeId"],
        postEventImages:
            List<String>.from(json["PostEventImages"].where((x) => x != null)),
        preEventImages:
            List<String>.from(json["PreEventImages"].where((x) => x != null)),
        catagoryId: json["CatagoryId"],
        price: json["Price"],
        organizerId: json["OrganizerID"],
      );

  Map<String, dynamic> toJson() => {
        "EventId": eventId,
        "Name": name,
        "CompnayName": compnayName,
        "Discription": discription,
        "Location": location,
        "City": city,
        "EventDate": eventDate,
        "CreationUserId": creationUserId,
        "EventStatusId": eventStatusId,
        "EventTypeId": eventTypeId,
        "PostEventImages": List<dynamic>.from(postEventImages!.map((x) => x)),
        "PreEventImages": List<dynamic>.from(preEventImages!.map((x) => x)),
        "CatagoryId": catagoryId,
        "Price": price,
        "OrganizerID": organizerId,
      };
}
