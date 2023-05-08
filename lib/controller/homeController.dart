import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/favoriteController.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/model/CategoryModel.dart';
import 'package:tiqarte/model/HomeDataModel.dart';

class HomeController extends GetxController {
  HomeDataModel homeDataModel = HomeDataModel();
  List<CategoryModel>? upcomingCategoryList;
  List<CategoryModel>? shopCategoryList;

  addHomeData(dynamic data) async {
    homeDataModel = HomeDataModel.fromJson(data);
    var res = await ApiService().getCategories();
    if (res != null && res is List) {
      final _favoriteController = Get.put(FavoriteController());
      _favoriteController.favCategoryList = categoryModelFromJson(res);
      upcomingCategoryList = categoryModelFromJson(res);
      shopCategoryList = categoryModelFromJson(res);

      update();
    } else if (res != null && res is String) {
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  selectUpcomingEventCategory(int index) {
    upcomingCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    upcomingCategoryList?[index].isSelected = true;
    update();
  }

  selectShopCategory(int index) {
    shopCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    shopCategoryList?[index].isSelected = true;
    update();
  }

  List eventList = [
    {
      "id": "1",
      "name": "International Concert",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
    },
    {
      "id": "2",
      "name": "Jazz Music Festival",
      "date": "Tue, Dec 19 • 19.00 - 22.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
    },
    {
      "id": "3",
      "name": "DJ Music Competition",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "Central Park, Ne...",
      "isFavorite": false,
    },
    {
      "id": "4",
      "name": "National Music Fest",
      "date": "Sun, Dec 16 • 11.00 - 13.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
    },
    {
      "id": "5",
      "name": "Art Workshops",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
    },
    {
      "id": "6",
      "name": "Tech Seminar",
      "date": "Sat, Dec 22 • 10.00 - 12.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
    },
  ];

  List favEventList = [];
  List favAllEventList = [];
}
