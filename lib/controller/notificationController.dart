import 'package:get/get.dart';
import 'package:tiqarte/model/NotificationModel.dart';

class NotificationController extends GetxController {
  List<NotificationModel>? notificationList;

  addNotifications(List data) {
    notificationList = notificationModelFromJson(data);
    update();
  }
}
