import 'dart:convert';

List<NotificationModel> notificationModelFromJson(List data) =>
    List<NotificationModel>.from(
        data.map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  String? notificationHeader;
  String? notificationText;
  String? notificationType;
  String? iconURL;
  bool? isRead;
  String? creationTime;

  NotificationModel(
      {this.notificationHeader,
      this.notificationText,
      this.notificationType,
      this.iconURL,
      this.isRead,
      this.creationTime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationHeader = json['NotificationHeader'];
    notificationText = json['NotificationText'];
    notificationType = json['NotificationType'];
    iconURL = json['iconURL'];
    isRead = json['isRead'];
    creationTime = json['CreationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationHeader'] = this.notificationHeader;
    data['NotificationText'] = this.notificationText;
    data['NotificationType'] = this.notificationType;
    data['iconURL'] = this.iconURL;
    data['isRead'] = this.isRead;
    data['CreationTime'] = this.creationTime;
    return data;
  }
}
