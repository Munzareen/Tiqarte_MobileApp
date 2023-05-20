import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/model/EventDetailModel.dart';

class GoingController extends GetxController {
  List<Customer>? customerList;
  List<Customer>? customerListAll;
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final searchFocusNode = FocusNode();
  bool isSearch = false;

  addCustomers(List<Customer> customers) {
    customerList = customers;
    customerListAll = customers;
    update();
  }

  void searchList(String query) {
    customerList = customerListAll;
    final suggestion = customerList?.where((element) {
      final eventName = element.name!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    customerList = suggestion;
    update();
  }

  onnSearch(bool value) {
    isSearch = value;
    update();
  }

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
}
