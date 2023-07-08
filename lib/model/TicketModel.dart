import 'dart:convert';

List<TicketModel> ticketModelFromJson(List data) =>
    List<TicketModel>.from(data.map((x) => TicketModel.fromJson(x)));

String ticketModelToJson(List<TicketModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketModel {
  num? ticketId;
  num? ticketUniqueNumber;
  String? eventName;
  String? city;

  String? eventDate;
  String? location;
  String? imageURL;
  String? status;
  num? ticketCount;
  bool? isReviewed;

  TicketModel(
      {this.ticketId,
      this.ticketUniqueNumber,
      this.eventName,
      this.city,
      this.eventDate,
      this.location,
      this.imageURL,
      this.status,
      this.ticketCount,
      this.isReviewed});

  TicketModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['TicketId'];
    ticketUniqueNumber = json['TicketUniqueNumber'];
    eventName = json['EventName'];
    city = json['City'];
    eventDate = json['EventDate'];
    location = json['Location'];
    imageURL = json['ImageURL'];
    status = json['Status'];
    ticketCount = json['TicketCount'];
    isReviewed = json['isReviewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TicketId'] = this.ticketId;
    data['TicketUniqueNumber'] = this.ticketUniqueNumber;
    data['EventName'] = this.eventName;
    data['City'] = this.city;

    data['EventDate'] = this.eventDate;
    data['Location'] = this.location;
    data['ImageURL'] = this.imageURL;
    data['Status'] = this.status;
    data['TicketCount'] = this.ticketCount;
    data['isReviewed'] = this.isReviewed;

    return data;
  }
}
