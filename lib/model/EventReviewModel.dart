import 'dart:convert';

List<EventReviewModel> eventReviewModelFromJson(List data) =>
    List<EventReviewModel>.from(data.map((x) => EventReviewModel.fromJson(x)));

String eventReviewModelToJson(List<EventReviewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventReviewModel {
  int? eventId;
  String? userName;
  String? review;
  num? rating;
  String? eventName;
  String? description;
  String? createDate;

  EventReviewModel(
      {this.eventId,
      this.userName,
      this.review,
      this.rating,
      this.eventName,
      this.description,
      this.createDate});

  EventReviewModel.fromJson(Map<String, dynamic> json) {
    eventId = json['EventId'];
    userName = json['UserName'];
    review = json['Review'];
    rating = json['Rating'] == null || (json['Rating'] is String)
        ? 0
        : json['Rating'];
    eventName = json['EventName'];
    description = json['Description'];
    createDate = json['CreateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;
    data['UserName'] = this.userName;
    data['Review'] = this.review;
    data['Rating'] = this.rating;
    data['EventName'] = this.eventName;
    data['Description'] = this.description;
    data['CreateDate'] = this.createDate;
    return data;
  }
}
