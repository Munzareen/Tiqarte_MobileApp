import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/model/CategoryModel.dart';
import 'package:tiqarte/model/SeeAllProductModel.dart';

class SeeAllProductController extends GetxController {
  bool isSearch = false;
  final searchController = TextEditingController();
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final searchFocusNode = FocusNode();

  bool isListSelected = true;

  List<CategoryModel>? seeAllProductCategoryList;

  List<SeeAllProductModel>? seeAllProductModel;
  List<SeeAllProductModel>? seeAllProductModelAll;

  addSeeAllProductData(dynamic data) async {
    seeAllProductModel = seeAllProductModelFromJson(data);
    seeAllProductModelAll = [...seeAllProductModel!];

    if (seeAllProductCategoryList == null) {
      var res = await ApiService().getCategories();
      if (res != null && res is List) {
        seeAllProductCategoryList = categoryModelFromJson(res);

        seeAllProductCategoryList?[0].isSelected = true;
      }
    }

    update();
  }

  isSearchOrNot(bool value) {
    isSearch = value;
    update();
  }

  isListSelectedOrNot(bool value) {
    isListSelected = value;
    update();
  }

  selectSeeAllCategory(int index) {
    seeAllProductCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    seeAllProductCategoryList?[index].isSelected = true;

    seeAllProductModel = [...seeAllProductModelAll!];

    seeAllProductModel?.removeWhere((element) =>
        int.parse(element.catagoryId.toString()) !=
        seeAllProductCategoryList![index].id!.toInt());
    if (searchController.text.trim().isNotEmpty) {
      searchProduct(searchController.text);
    }

    update();
  }

  onSearchClose(TextEditingController textEditingController) {
    isSearch = false;
    textEditingController.clear();
    seeAllProductModel = [...seeAllProductModelAll!];

    update();
  }

  searchProduct(String query) {
    CategoryModel cat = seeAllProductCategoryList!
        .firstWhere((element) => element.isSelected == true);

    seeAllProductModel = [...seeAllProductModelAll!];
    seeAllProductModel?.removeWhere((element) => element.catagoryId != cat.id);
    final suggestion = seeAllProductModel!.where((element) {
      final eventName = element.name!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    seeAllProductModel = suggestion;

    update();
  }

  @override
  void onInit() {
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        filledColorSearch = kPrimaryColor.withOpacity(0.2);
        iconColorSearch = kPrimaryColor;
        update();
      } else {
        filledColorSearch = kDisabledColor.withOpacity(0.4);
        iconColorSearch = kDisabledColor;

        update();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.onClose();
  }
}
