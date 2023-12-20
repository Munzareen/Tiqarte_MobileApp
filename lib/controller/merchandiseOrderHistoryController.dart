import 'package:get/get.dart';
import 'package:tiqarte/model/MerchandiseOrderHistoryModel.dart';

class MerchandiseOrderHistoryController extends GetxController {
  List<MerchandiseOrderHistoryModel> merchandiseOrderHistoryList = [];

  addData(List list) {
    merchandiseOrderHistoryList = merchandiseOrderHistoryModelFromJson(list);
    update();
  }
}
