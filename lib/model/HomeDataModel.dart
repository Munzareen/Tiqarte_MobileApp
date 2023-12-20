class HomeDataModel {
  String? welcomeMessage;
  // Null? profilePictureUrl;
  // Null? userName;
  List<Event>? featuredEvents;
  List<Event>? upComingEvents;
  List<Shop>? shop;
  //Null? eventType;
  EventCounts? eventCounts;
  String? inviteFriendsLink;

  num? userId;

  HomeDataModel(
      {this.welcomeMessage,
      // this.profilePictureUrl,
      // this.userName,
      this.featuredEvents,
      this.upComingEvents,
      this.shop,
      // this.eventType,
      this.eventCounts,
      this.inviteFriendsLink,
      this.userId});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    welcomeMessage = json['WelcomeMessage'];
    //  profilePictureUrl = json['ProfilePictureUrl'];
    // userName = json['UserName'];
    if (json['FeaturedEvents'] != null) {
      featuredEvents = <Event>[];
      json['FeaturedEvents'].forEach((v) {
        featuredEvents!.add(new Event.fromJson(v));
      });
    }
    if (json['UpComingEvents'] != null) {
      upComingEvents = <Event>[];
      json['UpComingEvents'].forEach((v) {
        upComingEvents!.add(new Event.fromJson(v));
      });
    }
    if (json['Shop'] != null) {
      shop = <Shop>[];
      json['Shop'].forEach((v) {
        shop!.add(new Shop.fromJson(v));
      });
    }
    //eventType = json['EventType'];
    eventCounts = json['EventCounts'] != null
        ? new EventCounts.fromJson(json['EventCounts'])
        : null;
    inviteFriendsLink = json['InviteFriendsLink'];
    userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WelcomeMessage'] = this.welcomeMessage;
    // data['ProfilePictureUrl'] = this.profilePictureUrl;
    // data['UserName'] = this.userName;
    if (this.featuredEvents != null) {
      data['FeaturedEvents'] =
          this.featuredEvents!.map((v) => v.toJson()).toList();
    }
    if (this.upComingEvents != null) {
      data['UpComingEvents'] =
          this.upComingEvents!.map((v) => v.toJson()).toList();
    }
    if (this.shop != null) {
      data['Shop'] = this.shop!.map((v) => v.toJson()).toList();
    }
    // data['EventType'] = this.eventType;
    if (this.eventCounts != null) {
      data['EventCounts'] = this.eventCounts!.toJson();
    }
    data['InviteFriendsLink'] = this.inviteFriendsLink;
    data['UserId'] = this.userId;
    return data;
  }
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
  num? organizerID;
  bool? isPublished;
  String? lastUpdated;
  bool? isFav;
  String? standingTitle;
  String? seatingTitle;
  String? ticketSoldOutText;
  num? reviewRating;

  Event(
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
      this.organizerID,
      this.isPublished,
      this.lastUpdated,
      this.isFav,
      this.standingTitle,
      this.seatingTitle,
      this.ticketSoldOutText,
      this.reviewRating});

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['EventId'];
    name = json['Name'];
    compnayName = json['CompnayName'];
    discription = json['Discription'];
    location = json['Location'];
    city = json['City'];
    eventDate = json['EventDate'];
    creationUserId = json['CreationUserId'];
    eventStatusId = json['EventStatusId'];
    eventTypeId = json['EventTypeId'];
    postEventImages = json['PostEventImages'].cast<String>();
    preEventImages = json['PreEventImages'].cast<String>();
    catagoryId = json['CatagoryId'];
    price = json['Price'];
    organizerID = json['OrganizerID'];
    isPublished = json['IsPublished'];
    lastUpdated = json['LastUpdated'];
    isFav = json['isFav'];
    standingTitle = json['StandingTitle'];
    seatingTitle = json['SeatingTitle'];
    ticketSoldOutText = json['TicketSoldOutText'];
    reviewRating = json['ReviewRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;
    data['Name'] = this.name;
    data['CompnayName'] = this.compnayName;
    data['Discription'] = this.discription;
    data['Location'] = this.location;
    data['City'] = this.city;
    data['EventDate'] = this.eventDate;
    data['CreationUserId'] = this.creationUserId;
    data['EventStatusId'] = this.eventStatusId;
    data['EventTypeId'] = this.eventTypeId;
    data['PostEventImages'] = this.postEventImages;
    data['PreEventImages'] = this.preEventImages;
    data['CatagoryId'] = this.catagoryId;
    data['Price'] = this.price;
    data['OrganizerID'] = this.organizerID;
    data['IsPublished'] = this.isPublished;
    data['LastUpdated'] = this.lastUpdated;
    data['isFav'] = this.isFav;
    data['StandingTitle'] = this.standingTitle;
    data['SeatingTitle'] = this.seatingTitle;
    data['TicketSoldOutText'] = this.ticketSoldOutText;
    data['ReviewRating'] = this.reviewRating;

    return data;
  }
}

