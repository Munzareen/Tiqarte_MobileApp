import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/model/ContactUsModel.dart';
import 'package:tiqarte/model/FAQModel.dart';
import 'package:tiqarte/model/FAQTypeModel.dart';

class HelpCenterController extends GetxController {
  List<FAQTypeModel>? fAQTypeList;
  List<FAQModel>? faqModelList;
  List<FAQModel>? faqModelListAll;

  ContactUsModel? contactUsModel;

  final searchController = TextEditingController();
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final searchFocusNode = FocusNode();

  addFAQTypes(List data) {
    //FAQTypeModel ff = FAQTypeModel.fromJson(data as List<String>);
    // List<String> hcList = [];
    // data.forEach((element) {
    //   hcList.add(element);
    // });

    fAQTypeList = categoryModelFromJson(data);
    fAQTypeList?[0].isSelected = true;
    update();
  }

  addFAQData(List data) {
    faqModelList = fAQModelFromJson(data);
    faqModelListAll = [...faqModelList!];
    update();
  }

  selectFAQType(int index) {
    fAQTypeList?.forEach((element) {
      element.isSelected = false;
    });
    fAQTypeList?[index].isSelected = true;

    if (fAQTypeList![index].name?.toUpperCase() == "ALL") {
      faqModelList = [...faqModelListAll!];
    } else {
      faqModelList = [...faqModelListAll!];

      faqModelList?.removeWhere((element) =>
          element.fAQType?.toUpperCase() !=
          fAQTypeList![index].name?.toUpperCase());
    }
    if (searchController.text.trim().isNotEmpty) {
      searchFAQ(searchController.text);
    }

    update();
  }

  searchFAQ(String query) {
    FAQTypeModel cat =
        fAQTypeList!.firstWhere((element) => element.isSelected == true);

    faqModelList = [...faqModelListAll!];
    if (cat.name?.toUpperCase() != "ALL")
      faqModelList?.removeWhere((element) =>
          element.fAQType?.toUpperCase() != cat.name?.toUpperCase());
    final suggestion = faqModelList!.where((element) {
      final eventName = element.fAQQuestion!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    faqModelList = suggestion;

    update();
  }

  addContactUsData(dynamic data) {
    contactUsModel = ContactUsModel.fromJson(data);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        filledColorSearch = kPrimaryColor.withOpacity(0.2);
        iconColorSearch = kPrimaryColor;
      } else {
        filledColorSearch = kDisabledColor.withOpacity(0.4);
        iconColorSearch = kDisabledColor;
      }
      update();
    });
  }
}
