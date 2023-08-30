import 'package:get/get.dart';

class MerchandiseOrderHistoryController extends GetxController {
  List merchandiseOrderHistoryList = [];

  addData(List list) {
    merchandiseOrderHistoryList = list;
    update();
  }
}
