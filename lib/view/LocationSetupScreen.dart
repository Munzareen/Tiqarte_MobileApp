import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/MainScreen.dart';

class LocationSetupScreen extends StatefulWidget {
  final String lat;
  final String long;

  const LocationSetupScreen({super.key, required this.lat, required this.long});

  @override
  State<LocationSetupScreen> createState() => _LocationSetupScreenState();
}

class _LocationSetupScreenState extends State<LocationSetupScreen> {
  Set<Marker>? markers;

  double? latitude;
  double? longitude;
  GoogleMapController? _controller;

  String address = '';

  @override
  void initState() {
    super.initState();
    latitude = double.parse(widget.lat);
    longitude = double.parse(widget.long);
    getLocationName(latitude!, longitude!);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  getMarker() {
    Marker _marker = Marker(
      markerId: MarkerId('myLocation'),
      position: LatLng(latitude!, longitude!),
      draggable: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    markers = {_marker};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: kSecondBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'setYourLocation'.tr,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
            )),
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Column(
          children: [
            Container(
              height: 0.55.sh,
              child: latitude == null
                  ? Center(
                      child: spinkit,
                    )
                  : GoogleMap(
                      mapType: MapType.normal, //  mapType: MapType.satellite,

                      markers: Set<Marker>.of(
                        <Marker>[
                          Marker(
                              draggable: true,
                              markerId: MarkerId("my Location"),
                              position: LatLng(latitude!, longitude!),
                              icon: BitmapDescriptor.defaultMarker,
                              infoWindow: const InfoWindow(
                                title: 'You',
                              ),
                              onDragEnd: ((newPosition) {
                                setState(() {
                                  latitude = newPosition.latitude;
                                  longitude = newPosition.longitude;
                                  getLocationName(latitude!, longitude!);
                                });
                              }))
                        ],
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude!, longitude!),
                        zoom: 12,
                      ),
                    ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      10.verticalSpace,
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: kDisabledColor.withOpacity(0.6)),
                      ),
                      10.verticalSpace,
                      Text(
                        'location'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      10.verticalSpace,
                      Container(
                        //  height: 200,
                        padding: EdgeInsets.all(18.0),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: kDisabledColor.withOpacity(0.2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 300,
                              child: Text(address,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            Icon(
                              Icons.location_on,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      Divider(),
                      10.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          customAlertDialogWithSpinkit(
                              context,
                              backgroundLogo,
                              Icons.person,
                              'congratulations'.tr,
                              'locationSetupDialogSubString'.tr);
                          Timer(Duration(seconds: 2), () {
                            Get.back();

                            Get.offAll(() => MainScreen(),
                                transition: Transition.rightToLeft);
                          });
                        },
                        child: customButton('continueButton'.tr, kPrimaryColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLocationName(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    setState(() {
      address = "${place.subLocality}, ${place.locality}, ${place.country}";
    });
  }
}
