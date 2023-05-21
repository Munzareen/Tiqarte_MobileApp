import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/favoriteController.dart';
import 'package:tiqarte/controller/seeAllEventController.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/model/CategoryModel.dart';
import 'package:tiqarte/model/HomeDataModel.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();

  HomeDataModel homeDataModel = HomeDataModel();
  List<Event>? featuredEventList;
  List<Event>? upcomingEventList;
  List<Shop>? shopList;
  List<Event>? featuredEventListAll;
  List<Event>? upcomingEventListAll;
  List<Shop>? shopListAll;

  List<CategoryModel>? upcomingCategoryList;
  List<CategoryModel>? shopCategoryList;

  addHomeData(dynamic data) async {
    homeDataModel = HomeDataModel.fromJson(data);
    featuredEventList = homeDataModel.featuredEvents;
    upcomingEventList = homeDataModel.upComingEvents;
    shopList = homeDataModel.shop;
    featuredEventListAll = [...homeDataModel.featuredEvents!];
    upcomingEventListAll = [...homeDataModel.upComingEvents!];
    shopListAll = [...homeDataModel.shop!];

    var res = await ApiService().getCategories();
    if (res != null && res is List) {
      final _favoriteController = Get.put(FavoriteController());
      final _seeAllEventController = Get.put(SeeAllEventController());

      _favoriteController.favCategoryList = categoryModelFromJson(res);
      _favoriteController.favCategoryList?.insert(
          0, CategoryModel.fromJson({"Id": null, "CatagoryName": "all"}));
      _favoriteController.favCategoryList?[0].isSelected = true;

      _seeAllEventController.seeAllCategoryList = categoryModelFromJson(res);
      _seeAllEventController.seeAllCategoryList?.insert(
          0, CategoryModel.fromJson({"Id": null, "CatagoryName": "all"}));
      _seeAllEventController.seeAllCategoryList?[0].isSelected = true;

      upcomingCategoryList = categoryModelFromJson(res);

      upcomingCategoryList?.insert(
          0, CategoryModel.fromJson({"Id": null, "CatagoryName": "all"}));
      upcomingCategoryList?[0].isSelected = true;

      shopCategoryList = categoryModelFromJson(res);
      shopCategoryList?.insert(
          0, CategoryModel.fromJson({"Id": null, "CatagoryName": "all"}));
      shopCategoryList?[0].isSelected = true;

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
    if (upcomingCategoryList![index].id == null) {
      upcomingEventList = [...upcomingEventListAll!];
    } else {
      upcomingEventList = [...upcomingEventListAll!];

      upcomingEventList?.removeWhere((element) =>
          int.parse(element.catagoryId.toString()) !=
          upcomingCategoryList![index].id!.toInt());
    }

    if (searchController.text.trim().isNotEmpty) {
      homeSearch(searchController.text);
    }

    update();
  }

  selectShopCategory(int index) {
    shopCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    shopCategoryList?[index].isSelected = true;

    // if (shopCategoryList![index].id == null) {
    //   shopList = [...shopListAll!];
    // } else {
    //   shopList = [...shopListAll!];

    //   shopList?.removeWhere((element) =>
    //       int.parse(element.catagoryId.toString()) !=
    //       shopCategoryList![index].id!.toInt());

    // }
    update();
  }

  homeSearch(String query) {
    if (featuredEventList != null) {
      //for featured
      featuredEventList = [...featuredEventListAll!];
      final featuredList = featuredEventList?.where((element) {
        final eventName = element.name!.toLowerCase();
        final input = query.toLowerCase();
        return eventName.contains(input);
      }).toList();
      featuredEventList = featuredList;

// for upcoming
      CategoryModel upcomingCat = upcomingCategoryList!
          .firstWhere((element) => element.isSelected == true);
      if (upcomingCat.id == null) {
        upcomingEventList = [...upcomingEventListAll!];

        final upcomingList = upcomingEventList?.where((element) {
          final eventName = element.name!.toLowerCase();
          final input = query.toLowerCase();
          return eventName.contains(input);
        }).toList();
        upcomingEventList = upcomingList;
      } else {
        upcomingEventList = [...upcomingEventListAll!];
        upcomingEventList
            ?.removeWhere((element) => element.catagoryId != upcomingCat.id);

        final upcomingList = upcomingEventList?.where((element) {
          final eventName = element.name!.toLowerCase();
          final input = query.toLowerCase();
          return eventName.contains(input);
        }).toList();
        upcomingEventList = upcomingList;
      }
//for shop
      shopList = [...shopListAll!];
      final shop = shopList?.where((element) {
        final eventName = element.name!.toLowerCase();
        final input = query.toLowerCase();
        return eventName.contains(input);
      }).toList();
      shopList = shop;

      update();
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
