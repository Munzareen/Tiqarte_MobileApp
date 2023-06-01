// To parse this JSON data, do
//
//     final ExploreModel = ExploreModelFromJson(jsonString);

import 'dart:convert';

List<ExploreModel> exploreModelFromJson(List data) =>
    List<ExploreModel>.from(data.map((x) => ExploreModel.fromJson(x)));

String exploreModelToJson(List<ExploreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExploreModel {
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
  num? catagoryId;
  num? price;
  num? organizerId;
  bool? isPublished;
  String? lastUpdated;
  bool? isFav;
  String? standingTitle;
  String? seatingTitle;
  String? ticketSoldOutText;

  ExploreModel({
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
    this.isPublished,
    this.lastUpdated,
    this.isFav,
    this.standingTitle,
    this.seatingTitle,
    this.ticketSoldOutText,
  });

  factory ExploreModel.fromJson(Map<String, dynamic> json) => ExploreModel(
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
        postEventImages: json["PostEventImages"] != null
            ? json["PostEventImages"].cast<String>()
            : [],
        preEventImages: json["PreEventImages"] != null
            ? json["PreEventImages"].cast<String>()
            : [],
        catagoryId: json["CatagoryId"],
        price: json["Price"],
        organizerId: json["OrganizerID"],
        isPublished: json["IsPublished"],
        lastUpdated: json["LastUpdated"],
        isFav: json["isFav"],
        standingTitle: json["StandingTitle"],
        seatingTitle: json["SeatingTitle"],
        ticketSoldOutText: json["TicketSoldOutText"],
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
        "PostEventImages": postEventImages,
        "PreEventImages": preEventImages,
        "CatagoryId": catagoryId,
        "Price": price,
        "OrganizerID": organizerId,
        "IsPublished": isPublished,
        "LastUpdated": lastUpdated,
        "isFav": isFav,
        "StandingTitle": standingTitle,
        "SeatingTitle": seatingTitle,
        "TicketSoldOutText": ticketSoldOutText,
      };
}
