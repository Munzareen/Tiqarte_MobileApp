// To parse this JSON data, do
//
//     final relatedEventModel = relatedEventModelFromJson(jsonString);

import 'dart:convert';

List<RelatedEventModel> relatedEventModelFromJson(List data) =>
    List<RelatedEventModel>.from(
        data.map((x) => RelatedEventModel.fromJson(x)));

String relatedEventModelToJson(List<RelatedEventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RelatedEventModel {
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
  List<String>? eventImages;
  List<String>? previousImages;
  dynamic catagoryId;
  num? price;
  num? organizerId;
  bool? isPublished;
  String? lastUpdated;
  bool? isFav;
  dynamic standingTitle;
  dynamic seatingTitle;
  dynamic ticketSoldOutText;

  RelatedEventModel({
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
    this.eventImages,
    this.previousImages,
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

  factory RelatedEventModel.fromJson(Map<String, dynamic> json) =>
      RelatedEventModel(
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
        eventImages: List<String>.from(json["EventImages"].map((x) => x)),
        previousImages: List<String>.from(json["PreviousImages"].map((x) => x)),
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
        "EventImages": List<dynamic>.from(eventImages!.map((x) => x)),
        "PreviousImages": List<dynamic>.from(previousImages!.map((x) => x)),
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
