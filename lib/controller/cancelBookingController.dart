import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/colors.dart';

class CancelBookingController extends GetxController {
  int selectedValue = -1;
  int otherSelectedValue = -1;
  bool otherReasonEnabled = false;

  final otherReasonController = TextEditingController();
  Color filledColorOther = kDisabledColor.withOpacity(0.4);
  final otherReasonFocusNode = FocusNode();

  List<Map> definedReasons = [
    {
      "value": 1,
      "name": 'IHaveAnotherEventSoItCollides'.tr,
      "isSelected": false
    },
    {"value": 2, "name": 'imSickCantCome'.tr, "isSelected": false},
    {"value": 3, "name": 'iHaveAnUrgentNeed'.tr, "isSelected": false},
    {"value": 4, "name": 'iHaveNoTransportationToCome'.tr, "isSelected": false},
    {"value": 5, "name": 'iHaveNoFriendsToCome'.tr, "isSelected": false},
    {"value": 6, "name": 'iWantToBookAnotherEvent'.tr, "isSelected": false},
    {"value": 7, "name": 'iJustWantToCancel'.tr, "isSelected": false},
  ];

  changeSelectedValue(int value, int index) {
    selectedValue = value;
    otherSelectedValue = -1;
    otherReasonEnabled = false;
    definedReasons.forEach((element) {
      element['isSelected'] = false;
    });
    definedReasons[index]['isSelected'] = true;
    otherReasonController.clear();
    update();
  }

  changeOtherSelectedValue(int value) {
    otherSelectedValue = value;
    selectedValue = -1;
    otherReasonEnabled = true;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    otherReasonFocusNode.addListener(() {
      if (otherReasonFocusNode.hasFocus) {
        filledColorOther = kPrimaryColor.withOpacity(0.2);
      } else {
        filledColorOther = kDisabledColor.withOpacity(0.4);
      }
      update();
    });
  }
}
