import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/model/EventDetailModel.dart';
import 'package:tiqarte/model/RelatedEventModel.dart';

class EventDetailController extends GetxController {
  final scrollController = ScrollController();
  EventDetailModel eventDetailModel = EventDetailModel();

  List<RelatedEventModel>? relatedEventModelList = [];

  addEventDetail(dynamic data, String eventId) async {
    eventDetailModel = EventDetailModel.fromJson(data);
    if (eventDetailModel.event!.location != null) {
      double lat =
          double.parse(eventDetailModel.event!.location!.split(",").first);
      double long =
          double.parse(eventDetailModel.event!.location!.split(",").last);

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      Placemark place = placemarks[0];
      eventDetailModel.event!.locationName =
          "${place.street}, ${place.subAdministrativeArea}, ${place.country}";
    }

    update();
    var res = await ApiService()
        .getRelatedEvents(eventDetailModel.event!.eventId.toString());
    if (res != null && res is List) {
      relatedEventModelList = relatedEventModelFromJson(res);
      if (relatedEventModelList!.isNotEmpty) {
        for (int i = 0; i < relatedEventModelList!.length; i++) {
          if (relatedEventModelList![i].eventId?.toInt() ==
              int.parse(eventId)) {
            relatedEventModelList?.removeAt(i);
          }
        }
      }

      update();
    }
  }

  addRelatedEvents(dynamic data) {}

  Color appBarIconColor = Colors.white;

  @override
  void onInit() {
    super.onInit();

    if (!isDarkTheme.value) {
      scrollController.addListener(() {
        if (scrollController.offset >= 300) {
          changeColor(Colors.black);
        } else {
          changeColor(Colors.white);
        }
      });
    }
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
}
