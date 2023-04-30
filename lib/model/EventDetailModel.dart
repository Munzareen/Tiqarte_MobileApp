class EventDetailModel {
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
  Null? catagoryId;
  num? price;
  num? organizerID;

  EventDetailModel(
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

  EventDetailModel.fromJson(Map<String, dynamic> json) {
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
