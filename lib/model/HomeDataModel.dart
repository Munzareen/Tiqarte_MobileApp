class HomeDataModel {
  String? welcomeMessage;
  String? profilePictureUrl;
  String? userName;
  List<FeaturedEvents>? featuredEvents;
  List<UpComingEvents>? upComingEvents;
  List<Shop>? shop;
  String? eventType;
  List<String>? eventImages;
  List<String>? previousImages;

  HomeDataModel(
      {this.welcomeMessage,
      this.profilePictureUrl,
      this.userName,
      this.featuredEvents,
      this.upComingEvents,
      this.shop,
      this.eventType,
      this.eventImages,
      this.previousImages});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    welcomeMessage = json['WelcomeMessage'];
    profilePictureUrl = json['ProfilePictureUrl'];
    userName = json['UserName'];
    if (json['FeaturedEvents'] != null) {
      featuredEvents = <FeaturedEvents>[];
      json['FeaturedEvents'].forEach((v) {
        featuredEvents!.add(new FeaturedEvents.fromJson(v));
      });
    }
    if (json['UpComingEvents'] != null) {
      upComingEvents = <UpComingEvents>[];
      json['UpComingEvents'].forEach((v) {
        upComingEvents!.add(new UpComingEvents.fromJson(v));
      });
    }
    if (json['Shop'] != null) {
      shop = <Shop>[];
      json['Shop'].forEach((v) {
        shop!.add(new Shop.fromJson(v));
      });
    }
    eventType = json['EventType'];
    eventImages = json['EventImages'].cast<String>();
    previousImages = json['PreviousImages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WelcomeMessage'] = this.welcomeMessage;
    data['ProfilePictureUrl'] = this.profilePictureUrl;
    data['UserName'] = this.userName;
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
    data['EventType'] = this.eventType;
    data['EventImages'] = this.eventImages;
    data['PreviousImages'] = this.previousImages;
    return data;
  }
}

class FeaturedEvents {
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
  String? catagoryId;
  num? price;
  num? organizerID;

  FeaturedEvents(
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
      this.eventImages,
      this.previousImages,
      this.catagoryId,
      this.price,
      this.organizerID});

  FeaturedEvents.fromJson(Map<String, dynamic> json) {
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
    eventImages = json['EventImages'].cast<String>();
    previousImages = json['PreviousImages'].cast<String>();
    catagoryId = json['CatagoryId'];
    price = json['Price'];
    organizerID = json['OrganizerID'];
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
    data['EventImages'] = this.eventImages;
    data['PreviousImages'] = this.previousImages;
    data['CatagoryId'] = this.catagoryId;
    data['Price'] = this.price;
    data['OrganizerID'] = this.organizerID;
    return data;
  }
}

class Shop {
  num? id;
  num? eventId;
  String? name;
  double? price;
  String? image;
  String? createdDate;
  String? updatedDate;

  Shop(
      {this.id,
      this.eventId,
      this.name,
      this.price,
      this.image,
      this.createdDate,
      this.updatedDate});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    eventId = json['EventId'];
    name = json['Name'];
    price = json['Price'];
    image = json['Image'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EventId'] = this.eventId;
    data['Name'] = this.name;
    data['Price'] = this.price;
    data['Image'] = this.image;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}

class UpComingEvents {
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
  String? catagoryId;
  num? price;
  num? organizerID;

  UpComingEvents(
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
      this.eventImages,
      this.previousImages,
      this.catagoryId,
      this.price,
      this.organizerID});

  UpComingEvents.fromJson(Map<String, dynamic> json) {
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
    eventImages = json['EventImages'].cast<String>();
    previousImages = json['PreviousImages'].cast<String>();
    catagoryId = json['CatagoryId'];
    price = json['Price'];
    organizerID = json['OrganizerID'];
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
    data['EventImages'] = this.eventImages;
    data['PreviousImages'] = this.previousImages;
    data['CatagoryId'] = this.catagoryId;
    data['Price'] = this.price;
    data['OrganizerID'] = this.organizerID;
    return data;
  }
}
