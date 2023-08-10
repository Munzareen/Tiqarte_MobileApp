import 'package:get/get.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/model/SeeAllProductModel.dart';
import 'package:tiqarte/model/ViewProductModel.dart';

class ViewProductController extends GetxController {
  ViewProductModel viewProductModel = ViewProductModel();
  List<Variation> colorList = [];
  List<Variation> sizeList = [];
  List<SeeAllProductModel> moreLikeProducts = [];
  List<String> quantityList = [];

  String? selectedColor;
  String? selectedSize;
  String? selectedQuantity;

  int customIndex = 0;

  addViewProductData(dynamic data) {
    colorList.clear();
    sizeList.clear();
    quantityList.clear();
    viewProductModel = ViewProductModel.fromJson(data);
    if (viewProductModel.attributes!.isNotEmpty) {
      if (viewProductModel.attributes![0].variations!.isNotEmpty) {
        quantityList = generateQuantityList(viewProductModel
            .attributes![0].variations![0].availableQuantity!
            .toInt());
      }
      viewProductModel.attributes?.forEach((element) {
        if (element.attributeName!.toUpperCase().contains("COLOR")) {
          colorList = element.variations!;
        } else if (element.attributeName!.toUpperCase().contains("SIZE")) {
          sizeList = element.variations!;
        }
        //  else if (element.attributeName!.toUpperCase().contains("QUANTITY")) {
        //   quantityList = element.variations!;
        // }
      });

      if (colorList.isEmpty || sizeList.isEmpty) {
        //|| quantityList.isEmpty
        Get.back();
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      } else {
        update();
      }
    } else {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  List<String> generateQuantityList(int value) {
    List<String> numberList = [];
    for (int i = 1; i <= value; i++) {
      numberList.add(i.toString());
    }
    return numberList;
  }

  addMoreLikeProductsData(List data, String productId) {
    moreLikeProducts.clear();
    moreLikeProducts = seeAllProductModelFromJson(data);
    // moreLikeProducts.removeWhere(
    //     (element) => int.parse(element.id.toString()) == int.parse(productId));
    update();
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
