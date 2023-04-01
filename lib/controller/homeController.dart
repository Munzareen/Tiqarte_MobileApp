import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  bool isSearchFav = false;
  bool isListSelectedFav = true;

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

  addRemoveToFavorite(int index, dynamic data) {
    if (data['isFavorite'] == false) {
      var target =
          eventList.firstWhere((element) => element['id'] == data['id']);
      if (target != null) {
        target["isFavorite"] = true;
      }
      favEventList.add(data);
      favAllEventList.add(data);
    } else {
      var target =
          eventList.firstWhere((element) => element['id'] == data['id']);
      if (target != null) {
        target["isFavorite"] = false;
      }
      favEventList.removeWhere((element) => element['id'] == data['id']);
      favAllEventList.removeWhere((element) => element['id'] == data['id']);
    }
    update();
  }

  searchEvent(String query) {
    favEventList = favAllEventList;
    final suggestion = favEventList.where((element) {
      final eventName = element['name']!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    favEventList = suggestion;
    update();
  }

  favoriteOnSearchClose(TextEditingController textEditingController) {
    isSearchFav = false;
    textEditingController.clear();
    favEventList = favAllEventList;
    update();
  }

  favoriteOnSearch() {
    isSearchFav = true;
    update();
  }

  favoriteListGridSelect(bool value) {
    isListSelectedFav = value;
    update();
  }
}
