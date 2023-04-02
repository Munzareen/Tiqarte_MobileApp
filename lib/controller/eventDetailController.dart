import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/common.dart';

class EventDetailController extends GetxController {
  final scrollController = ScrollController();

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
