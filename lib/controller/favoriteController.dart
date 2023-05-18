import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/model/CategoryModel.dart';
import 'package:tiqarte/model/FavoriteModel.dart';

class FavoriteController extends GetxController {
  bool isSearchFav = false;
  bool isListSelectedFav = true;
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final searchFocusNode = FocusNode();
  List<CategoryModel>? favCategoryList;

  List<FavoriteModel>? favoriteList;

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
    super.onClose();
  }

  addFavoriteData(List res) {
    favoriteList = favoriteModelFromJson(res);

    update();
  }

  favoriteOnSearchClose(TextEditingController textEditingController) {
    isSearchFav = false;
    textEditingController.clear();
    favoriteList = null;
    update();
  }

  favoriteOnSearch() {
    isSearchFav = true;
    update();
  }

  favoriteListGridSelect(bool value) {
    isListSelectedFav = value;
    update();
  }

  selectFavCategory(int index) {
    favCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    favCategoryList?[index].isSelected = true;
    update();
  }
}
