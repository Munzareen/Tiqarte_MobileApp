import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool mapType = false;
  String? latitude;
  String? longitude;
  Position? position;
  LocationPermission? permission;
  GoogleMapController? _controller;

  @override
  void initState() {
    // checkGPSPermission();
    checkLocationPermission();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondBackgroundColor,
      body: SafeArea(
          child: Container(
        height: 1.sh,
        width: 1.sw,
        color: latitude == null
            ? kPrimaryColor.withOpacity(0.8)
            : Colors.transparent,
        child: latitude == null
            ? Container(
                child: Center(child: spinkit
                    // Text(
                    //   enableLocation,
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(color: Colors.white, fontSize: 30),
                    // ),
                    ),
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      mapType: !mapType ? MapType.normal : MapType.satellite,
                      markers: Set<Marker>.of(
                        <Marker>[
                          Marker(
                            draggable: true,
                            markerId: MarkerId("My Location"),
                            position: LatLng(double.parse(latitude!),
                                double.parse(longitude!)),
                            icon: BitmapDescriptor.defaultMarker,
                            infoWindow: const InfoWindow(
                              title: 'Me',
                            ),
                          ),
                          Marker(
                            draggable: true,
                            markerId: MarkerId("My Location"),
                            position: LatLng(double.parse(latitude!),
                                double.parse(longitude!)),
                            icon: BitmapDescriptor.defaultMarker,
                            infoWindow: const InfoWindow(
                              title: 'Event',
                            ),
                            // onDragEnd: ((newPosition) {
                            //   setState(() {
                            //     latitude = newPosition.latitude;
                            //     longitude = newPosition.longitude;
                            //     getLocationName(latitude!, longitude!);
                            //   });
                            // })
                          )
                        ],
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            double.parse(latitude!), double.parse(longitude!)),
                        zoom: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 0,
                    left: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                    Icon(
                                      Icons.location_on,
                                      color: kPrimaryColor,
                                      size: 25,
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      "Location (within 10 km)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ])),
                              10.verticalSpace,
                              Text(
                                "New York, United States",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                mapType = !mapType;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10.0),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    change,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 0,
                    left: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customCardImage(eventImage, 110.h, 100.h),
                          8.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  "National Music Festival",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              8.verticalSpace,
                              FittedBox(
                                child: Text(
                                  "Mon, Dec 24 • 18.00 - 23.00 PM",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: kPrimaryColor),
                                ),
                              ),
                              8.verticalSpace,
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: kPrimaryColor,
                                      size: 25,
                                    ),
                                    5.horizontalSpace,
                                    Text(
                                      "Grand Park, New York",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff616161)),
                                    ),
                                    5.horizontalSpace,
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        favoriteIconSelected,
                                        color: kPrimaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      )),
    );
  }

  checkLocationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        getLatLng();
      } else if (permission == LocationPermission.deniedForever) {
        customAlertDialogForPermission(
            context,
            backgroundLogo,
            Icons.location_on,
            enableLocation,
            locationDialogSubString,
            enableLocation,
            cancel, () {
          openAppSettings().then((value) {
            //checkLocationPermission();
          });
          Get.back();
        });
      }
    } else if (permission == LocationPermission.deniedForever) {
      customAlertDialogForPermission(context, backgroundLogo, Icons.location_on,
          enableLocation, locationDialogSubString, enableLocation, cancel, () {
        openAppSettings().then((value) {
          //checkLocationPermission();
        });
        Get.back();
      });
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      getLatLng();
    }
  }

  getLatLng() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (position != null) {
      setState(() {
        latitude = position?.latitude.toString();
        longitude = position?.longitude.toString();
      });
    }
  }

  // checkGPSPermission() async {
  //   var status = await Permission.locationWhenInUse.status;

  //   if (status == Permission.locationWhenInUse.isDenied) {
  //     status = await Permission.locationWhenInUse.request();
  //     if (status == Permission.locationWhenInUse.isDenied) {
  //       status = await Permission.locationWhenInUse.request();
  //     } else if (status == Permission.locationWhenInUse.isGranted) {
  //       getLatLng();
  //     } else if (status == Permission.locationWhenInUse.isPermanentlyDenied) {
  //       customAlertDialogForPermission(
  //           context,
  //           backgroundLogo,
  //           Icons.location_on,
  //           enableLocation,
  //           locationDialogSubString,
  //           enableLocation,
  //           cancel, () {
  //         Geolocator.openLocationSettings().then((value) {
  //           //checkLocationPermission();
  //         });
  //         Get.back();
  //       });
  //     }
  //   } else if (status == Permission.locationWhenInUse.isPermanentlyDenied) {
  //     customAlertDialogForPermission(context, backgroundLogo, Icons.location_on,
  //         enableLocation, locationDialogSubString, enableLocation, cancel, () {
  //       Geolocator.openLocationSettings().then((value) {
  //         //checkLocationPermission();
  //       });
  //       Get.back();
  //     });
  //   } else if (status == Permission.locationWhenInUse.isGranted) {
  //     getLatLng();
  //   }
  // }
}
