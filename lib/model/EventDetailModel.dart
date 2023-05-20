import 'dart:convert';

EventDetailModel eventDetailModelFromJson(String str) =>
    EventDetailModel.fromJson(json.decode(str));

String eventDetailModelToJson(EventDetailModel data) =>
    json.encode(data.toJson());

class EventDetailModel {
  Event? event;
  Organizer? organizer;
  List<Customer>? customers;

  EventDetailModel({
    this.event,
    this.organizer,
    this.customers,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) =>
      EventDetailModel(
        event: Event.fromJson(json["Event"]),
        organizer: Organizer.fromJson(json["Organizer"]),
        customers: List<Customer>.from(
            json["Customers"].map((x) => Customer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Event": event?.toJson(),
        "Organizer": organizer?.toJson(),
        "Customers": List<dynamic>.from(customers!.map((x) => x.toJson())),
      };
}

class Customer {
  num? id;
  String? userId;
  String? name;
  String? imageUrl;

  Customer({
    this.id,
    this.userId,
    this.name,
    this.imageUrl,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["Id"],
        userId: json["UserId"],
        name: json["Name"],
        imageUrl: json["ImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Name": name,
        "ImageURL": imageUrl,
      };
}

class Event {
  num? eventId;
  String? name;
  String? compnayName;
  String? discription;
  String? location;
  String? locationName;

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
    this.locationName,
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
        locationName: "null",
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

class Organizer {
  num? id;
  String? name;
  String? description;
  String? imageUrl;
  num? following;
  dynamic collection;
  dynamic events;

  Organizer({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.following,
    this.collection,
    this.events,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        imageUrl: json["ImageURL"],
        following: json["Following"],
        collection: json["Collection"],
        events: json["Events"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "ImageURL": imageUrl,
        "Following": following,
        "Collection": collection,
        "Events": events,
      };
}








// class EventDetailModel {
//   num? eventId;
//   String? name;
//   String? compnayName;
//   String? discription;
//   String? location;
//   String? city;
//   String? eventDate;
//   num? creationUserId;
//   num? eventStatusId;
//   num? eventTypeId;
//   List<String>? eventImages;
//   List<String>? previousImages;
//   Null? catagoryId;
//   num? price;
//   num? organizerID;

//   EventDetailModel(
//       {this.eventId,
//       this.name,
//       this.compnayName,
//       this.discription,
//       this.location,
//       this.city,
//       this.eventDate,
//       this.creationUserId,
//       this.eventStatusId,
//       this.eventTypeId,
//       this.eventImages,
//       this.previousImages,
//       this.catagoryId,
//       this.price,
//       this.organizerID});

//   EventDetailModel.fromJson(Map<String, dynamic> json) {
//     eventId = json['EventId'];
//     name = json['Name'];
//     compnayName = json['CompnayName'];
//     discription = json['Discription'];
//     location = json['Location'];
//     city = json['City'];
//     eventDate = json['EventDate'];
//     creationUserId = json['CreationUserId'];
//     eventStatusId = json['EventStatusId'];
//     eventTypeId = json['EventTypeId'];
//     eventImages = json['EventImages'].cast<String>();
//     previousImages = json['PreviousImages'].cast<String>();
//     catagoryId = json['CatagoryId'];
//     price = json['Price'];
//     organizerID = json['OrganizerID'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['EventId'] = this.eventId;
//     data['Name'] = this.name;
//     data['CompnayName'] = this.compnayName;
//     data['Discription'] = this.discription;
//     data['Location'] = this.location;
//     data['City'] = this.city;
//     data['EventDate'] = this.eventDate;
//     data['CreationUserId'] = this.creationUserId;
//     data['EventStatusId'] = this.eventStatusId;
//     data['EventTypeId'] = this.eventTypeId;
//     data['EventImages'] = this.eventImages;
//     data['PreviousImages'] = this.previousImages;
//     data['CatagoryId'] = this.catagoryId;
//     data['Price'] = this.price;
//     data['OrganizerID'] = this.organizerID;
//     return data;
//   }
// }
