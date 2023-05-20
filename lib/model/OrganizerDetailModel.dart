// To parse this JSON data, do
//
//     final organizerDetailModel = organizerDetailModelFromJson(jsonString);

import 'dart:convert';

OrganizerDetailModel organizerDetailModelFromJson(String str) =>
    OrganizerDetailModel.fromJson(json.decode(str));

String organizerDetailModelToJson(OrganizerDetailModel data) =>
    json.encode(data.toJson());

class OrganizerDetailModel {
  num? id;
  String? name;
  String? description;
  String? imageUrl;
  num? following;
  List<dynamic>? collection;
  List<Event>? events;

  OrganizerDetailModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.following,
    this.collection,
    this.events,
  });

  factory OrganizerDetailModel.fromJson(Map<String, dynamic> json) =>
      OrganizerDetailModel(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        imageUrl: json["ImageURL"],
        following: json["Following"],
        collection: List<dynamic>.from(json["Collection"].map((x) => x)),
        events: List<Event>.from(json["Events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "ImageURL": imageUrl,
        "Following": following,
        "Collection": List<dynamic>.from(collection!.map((x) => x)),
        "Events": List<dynamic>.from(events!.map((x) => x.toJson())),
      };
}

class Event {
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
  num? catagoryId;
  num? price;
  num? organizerId;
  bool? isPublished;
  String? lastUpdated;
  bool? isFav;
  String? standingTitle;
  String? seatingTitle;
  String? ticketSoldOutText;

  Event({
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

  factory Event.fromJson(Map<String, dynamic> json) => Event(
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
