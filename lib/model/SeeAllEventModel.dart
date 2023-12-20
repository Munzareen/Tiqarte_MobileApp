import 'dart:convert';

List<SeeAllEventModel> seeAllEventModelFromJson(List data) =>
    List<SeeAllEventModel>.from(data.map((x) => SeeAllEventModel.fromJson(x)));

String seeAllEventModelToJson(List<SeeAllEventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeeAllEventModel {
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
  bool? isPublished;
  String? lastUpdated;
  bool? isFav;
  dynamic standingTitle;
  dynamic seatingTitle;
  dynamic ticketSoldOutText;
  num? reviewRating;

  SeeAllEventModel(
      {this.eventId,
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
      this.reviewRating});

  factory SeeAllEventModel.fromJson(Map<String, dynamic> json) =>
      SeeAllEventModel(
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
        isPublished: json["IsPublished"],
        lastUpdated: json["LastUpdated"],
        isFav: json["isFav"],
        standingTitle: json["StandingTitle"],
        seatingTitle: json["SeatingTitle"],
        ticketSoldOutText: json["TicketSoldOutText"],
        reviewRating:
            json['ReviewRating'] == null || (json['ReviewRating'] is String)
                ? 0
                : json['ReviewRating'],
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
        "ReviewRating": reviewRating,
      };
}
