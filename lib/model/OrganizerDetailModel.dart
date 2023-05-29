// To parse this JSON data, do
//
//     final organizerDetailModel = organizerDetailModelFromJson(jsonString);

import 'dart:convert';

OrganizerDetailModel organizerDetailModelFromJson(String str) =>
    OrganizerDetailModel.fromJson(json.decode(str));

String organizerDetailModelToJson(OrganizerDetailModel data) =>
    json.encode(data.toJson());

class OrganizerDetailModel {
  bool? isFollow;
  Organizer? organizer;
  List<Event>? events;
  List<Collection>? collections;

  OrganizerDetailModel({
    this.isFollow,
    this.organizer,
    this.events,
    this.collections,
  });

  factory OrganizerDetailModel.fromJson(Map<String, dynamic> json) =>
      OrganizerDetailModel(
        isFollow: json["isFollow"],
        organizer: Organizer.fromJson(json["Organizer"]),
        events: json["Events"] != null
            ? List<Event>.from(json["Events"].map((x) => Event.fromJson(x)))
            : [],
        collections: json["Collections"] != null
            ? List<Collection>.from(
                json["Collections"].map((x) => Collection.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "isFollow": isFollow,
        "Organizer": organizer?.toJson(),
        "Events": List<dynamic>.from(events!.map((x) => x.toJson())),
        "Collections": List<dynamic>.from(collections!.map((x) => x.toJson())),
      };
}

class Collection {
  num? id;
  num? organizerId;
  String? imageUrl;

  Collection({
    this.id,
    this.organizerId,
    this.imageUrl,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["Id"],
        organizerId: json["OrganizerId"],
        imageUrl: json["ImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizerId": organizerId,
        "ImageURL": imageUrl,
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
        postEventImages:
            List<String>.from(json["PostEventImages"].map((x) => x)),
        preEventImages: List<String>.from(json["PreEventImages"].map((x) => x)),
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
        "PostEventImages": List<dynamic>.from(postEventImages!.map((x) => x)),
        "PreEventImages": List<dynamic>.from(preEventImages!.map((x) => x)),
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

class Organizer {
  num? id;
  String? name;
  dynamic about;
  String? imageUrl;
  num? followers;
  dynamic collections;

  Organizer({
    this.id,
    this.name,
    this.about,
    this.imageUrl,
    this.followers,
    this.collections,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
        id: json["Id"],
        name: json["Name"],
        about: json["About"],
        imageUrl: json["ImageURL"],
        followers: json["Followers"],
        collections: json["Collections"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "About": about,
        "ImageURL": imageUrl,
        "Followers": followers,
        "Collections": collections,
      };
}
