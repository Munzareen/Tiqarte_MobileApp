import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/model/TicketModel.dart';

class TicketController extends GetxController {
  List<TicketModel>? upcomingTicketList;
  List<TicketModel> upcomingTicketListAll = [];
  List<TicketModel> completedTicketList = [];
  List<TicketModel> completedTicketListAll = [];
  List<TicketModel> cancelledTicketList = [];
  List<TicketModel> cancelledTicketListAll = [];

  bool isSearch = false;
  double? rating;

  final searchController = TextEditingController();
  final reviewControlller = TextEditingController();

  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final searchFocusNode = FocusNode();

  addTicketData(List<TicketModel> data) {
    upcomingTicketList = [];
    upcomingTicketListAll = [];
    completedTicketList = [];
    completedTicketListAll = [];
    cancelledTicketList = [];
    cancelledTicketListAll = [];
    if (data.isNotEmpty)
      data.forEach((element) {
        if (element.status!.toUpperCase().contains("UPCOMING")) {
          upcomingTicketList?.add(element);
        } else if (element.status!.toUpperCase().contains("COMPLETE")) {
          completedTicketList.add(element);
        } else if (element.status!.toUpperCase().contains("CANCELLED")) {
          cancelledTicketList.add(element);
        }
      });

    upcomingTicketListAll = [...upcomingTicketList!];
    completedTicketListAll = [...completedTicketList];
    cancelledTicketListAll = [...cancelledTicketList];

    update();
  }

  onSearchClose(TextEditingController textEditingController) {
    isSearch = false;
    textEditingController.clear();
    upcomingTicketList = [...upcomingTicketListAll];
    completedTicketList = [...completedTicketListAll];
    cancelledTicketList = [...cancelledTicketListAll];
    update();
  }

  onSearchTap() {
    isSearch = true;
    update();
  }

  onSearch(String query) {
    upcomingTicketList = [...upcomingTicketListAll];
    completedTicketList = [...completedTicketListAll];
    cancelledTicketList = [...cancelledTicketListAll];

    final upcomingSuggestion = upcomingTicketList?.where((element) {
      final eventName = element.eventName!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();

    final completedSuggestion = completedTicketList.where((element) {
      final eventName = element.eventName!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();

    final cancelledSuggestion = cancelledTicketList.where((element) {
      final eventName = element.eventName!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    upcomingTicketList = upcomingSuggestion;
    completedTicketList = completedSuggestion;
    cancelledTicketList = cancelledSuggestion;

    update();
  }

  @override
  void onInit() {
    super.onInit();
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
  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.onClose();
  }
}
