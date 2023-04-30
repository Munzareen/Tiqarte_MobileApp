import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/model/EventDetailModel.dart';

class EventDetailController extends GetxController {
  final scrollController = ScrollController();
  EventDetailModel eventDetailModel = EventDetailModel();

  addEventDetail(dynamic data) async {
    eventDetailModel = EventDetailModel.fromJson(data);
    double lat = double.parse(eventDetailModel.location!.split(",").first);
    double long = double.parse(eventDetailModel.location!.split(",").last);

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    eventDetailModel.location =
        "${place.street}, ${place.subAdministrativeArea}, ${place.country}";

    update();
  }

  bool isFollow = false;
  Color appBarIconColor = Colors.white;

  @override
  void onInit() {
    if (!isDarkTheme.value) {
      scrollController.addListener(() {
        if (scrollController.offset >= 300) {
          changeColor(Colors.black);
        } else {
          changeColor(Colors.white);
        }
      });
    }

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  changeColor(Color color) {
    appBarIconColor = color;
    update();
  }

  followUnFollow() {
    isFollow = !isFollow;
    update();
  }
}
