import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/favoriteController.dart';
import 'package:tiqarte/controller/seeAllEventController.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/model/CategoryModel.dart';
import 'package:tiqarte/model/HomeDataModel.dart';
import 'package:tiqarte/model/NewsModel.dart';

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
  List<CategoryModel>? homeFilterCategoryList;

  List<NewsModel> newsList = [];
  List<NewsModel> newsListAll = [];

  double distanceValue = 100.0;

  List<String> cityListForFilter = [];
  String? selectedCity;

  addHomeData(dynamic data) async {
    homeDataModel = HomeDataModel.fromJson(data);
    featuredEventList = homeDataModel.featuredEvents;
    upcomingEventList = homeDataModel.upComingEvents;
    shopList = homeDataModel.shop;
    featuredEventListAll = [...homeDataModel.featuredEvents!];
    upcomingEventListAll = [...homeDataModel.upComingEvents!];
    shopListAll = [...shopList!];

    var res = await ApiService().getCategories();
    if (res != null && res is List) {
      final _favoriteController = Get.put(FavoriteController());
      final _seeAllEventController = Get.put(SeeAllEventController());

      _favoriteController.favCategoryList = categoryModelFromJson(res);
      _favoriteController.favCategoryList?[0].isSelected = true;

      _seeAllEventController.seeAllCategoryList = categoryModelFromJson(res);
      _seeAllEventController.seeAllCategoryList?[0].isSelected = true;

      upcomingCategoryList = categoryModelFromJson(res);
      upcomingCategoryList?[0].isSelected = true;

      shopCategoryList = categoryModelFromJson(res);
      shopCategoryList?[0].isSelected = true;

      homeFilterCategoryList = categoryModelFromJson(res);
      homeFilterCategoryList?[0].isSelected = true;

      update();
    } else if (res != null && res is String) {
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  addHomeDataForFilter(dynamic data) async {
    homeDataModel = HomeDataModel.fromJson(data);
    featuredEventList = homeDataModel.featuredEvents;
    upcomingEventList = homeDataModel.upComingEvents;
    shopList = homeDataModel.shop;
    featuredEventListAll?.clear();
    upcomingEventListAll?.clear();
    shopListAll?.clear();
    featuredEventListAll = [...homeDataModel.featuredEvents!];
    upcomingEventListAll = [...homeDataModel.upComingEvents!];
    shopListAll = [...shopList!];

    update();
  }

  selectUpcomingEventCategory(int index) {
    upcomingCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    upcomingCategoryList?[index].isSelected = true;

    upcomingEventList = [...upcomingEventListAll!];
    if (!upcomingCategoryList![index]
        .catagoryName!
        .toUpperCase()
        .contains("ALL")) {
      upcomingEventList?.removeWhere((element) =>
          element.catagoryId != null &&
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

    shopList = [...shopListAll!];
    if (!shopCategoryList![index].catagoryName!.toUpperCase().contains("ALL")) {
      shopList?.removeWhere((element) =>
          element.catagoryId != null &&
          int.parse(element.catagoryId.toString()) !=
              shopCategoryList![index].id!.toInt());
    }

    if (searchController.text.trim().isNotEmpty) {
      homeSearch(searchController.text);
    }

    update();
  }

  homeSearch(String query) {
    if (featuredEventList != null) {
      // for featured
      featuredEventList = [...featuredEventListAll!];
      final featuredList = featuredEventList?.where((element) {
        final eventName = element.name!.toLowerCase();
        final city = element.city!.toLowerCase();

        final eventDate =
            splitDateTimeWithoutYear(element.eventDate.toString());
        final input = query.toLowerCase().trim();
        final lwrDate = convertMonthToLowerCase(eventDate);
        final containsQuery = lwrDate.contains(input);

        return eventName.contains(input) ||
            city.contains(input) ||
            containsQuery;
      }).toList();
      featuredEventList = featuredList;

      // for upcoming
      CategoryModel upcomingCat = upcomingCategoryList!
          .firstWhere((element) => element.isSelected == true);
      upcomingEventList = [...upcomingEventListAll!];
      if (!upcomingCat.catagoryName!.toUpperCase().contains("ALL")) {
        upcomingEventList?.removeWhere((element) =>
            element.catagoryId != null && element.catagoryId != upcomingCat.id);
      }

      final upcomingList = upcomingEventList?.where((element) {
        final eventName = element.name!.toLowerCase();
        final city = element.city!.toLowerCase();

        final eventDate =
            splitDateTimeWithoutYear(element.eventDate.toString());
        final input = query.toLowerCase().trim();
        final lwrDate = convertMonthToLowerCase(eventDate);
        final containsQuery = lwrDate.contains(input);

        return eventName.contains(input) ||
            city.contains(input) ||
            containsQuery;
      }).toList();
      upcomingEventList = upcomingList;

      // for shop
      CategoryModel shopCat =
          shopCategoryList!.firstWhere((element) => element.isSelected == true);
      shopList = [...shopListAll!];

      if (!shopCat.catagoryName!.toUpperCase().contains("ALL")) {
        shopList?.removeWhere((element) =>
            element.catagoryId != null && element.catagoryId != shopCat.id);
      }
      final shop = shopList?.where((element) {
        final eventName = element.productName!.toLowerCase();
        final productFor = element.productFor?.toLowerCase() ?? '';
        final price = element.price?.toDouble().toString() ?? '';

        final input = query.toLowerCase().trim();
        return eventName.contains(input) ||
            productFor.contains(input) ||
            price.contains(input);
      }).toList();
      shopList = shop;

      // for news
      newsList = [...newsListAll];
      final list = newsList.where((element) {
        final title = element.title!.toLowerCase();
        final scheduled =
            splitDateForNews(element.scheduled?.toLowerCase() ?? '');
        final input = query.toLowerCase().trim();
        final lwrschedule = convertMonthToLowerCase(scheduled);
        final containsQuery = lwrschedule.contains(input);

        return title.contains(input) || containsQuery;
      }).toList();
      newsList = list;

      update();
    }
  }

  String convertMonthToLowerCase(String inputDate) {
    return inputDate.replaceAllMapped(
      RegExp(r'\b(\w{3})\b'),
      (match) => match.group(0)!.toLowerCase(),
    );
  }

//   homeSearch(String query) {
//     if (featuredEventList != null) {
//       //for featured
//       featuredEventList = [...featuredEventListAll!];
//       final featuredList = featuredEventList?.where((element) {
//         final eventName = element.name!.toLowerCase();
//         final input = query.toLowerCase();
//         return eventName.contains(input);
//       }).toList();
//       featuredEventList = featuredList;

// // for upcoming
//       CategoryModel upcomingCat = upcomingCategoryList!
//           .firstWhere((element) => element.isSelected == true);
//       upcomingEventList = [...upcomingEventListAll!];
//       if (!upcomingCat.catagoryName!.toUpperCase().contains("ALL")) {
//         upcomingEventList?.removeWhere((element) =>
//             element.catagoryId != null && element.catagoryId != upcomingCat.id);
//       }

//       final upcomingList = upcomingEventList?.where((element) {
//         final eventName = element.name!.toLowerCase();
//         final input = query.toLowerCase();
//         return eventName.contains(input);
//       }).toList();
//       upcomingEventList = upcomingList;

// //for shop

//       CategoryModel shopCat =
//           shopCategoryList!.firstWhere((element) => element.isSelected == true);

//       shopList = [...shopListAll!];

//       if (!shopCat.catagoryName!.toUpperCase().contains("ALL")) {
//         shopList?.removeWhere((element) =>
//             element.catagoryId != null && element.catagoryId != shopCat.id);
//       }
//       final shop = shopList?.where((element) {
//         final eventName = element.productName!.toLowerCase();
//         final input = query.toLowerCase();
//         return eventName.contains(input);
//       }).toList();
//       shopList = shop;

//       //for news
//       newsList = [...newsListAll];
//       final list = newsList.where((element) {
//         final title = element.title!.toLowerCase();
//         final input = query.toLowerCase();
//         return title.contains(input);
//       }).toList();
//       newsList = list;

//       update();
//     }
//   }

  addNews(List data) {
    newsList = newsModelFromJson(data);
    newsListAll = [...newsList];
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  updateDistanceValues(values) {
    distanceValue = values;
    update();
  }

  resetHomeFilter() {
    homeFilterCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    homeFilterCategoryList?[0].isSelected = true;

    distanceValue = 100.0;
    selectedCity = null;
    update();
  }
}
