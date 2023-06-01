import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/model/ExploreModel.dart';

class ExploreController extends GetxController {
  List<ExploreModel>? exploreList;
  List<MarkerData> eventMarkers = [];
  Set<Marker> markers = {};

  ExploreModel? selectedEventData;

  bool mapType = false;
  bool eventDetailShow = false;
  String? latitude;
  String? longitude;

  String? myAddress;

  BitmapDescriptor? customMarkerPin, myMarkerPin;

  Future<void> markerPin() async {
    customMarkerPin = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      eventMarker,
    );
    myMarkerPin = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      myMarker,
    );
  }

// Future<void> _createCustomMarker() async {
//   final imageUrl = 'https://example.com/image.png'; // Replace with your image URL
//   final bytes = await _getBytesFromUrl(imageUrl);
//   eventMarker = BitmapDescriptor.fromBytes(bytes);
// }

// Future<Uint8List> _getBytesFromUrl(String url) async {
//   final response = await http.get(Uri.parse(url));
//   return response.bodyBytes;
// }

  addExploreListData(List data) {
    exploreList = exploreModelFromJson(data);
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId("null"),
        position: convertCoordinatesToLatLng("$latitude, $longitude"),
        infoWindow: InfoWindow(
          title: "You",
        ),
        icon: myMarkerPin!,
        onTap: () {}));
    if (exploreList!.isNotEmpty) {
      for (int i = 0; i < exploreList!.length; i++) {
        if (exploreList![i].location != null) {
          markers.add(
            Marker(
                markerId: MarkerId(exploreList![i].eventId.toString()),
                position: convertCoordinatesToLatLng(
                    exploreList![i].location.toString()),
                infoWindow: InfoWindow(
                  title: exploreList![i].name.toString(),
                ),
                icon: customMarkerPin!,
                onTap: () {
                  onMarkerTapped(
                      exploreList![i].eventId.toString(), exploreList![i]);
                }),
          );
        }
      }
    }
    update();
  }

  onMarkerTapped(String markerId, ExploreModel eventData) {
    // bool marker =
    //     eventMarkers.firstWhere((element) => element.markerId == markerId);
    // if (marker == eventData.eventId.toString())
    if (eventDetailShow &&
        int.parse(selectedEventData!.eventId.toString()) ==
            int.parse(markerId.toString())) {
      eventDetailShow = false;
    } else {
      eventDetailShow = true;
      selectedEventData = eventData;
    }

    update();
  }

  LatLng convertCoordinatesToLatLng(String coordinates) {
    List<String> coordinateList = coordinates.split(", ");
    double latitude = double.parse(coordinateList[0]);
    double longitude = double.parse(coordinateList[1]);
    return LatLng(latitude, longitude);
  }

  changeMapType(bool value) {
    mapType = value;
    update();
  }

  showUnshowEventDetail(bool value) {
    eventDetailShow = value;
    update();
  }

  @override
  void onInit() {
    markerPin();

    super.onInit();
  }
}

class MarkerData {
  final LatLng position;
  final String markerId;
  final BitmapDescriptor icon;

  MarkerData(
      {required this.position, required this.markerId, required this.icon});
}
