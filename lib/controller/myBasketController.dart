import 'package:get/get.dart';
import 'package:tiqarte/model/MyBasketProductsModel.dart';

class MyBasketController extends GetxController {
  List<MyBasketProductsModel>? myBasketProductsModel;

  num subTotalPrice = 0.0;
  List cartIds = [];

  addMyBasketData(List data) {
    subTotalPrice = 0.0;

    myBasketProductsModel = myBasketProductsModelFromJson(data);
    if (myBasketProductsModel != null && myBasketProductsModel!.isNotEmpty) {
      myBasketProductsModel?.forEach((element) {
        subTotalPrice += element.price!.toDouble();
      });
      subTotalPrice = num.parse(subTotalPrice.toStringAsFixed(2));
    }
    update();
  }
}
