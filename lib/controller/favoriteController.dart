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
  final searchController = TextEditingController();

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
    searchController.dispose();
    super.onClose();
  }

  addFavoriteData(List res) async {
    favoriteList = favoriteModelFromJson(res);
    favoriteListAll = [...favoriteList!];

    if (favCategoryList == null) {
      var res = await ApiService().getCategories();
      if (res != null && res is List) {
        favCategoryList = categoryModelFromJson(res);

        favCategoryList?[0].isSelected = true;
      }
    }

    update();
  }

  onSearchClose(TextEditingController textEditingController) {
    isSearchFav = false;
    textEditingController.clear();
    favoriteList = [...favoriteListAll!];

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

    if (favCategoryList![index].id == null) {
      favoriteList = [...favoriteListAll!];
    } else {
      favoriteList = [...favoriteListAll!];

      favoriteList?.removeWhere((element) =>
          element.catagoryId != null &&
          int.parse(element.catagoryId.toString()) !=
              favCategoryList![index].id!.toInt());
    }
    if (searchController.text.trim().isNotEmpty) {
      searchEvent(searchController.text);
    }

    update();
  }

  searchEvent(String query) {
    CategoryModel cat =
        favCategoryList!.firstWhere((element) => element.isSelected == true);

    favoriteList = [...favoriteListAll!];
    favoriteList?.removeWhere((element) =>
        element.catagoryId != null && element.catagoryId != cat.id);
    final suggestion = favoriteList!.where((element) {
      final eventName = element.name!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    favoriteList = suggestion;

    update();
  }
}
