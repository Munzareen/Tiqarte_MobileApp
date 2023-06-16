import 'package:get/get.dart';
import 'package:tiqarte/model/FAQModel.dart';

class HelpCenterController extends GetxController {
  List<FAQModel>? faqModelList;

  addFAQData(List data) {
    faqModelList = fAQModelFromJson(data);
    update();
  }
}
