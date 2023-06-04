import 'package:get/get.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/model/ViewProductModel.dart';

class ViewProductController extends GetxController {
  ViewProductModel viewProductModel = ViewProductModel();
  List<Variation> colorList = [];
  List<Variation> sizeList = [];

  String? selectedColor;
  String? selectedSize;
  int customIndex = 0;

  addViewProductData(dynamic data) {
    colorList.clear();
    sizeList.clear();
    viewProductModel = ViewProductModel.fromJson(data);
    if (viewProductModel.attributes!.isNotEmpty) {
      viewProductModel.attributes?.forEach((element) {
        if (element.attributeName!.toUpperCase().contains("COLOR")) {
          colorList = element.variations!;
        } else if (element.attributeName!.toUpperCase().contains("SIZE")) {
          sizeList = element.variations!;
        }
      });

      if (colorList.isEmpty || sizeList.isEmpty) {
        Get.back();
        customSnackBar("Error!", "Something went wrong!");
      } else {
        update();
      }
    } else {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  selectProductImage(int index) {
    viewProductModel.productImageUrLs?.forEach((element) {
      element.isSelected = false;
    });
    viewProductModel.productImageUrLs?[index].isSelected = true;

    customIndex = index;
    update();
  }
}
