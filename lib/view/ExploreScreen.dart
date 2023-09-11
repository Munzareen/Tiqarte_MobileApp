import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/exploreController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Position? position;
  LocationPermission? permission;
  GoogleMapController? _controller;

  final _exploreController = Get.put(ExploreController());

  @override
  void initState() {
    // checkGPSPermission();

    checkLocationPermission();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _exploreController.exploreList = null;
    _exploreController.eventMarkers = [];
    _exploreController.markers = {};
    _exploreController.selectedEventData = null;
    _exploreController.mapType = false;
    _exploreController.eventDetailShow = false;
    _exploreController.latitude = null;
    _exploreController.longitude = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        //    backgroundColor: kSecondBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: GetBuilder<ExploreController>(builder: (_ec) {
          return Container(
            height: 1.sh,
            width: 1.sw,
            color: _ec.exploreList == null
                ? kPrimaryColor.withOpacity(0.8)
                : Colors.transparent,
            child: _ec.exploreList == null
                ? Container(
                    child: Center(child: spinkit
                        // Text(
                        //   enableLocation,
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(color: Colors.white, fontSize: 30),
                        // ),
                        ),
                  )
                : _ec.exploreList!.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            notFoundImage,
                            height: 250,
                          ),
                          10.verticalSpace,
                          Text(
                            'notFound'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Positioned.fill(
                            child: GoogleMap(
                              zoomControlsEnabled: false,
                              mapType: !_ec.mapType
                                  ? MapType.normal
                                  : MapType.satellite,
                              markers: _ec.markers,
                              onMapCreated: (GoogleMapController controller) {
                                _controller = controller;
                              },
                              initialCameraPosition: CameraPosition(
                                target: LatLng(double.parse(_ec.latitude!),
                                    double.parse(_ec.longitude!)),
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
                                  color: Theme.of(context).secondaryHeaderColor,
                                  borderRadius: BorderRadius.circular(20.0)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ])),
                                      10.verticalSpace,
                                      SizedBox(
                                        width: 0.45.sw,
                                        child: FittedBox(
                                          child: Text(
                                            _ec.myAddress.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _ec.changeMapType(!_ec.mapType);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10.0),
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          5.horizontalSpace,
                                          Text(
                                            'change'.tr,
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
                          _ec.eventDetailShow
                              ? Positioned(
                                  bottom: 30,
                                  right: 0,
                                  left: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => EventDetailScreen(
                                              eventId: _ec
                                                  .selectedEventData!.eventId
                                                  .toString()),
                                          transition: Transition.rightToLeft);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Container(
                                        padding: EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: Theme.of(context)
                                                .secondaryHeaderColor),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            customCardImage(
                                                _ec
                                                        .selectedEventData!
                                                        .postEventImages!
                                                        .isNotEmpty
                                                    ? _ec.selectedEventData!
                                                        .postEventImages![0]
                                                        .toString()
                                                    : "null",
                                                110.h,
                                                100.h),
                                            8.horizontalSpace,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 0.5.sw,
                                                  child: Text(
                                                    _ec.selectedEventData!.name
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                8.verticalSpace,
                                                FittedBox(
                                                  child: Text(
                                                    splitDateTimeWithoutYear(_ec
                                                        .selectedEventData!
                                                        .eventDate
                                                        .toString()),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kPrimaryColor),
                                                  ),
                                                ),
                                                8.verticalSpace,
                                                FittedBox(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: kPrimaryColor,
                                                        size: 25,
                                                      ),
                                                      5.horizontalSpace,
                                                      SizedBox(
                                                        width: 0.3.sw,
                                                        child: Text(
                                                          _ec.selectedEventData!
                                                              .city
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      5.horizontalSpace,
                                                      GestureDetector(
                                                        onTap: () async {
                                                          String data = '';
                                                          if (_ec.selectedEventData!
                                                                  .isFav ==
                                                              true) {
                                                            data =
                                                                "?eventID=${_ec.selectedEventData!.eventId!.toInt()}&fav=false&customerID=$userId";
                                                          } else {
                                                            data =
                                                                "?eventID=${_ec.selectedEventData!.eventId!.toInt()}&fav=true&customerID=$userId";
                                                          }

                                                          var res =
                                                              await ApiService()
                                                                  .addFavorite(
                                                                      data);
                                                          if (res != null &&
                                                              res is String) {
                                                            if (res
                                                                .toUpperCase()
                                                                .contains(
                                                                    "ADDED")) {
                                                              _ec.selectedEventData!
                                                                  .isFav = true;
                                                              _ec.update();
                                                            } else if (res
                                                                .toUpperCase()
                                                                .contains(
                                                                    "REMOVED")) {
                                                              _ec.selectedEventData!
                                                                      .isFav =
                                                                  false;
                                                              _ec.update();
                                                            }
                                                            customSnackBar(
                                                                'alert'.tr,
                                                                res);
                                                          }
                                                        },
                                                        child: Image.asset(
                                                          _ec.selectedEventData!
                                                                      .isFav ==
                                                                  true
                                                              ? favoriteIconSelected
                                                              : favoriteIcon,
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
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
          );
        }),
      ),
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
            'enableLocation'.tr,
            'locationDialogSubString'.tr,
            'enableLocation'.tr,
            'cancel'.tr, () {
          openAppSettings();
          Get.back();
        });
      }
    } else if (permission == LocationPermission.deniedForever) {
      customAlertDialogForPermission(
          context,
          backgroundLogo,
          Icons.location_on,
          'enableLocation'.tr,
          'locationDialogSubString'.tr,
          'enableLocation'.tr,
          'cancel'.tr, () {
        openAppSettings();
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
      _exploreController.latitude = position?.latitude.toString();
      _exploreController.longitude = position?.longitude.toString();

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark place = placemarks[0];
      _exploreController.myAddress =
          "${place.subAdministrativeArea}, ${place.country}";
      var res = await ApiService().getEventByLocation(
          "${_exploreController.latitude},${_exploreController.longitude}&distance=50");

      if (res != null && res is List) {
        _exploreController.addExploreListData(res);
      } else if (res != null && res is String) {
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    }
  }

  dynamic dummyResponse = [
    {
      "EventId": 1,
      "Name": "International Concert",
      "CompnayName": "1",
      "Discription": "This is a detail test place this is a detail text place",
      "Location": "24.9180, 67.09713",
      "City": "Endenbra",
      "EventDate": "2023-04-11T04:46:21.203",
      "CreationUserId": 1,
      "EventStatusId": 1,
      "EventTypeId": 1,
      "PostEventImages": null,
      "PreEventImages": null,
      "CatagoryId": 1,
      "Price": 0,
      "OrganizerID": 1,
      "IsPublished": false,
      "LastUpdated": "1900-01-01T00:00:00",
      "isFav": false,
      "StandingTitle": "Test Standings",
      "SeatingTitle": "Test Seatings",
      "TicketSoldOutText": "Test Tickets Sold"
    },
    {
      "EventId": 2,
      "Name": "Test2 Concert",
      "CompnayName": "1",
      "Discription": "This is a detail test place this is a detail text place",
      "Location": "24.9204, 67.1344",
      "City": "Endenbra",
      "EventDate": "2023-04-11T04:46:21.203",
      "CreationUserId": 1,
      "EventStatusId": 1,
      "EventTypeId": 1,
      "PostEventImages": null,
      "PreEventImages": null,
      "CatagoryId": 1,
      "Price": 0,
      "OrganizerID": 1,
      "IsPublished": false,
      "LastUpdated": "1900-01-01T00:00:00",
      "isFav": false,
      "StandingTitle": "Test Standings",
      "SeatingTitle": "Test Seatings",
      "TicketSoldOutText": "Test Tickets Sold"
    },
    {
      "EventId": 3,
      "Name": "Test3 Concert",
      "CompnayName": "1",
      "Discription": "This is a detail test place this is a detail text place",
      "Location": "25.0007, 67.1150",
      "City": "Endenbra",
      "EventDate": "2023-04-11T04:46:21.203",
      "CreationUserId": 1,
      "EventStatusId": 1,
      "EventTypeId": 1,
      "PostEventImages": null,
      "PreEventImages": null,
      "CatagoryId": 1,
      "Price": 0,
      "OrganizerID": 1,
      "IsPublished": false,
      "LastUpdated": "1900-01-01T00:00:00",
      "isFav": false,
      "StandingTitle": "Test Standings",
      "SeatingTitle": "Test Seatings",
      "TicketSoldOutText": "Test Tickets Sold"
    },
    {
      "EventId": 4,
      "Name": "Test4 Concert",
      "CompnayName": "1",
      "Discription": "This is a detail test place this is a detail text place",
      "Location": "25.0221, 67.1346",
      "City": "Endenbra",
      "EventDate": "2023-04-11T04:46:21.203",
      "CreationUserId": 1,
      "EventStatusId": 1,
      "EventTypeId": 1,
      "PostEventImages": null,
      "PreEventImages": null,
      "CatagoryId": 1,
      "Price": 0,
      "OrganizerID": 1,
      "IsPublished": false,
      "LastUpdated": "1900-01-01T00:00:00",
      "isFav": false,
      "StandingTitle": "Test Standings",
      "SeatingTitle": "Test Seatings",
      "TicketSoldOutText": "Test Tickets Sold"
    },
    {
      "EventId": 5,
      "Name": "Test5 Concert",
      "CompnayName": "1",
      "Discription": "This is a detail test place this is a detail text place",
      "Location": "24.9157, 67.0990",
      "City": "Endenbra",
      "EventDate": "2023-04-11T04:46:21.203",
      "CreationUserId": 1,
      "EventStatusId": 1,
      "EventTypeId": 1,
      "PostEventImages": null,
      "PreEventImages": null,
      "CatagoryId": 1,
      "Price": 0,
      "OrganizerID": 1,
      "IsPublished": false,
      "LastUpdated": "1900-01-01T00:00:00",
      "isFav": false,
      "StandingTitle": "Test Standings",
      "SeatingTitle": "Test Seatings",
      "TicketSoldOutText": "Test Tickets Sold"
    }
  ];

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
