import 'dart:convert';

EventDetailModel eventDetailModelFromJson(String str) =>
    EventDetailModel.fromJson(json.decode(str));

String eventDetailModelToJson(EventDetailModel data) =>
    json.encode(data.toJson());

class EventDetailModel {
  bool? isOrganizerFollow;
  Event? event;
  Organizer? organizer;
  List<Customer>? customers;
  List<EventTicketDetails>? eventTicketDetails;
  num? reviewRating;

  EventDetailModel(
      {this.isOrganizerFollow,
      this.event,
      this.organizer,
      this.customers,
      this.eventTicketDetails,
      this.reviewRating});

  factory EventDetailModel.fromJson(Map<String, dynamic> json) =>
      EventDetailModel(
        isOrganizerFollow: json['isOrganizerFollow'],
        event: Event.fromJson(json["Event"]),
        organizer: json["Organizer"] != null
            ? Organizer.fromJson(json["Organizer"])
            : null,
        customers: json["Customers"] != null
            ? List<Customer>.from(
                json["Customers"].map((x) => Customer.fromJson(x)))
            : [],
        eventTicketDetails: json["EventTicketDetails"] != null
            ? List<EventTicketDetails>.from(json["EventTicketDetails"]
                .map((x) => EventTicketDetails.fromJson(x)))
            : [],
        reviewRating:
            json['ReviewRating'] == null || (json['ReviewRating'] is String)
                ? 0
                : json['ReviewRating'],
      );

  Map<String, dynamic> toJson() => {
        "isOrganizerFollow": isOrganizerFollow,
        "Event": event?.toJson(),
        "Organizer": organizer?.toJson(),
        "Customers": List<dynamic>.from(customers!.map((x) => x.toJson())),
        "EventTicketDetails":
            List<dynamic>.from(eventTicketDetails!.map((x) => x.toJson())),
        "ReviewRating": reviewRating,
      };
}

class Customer {
  num? id;
  num? userId;
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
  List<String>? postEventImages;
  List<String>? preEventImages;
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
        locationName: "null",
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
        "PostEventImages": List<String>.from(postEventImages!.map((x) => x)),
        "PreEventImages": List<String>.from(preEventImages!.map((x) => x)),
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

class EventTicketDetails {
  num? id;
  String? ticketType;
  num? ticketPrice;
  num? ticketCount;

  EventTicketDetails(
      {this.id, this.ticketType, this.ticketPrice, this.ticketCount});

  EventTicketDetails.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    ticketType = json['TicketType'];
    ticketPrice = json['TicketPrice'];
    ticketCount = json['TicketCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['TicketType'] = this.ticketType;
    data['TicketPrice'] = this.ticketPrice;
    data['TicketCount'] = this.ticketCount;
    return data;
  }
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
//   List<String>? postEventImages;
//   List<String>? preEventImages;
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
//       this.postEventImages,
//       this.preEventImages,
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
//     postEventImages = json['PostEventImages'].cast<String>();
//     preEventImages = json['PreviousImages'].cast<String>();
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
//     data['PostEventImages'] = this.postEventImages;
//     data['PreviousImages'] = this.preEventImages;
//     data['CatagoryId'] = this.catagoryId;
//     data['Price'] = this.price;
//     data['OrganizerID'] = this.organizerID;
//     return data;
//   }
// }
