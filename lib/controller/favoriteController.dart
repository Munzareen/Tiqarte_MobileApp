import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
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
  List<FavoriteModel>? favoriteListAll;

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

  addFavoriteData(List res) async {
    favoriteList = favoriteModelFromJson(res);
    favoriteListAll = favoriteModelFromJson(res);

    if (favCategoryList == null) {
      var res = await ApiService().getCategories();
      if (res != null && res is List) {
        favCategoryList = categoryModelFromJson(res);
        favCategoryList?.insert(
            0, CategoryModel.fromJson({"Id": null, "CatagoryName": "all"}));
        favCategoryList?[0].isSelected = true;
      }
    }

    update();
  }

  favoriteOnSearchClose(TextEditingController textEditingController) {
    isSearchFav = false;
    textEditingController.clear();
    favoriteList = favoriteListAll;

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

  searchEvent(String query) {
    favoriteList = favoriteListAll;
    final suggestion = favoriteList!.where((element) {
      final eventName = element.name!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    favoriteList = suggestion;
    update();
  }
}
