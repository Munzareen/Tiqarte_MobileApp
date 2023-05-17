import 'dart:convert';

EventDetailModel eventDetailModelFromJson(String str) =>
    EventDetailModel.fromJson(json.decode(str));

String eventDetailModelToJson(EventDetailModel data) =>
    json.encode(data.toJson());

class EventDetailModel {
  num? id;
  String? name;
  String? description;
  dynamic collection;
  List<Event>? events;

  EventDetailModel({
    this.id,
    this.name,
    this.description,
    this.collection,
    this.events,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) =>
      EventDetailModel(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        collection: json["Collection"],
        events: List<Event>.from(json["Events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Collection": collection,
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
  dynamic catagoryId;
  num? price;
  num? organizerId;
  bool? isPublished;
  String? lastUpdated;
  bool? isFav;
  dynamic standingTitle;
  dynamic seatingTitle;
  dynamic ticketSoldOutText;

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
        "EventImages": List<String>.from(eventImages!.map((x) => x)),
        "PreviousImages": List<String>.from(previousImages!.map((x) => x)),
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
