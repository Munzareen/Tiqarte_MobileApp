class EventModel {
  int? eventId;
  String? name;
  String? compnayName;
  String? discription;
  String? location;
  String? city;
  String? eventDate;
  int? creationUserId;
  int? eventStatusId;
  int? eventTypeId;
  List<String>? postEventImages;
  List<String>? preEventImages;
  Null? catagoryId;
  int? price;
  int? organizerID;

  EventModel(
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
      this.organizerID});

  EventModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
