import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/model/CategoryModel.dart';
import 'package:tiqarte/model/SeeAllEventModel.dart';

class SeeAllEventController extends GetxController {
  bool isSearch = false;
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final searchFocusNode = FocusNode();

  bool isListSelected = true;

  List<CategoryModel>? seeAllCategoryList;

  List<SeeAllEventModel>? seeAllEventModel;
  List<SeeAllEventModel>? seeAllEventModelAll;

  Timer? debounceTimer;
  final searchController = TextEditingController();

  addSeeAllData(dynamic data) async {
    seeAllEventModel = seeAllEventModelFromJson(data);
    seeAllEventModelAll = [...seeAllEventModel!];

    if (seeAllCategoryList == null) {
      var res = await ApiService().getCategories();
      if (res != null && res is List) {
        seeAllCategoryList = categoryModelFromJson(res);
        seeAllCategoryList?.insert(
            0, CategoryModel.fromJson({"Id": null, "CatagoryName": "all"}));
        seeAllCategoryList?[0].isSelected = true;
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
    seeAllCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    seeAllCategoryList?[index].isSelected = true;

    if (seeAllCategoryList![index].id == null) {
      seeAllEventModel = [...seeAllEventModelAll!];
    } else {
      seeAllEventModel = [...seeAllEventModelAll!];

      seeAllEventModel?.removeWhere((element) =>
          int.parse(element.catagoryId.toString()) !=
          seeAllCategoryList![index].id!.toInt());
    }
    update();
  }

  void onTextChanged() {
    if (debounceTimer?.isActive ?? false) {
      debounceTimer!.cancel();
    }

    debounceTimer = Timer(Duration(milliseconds: 1200), () async {
      if (searchController.text.trim() != '') {
        var res = await ApiService()
            .getEventSearch(Get.context!, searchController.text.trim());
        if (res != null && res is List) {
          addSeeAllData(res);
        } else {
          customSnackBar("Error!", "Something went wrong!");
        }
      }
    });
  }

  @override
  void onInit() {
    searchController.addListener(onTextChanged);
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
    searchController.removeListener(onTextChanged);
    debounceTimer?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
