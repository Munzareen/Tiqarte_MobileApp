import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/strings.dart';
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

  double distanceValue = 100.0;

  List<String> cityListForFilter = [];
  String? selectedCity;
  List<CategoryModel>? filterCategoryList;

  String eventTypeId = '';

  addSeeAllData(dynamic data) async {
    seeAllEventModel = seeAllEventModelFromJson(data);
    seeAllEventModelAll = [...seeAllEventModel!];

    if (seeAllCategoryList == null || filterCategoryList == null) {
      var res = await ApiService().getCategories();
      if (res != null && res is List) {
        seeAllCategoryList = categoryModelFromJson(res);

        seeAllCategoryList?[0].isSelected = true;

        filterCategoryList = categoryModelFromJson(res);

        filterCategoryList?[0].isSelected = true;
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

    seeAllEventModel = [...seeAllEventModelAll!];

    seeAllEventModel?.removeWhere((element) =>
        element.catagoryId != null &&
        int.parse(element.catagoryId.toString()) !=
            seeAllCategoryList![index].id!.toInt());

    update();
  }

  void onTextChanged() {
    if (debounceTimer?.isActive ?? false) {
      debounceTimer!.cancel();
    }

    debounceTimer = Timer(Duration(milliseconds: 1200), () async {
      if (searchController.text.trim() != '') {
        CategoryModel catId = filterCategoryList!
            .firstWhere((element) => element.isSelected == true);
        String selectedLocation = selectedCity != null ? selectedCity! : '';
        String filterData;

        if (selectedLocation == '') {
          if (catId.id?.toInt() == 1) {
            filterData =
                "?searchText=${searchController.text.trim()}&eventDate&eventCategoryId=&eventTypeId=$eventTypeId&cityName=";
          } else {
            filterData =
                "?searchText=${searchController.text.trim()}&eventDate&eventCategoryId=${catId.id!.toInt().toString()}&eventTypeId=$eventTypeId&cityName=";
          }
        } else {
          if (catId.id?.toInt() == 1) {
            filterData =
                "?searchText=${searchController.text.trim()}&eventDate&eventCategoryId=&eventTypeId=$eventTypeId&cityName=$selectedLocation";
          } else {
            filterData =
                "?searchText=${searchController.text.trim()}&eventDate&eventCategoryId=${catId.id!.toInt().toString()}&eventTypeId=$eventTypeId&cityName=$selectedLocation";
          }
        }

        var res = await ApiService().getEventSearch(Get.context!, filterData);
        if (res != null && res is List) {
          addSeeAllData(res);
        } else {
          customSnackBar('error'.tr, 'somethingWentWrong'.tr);
        }
      }
    });
  }

  updateDistanceValues(values) {
    distanceValue = values;
    update();
  }

  resetHomeFilter() {
    filterCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    filterCategoryList?[0].isSelected = true;
    seeAllCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    seeAllCategoryList?[0].isSelected = true;

    distanceValue = 100.0;
    selectedCity = null;
    update();
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
