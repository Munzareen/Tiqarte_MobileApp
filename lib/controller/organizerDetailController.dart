import 'package:get/get.dart';
import 'package:tiqarte/model/OrganizerDetailModel.dart';

class OrganizerDetailController extends GetxController {
  OrganizerDetailModel organizerDetailModel = OrganizerDetailModel();

  addOrganizerDetail(dynamic data) {
    organizerDetailModel = OrganizerDetailModel.fromJson(data);
    update();
  }
}