class Shop {
  num? id;
  String? sku;
  String? productName;
  String? description;
  String? deliveryDetails;
  num? price;
  num? catagoryId;
  String? productFor;
  bool? isActive;
  num? promotorId;
  List<String>? productImages;
  List<dynamic>? attributes;

  String? createdDate;

  Shop({
    this.id,
    this.sku,
    this.productName,
    this.description,
    this.deliveryDetails,
    this.price,
    this.catagoryId,
    this.productFor,
    this.isActive,
    this.promotorId,
    this.productImages,
    this.attributes,
    this.createdDate,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["Id"],
        sku: json["Sku"],
        productName: json["ProductName"],
        description: json["Description"],
        deliveryDetails: json["DeliveryDetails"],
        price: json["Price"],
        catagoryId: json["CatagoryId"],
        productFor: json["ProductFor"],
        isActive: json["isActive"],
        promotorId: json["PromotorId"],
        productImages: json["ProductImages"] != null
            ? List<String>.from(json["ProductImages"].where((x) => x != null))
            : [],
        attributes: json["Attributes"] != null
            ? List<dynamic>.from(json["Attributes"].where((x) => x != null))
            : [],
        createdDate: json["CreatedDate"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Sku": sku,
        "ProductName": productName,
        "Description": description,
        "DeliveryDetails": deliveryDetails,
        "Price": price,
        "CatagoryId": catagoryId,
        "ProductFor": productFor,
        "isActive": isActive,
        "PromotorId": promotorId,
        "ProductImages": List<dynamic>.from(productImages!.map((x) => x)),
        "Attributes": List<dynamic>.from(attributes!.map((x) => x)),
        "CreatedDate": createdDate,
      };
}

class EventCounts {
  num? cancelled;
  num? going;
  num? completed;

  EventCounts({this.cancelled, this.going, this.completed});

  EventCounts.fromJson(Map<String, dynamic> json) {
    cancelled = json['Cancelled'] != null ? json['Cancelled'] : 0;
    going = json['Going'] != null ? json['Going'] : 0;
    completed = json['Completed'] != null ? json['Completed'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Cancelled'] = this.cancelled;
    data['Going'] = this.going;
    data['Completed'] = this.completed;
    return data;
  }
}

// class UpComingEvents {
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
//   num? catagoryId;
//   num? price;
//   num? organizerID;
//   bool? isPublished;
//   String? lastUpdated;
//   bool? isFav;
//   String? standingTitle;
//   String? seatingTitle;
//   String? ticketSoldOutText;

//   UpComingEvents(
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
//       this.organizerID,
//       this.isPublished,
//       this.lastUpdated,
//       this.isFav,
//       this.standingTitle,
//       this.seatingTitle,
//       this.ticketSoldOutText});

//   UpComingEvents.fromJson(Map<String, dynamic> json) {
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
//     preEventImages = json['PreEventImages'].cast<String>();
//     catagoryId = json['CatagoryId'];
//     price = json['Price'];
//     organizerID = json['OrganizerID'];
//     isPublished = json['IsPublished'];
//     lastUpdated = json['LastUpdated'];
//     isFav = json['isFav'];
//     standingTitle = json['StandingTitle'];
//     seatingTitle = json['SeatingTitle'];
//     ticketSoldOutText = json['TicketSoldOutText'];
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
//     data['PreEventImages'] = this.preEventImages;
//     data['CatagoryId'] = this.catagoryId;
//     data['Price'] = this.price;
//     data['OrganizerID'] = this.organizerID;
//     data['IsPublished'] = this.isPublished;
//     data['LastUpdated'] = this.lastUpdated;
//     data['isFav'] = this.isFav;
//     data['StandingTitle'] = this.standingTitle;
//     data['SeatingTitle'] = this.seatingTitle;
//     data['TicketSoldOutText'] = this.ticketSoldOutText;
//     return data;
//   }
// }









// // To parse this JSON data, do
// //
// //     final homeDataModel = homeDataModelFromJson(jsonString);

// import 'dart:convert';

// // HomeDataModel homeDataModelFromJson(String? str) => HomeDataModel.fromJson(json.decode(str));

// // String? homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

// class HomeDataModel {
//   // String? welcomeMessage;
//   // String? profilePictureUrl;
//   // String? userName;
//   List<Event>? featuredEvents;
//   List<Event>? upComingEvents;
//   List<Shop>? shop;
//   dynamic eventType;
//   List<String>? postEventImages;
//   List<String>? preEventImages;
//   // num? userId;

//   HomeDataModel({
//     // this.welcomeMessage,
//     // this.profilePictureUrl,
//     // this.userName,
//     this.featuredEvents,
//     this.upComingEvents,
//     this.shop,
//     this.eventType,
//     this.postEventImages,
//     this.preEventImages,
//     //  this.userId,
//   });

//   factory HomeDataModel.fromJson(Map<String?, dynamic> json) => HomeDataModel(
//         // welcomeMessage: json["WelcomeMessage"],
//         // profilePictureUrl: json["ProfilePictureUrl"],
//         // userName: json["UserName"],
//         featuredEvents: List<Event>.from(
//             json["FeaturedEvents"].map((x) => Event.fromJson(x))),
//         upComingEvents: List<Event>.from(
//             json["UpComingEvents"].map((x) => Event.fromJson(x))),
//         shop: List<Shop>.from(json["Shop"].map((x) => Shop.fromJson(x))),
//         eventType: json["EventType"],
//         postEventImages:
//             List<String>.from(json["PostEventImages"].map((x) => x)),
//         preEventImages: List<String>.from(json["PreEventImages"].map((x) => x)),
//         //  userId: json["UserId"],
//       );

//   Map<String?, dynamic> toJson() => {
//         // "WelcomeMessage": welcomeMessage,
//         // "ProfilePictureUrl": profilePictureUrl,
//         // "UserName": userName,
//         "FeaturedEvents":
//             List<Event>.from(featuredEvents!.map((x) => x.toJson())),
//         "UpComingEvents":
//             List<Event>.from(upComingEvents!.map((x) => x.toJson())),
//         "Shop": List<Shop>.from(shop!.map((x) => x.toJson())),
//         "EventType": eventType,
//         "PostEventImages": List<String>.from(postEventImages!.map((x) => x)),
//         "PreEventImages": List<String>.from(preEventImages!.map((x) => x)),
//         // "UserId": userId,
//       };
// }

// class Event {
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
//   dynamic catagoryId;
//   num? price;
//   num? organizerId;
//   bool? isPublished;
//   String? lastUpdated;
//   bool? isFav;
//   dynamic standingTitle;
//   dynamic seatingTitle;
//   dynamic ticketSoldOutText;

//   Event({
//     this.eventId,
//     this.name,
//     this.compnayName,
//     this.discription,
//     this.location,
//     this.city,
//     this.eventDate,
//     this.creationUserId,
//     this.eventStatusId,
//     this.eventTypeId,
//     this.postEventImages,
//     this.preEventImages,
//     this.catagoryId,
//     this.price,
//     this.organizerId,
//     this.isPublished,
//     this.lastUpdated,
//     this.isFav,
//     this.standingTitle,
//     this.seatingTitle,
//     this.ticketSoldOutText,
//   });

//   factory Event.fromJson(Map<String?, dynamic> json) => Event(
//         eventId: json["EventId"],
//         name: json["Name"],
//         compnayName: json["CompnayName"],
//         discription: json["Discription"],
//         location: json["Location"],
//         city: json["City"],
//         eventDate: json["EventDate"],
//         creationUserId: json["CreationUserId"],
//         eventStatusId: json["EventStatusId"],
//         eventTypeId: json["EventTypeId"],
//         postEventImages:
//             List<String>.from(json["PostEventImages"].map((x) => x)),
//         preEventImages: List<String>.from(json["PreEventImages"].map((x) => x)),
//         catagoryId: json["CatagoryId"],
//         price: json["Price"],
//         organizerId: json["OrganizerID"],
//         isPublished: json["IsPublished"],
//         lastUpdated: json["LastUpdated"],
//         isFav: json["isFav"],
//         standingTitle: json["StandingTitle"],
//         seatingTitle: json["SeatingTitle"],
//         ticketSoldOutText: json["TicketSoldOutText"],
//       );

//   Map<String?, dynamic> toJson() => {
//         "EventId": eventId,
//         "Name": name,
//         "CompnayName": compnayName,
//         "Discription": discription,
//         "Location": location,
//         "City": city,
//         "EventDate": eventDate,
//         "CreationUserId": creationUserId,
//         "EventStatusId": eventStatusId,
//         "EventTypeId": eventTypeId,
//         "PostEventImages": List<String>.from(postEventImages!.map((x) => x)),
//         "PreEventImages": List<String>.from(preEventImages!.map((x) => x)),
//         "CatagoryId": catagoryId,
//         "Price": price,
//         "OrganizerID": organizerId,
//         "IsPublished": isPublished,
//         "LastUpdated": lastUpdated,
//         "isFav": isFav,
//         "StandingTitle": standingTitle,
//         "SeatingTitle": seatingTitle,
//         "TicketSoldOutText": ticketSoldOutText,
//       };
// }

// class Shop {
//   num? id;
//   num? eventId;
//   String? name;
//   num? price;
//   String? image;
//   String? createdDate;
//   String? updatedDate;

//   Shop({
//     this.id,
//     this.eventId,
//     this.name,
//     this.price,
//     this.image,
//     this.createdDate,
//     this.updatedDate,
//   });

//   factory Shop.fromJson(Map<String?, dynamic> json) => Shop(
//         id: json["Id"],
//         eventId: json["EventId"],
//         name: json["Name"],
//         price: json["Price"],
//         image: json["Image"],
//         createdDate: json["CreatedDate"],
//         updatedDate: json["UpdatedDate"],
//       );

//   Map<String?, dynamic> toJson() => {
//         "Id": id,
//         "EventId": eventId,
//         "Name": name,
//         "Price": price,
//         "Image": image,
//         "CreatedDate": createdDate,
//         "UpdatedDate": updatedDate,
//       };
// }







