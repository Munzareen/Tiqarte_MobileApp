import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:url_launcher/url_launcher.dart';

class EventLocationScreen extends StatefulWidget {
  final String lat;
  final String long;
  final String eventName;
  const EventLocationScreen(
      {super.key,
      required this.lat,
      required this.long,
      required this.eventName});

  @override
  State<EventLocationScreen> createState() => _EventLocationScreenState();
}

class _EventLocationScreenState extends State<EventLocationScreen> {
  String? mylatitude;
  String? mylongitude;
  Position? position;
  LocationPermission? permission;

  double? latitude;
  double? longitude;
  GoogleMapController? _controller;

//-- for in app directions --

  // Completer<GoogleMapController> _controller = Completer();
  // PolylinePoints polylinePoints = PolylinePoints();
  // List<LatLng> polylineCoordinates = [];
  // Map<PolylineId, Polyline> polylines = {};
  // final String apiKey = 'AIzaSyAfX1GR5YKAFi_cXCRdXGLTO_Cqjshb8qY';

  //-- for in app directions --

  bool isDirection = false;

  @override
  void initState() {
    super.initState();
    latitude = double.parse(widget.lat);
    longitude = double.parse(widget.long);
    checkLocationPermission();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
          isDirection ? 'direction'.tr : 'eventLocation'.tr,
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
              height: 0.8.sh,
              child: latitude == null
                  ? Center(
                      child: spinkit,
                    )
                  : GoogleMap(
                      mapType: MapType.normal, //  mapType: MapType.satellite,

                      markers: Set<Marker>.of(
                        <Marker>[
                          if (mylatitude != null)
                            Marker(
                              draggable: true,
                              markerId: MarkerId("my Location"),
                              position: LatLng(
                                  double.parse(mylatitude.toString()),
                                  double.parse(mylongitude.toString())),
                              icon: BitmapDescriptor.defaultMarkerWithHue(250),
                              infoWindow: const InfoWindow(
                                title: 'You',
                              ),
                              // onDragEnd: ((newPosition) {
                              //   setState(() {
                              //     mylatitude = newPosition.latitude.toString();
                              //     mylongitude = newPosition.longitude.toString();
                              //   });
                              // })
                            ),
                          Marker(
                            draggable: false,
                            markerId: MarkerId("Event Location"),
                            position: LatLng(latitude!, longitude!), //hardcoded
                            icon: BitmapDescriptor.defaultMarker,
                            infoWindow: InfoWindow(
                              title: widget.eventName,
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
                      //polylines: Set<Polyline>.of(polylines.values),-- for in app directions --

                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                        // _controller.complete(controller);-- for in app directions --
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude!, longitude!),
                        zoom: 12,
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 1.sw,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: GestureDetector(
              onTap: () {
                // setState(() {
                //   isDirection = true;
                // });

/*-- for in app directions --
               mylatitude != null
                    ? getDirections()
                    : checkLocationPermission();

                -- for in app directions -- */
                mylatitude != null
                    ? launchGoogleMapsDirections(
                        origin: '$mylatitude,$mylongitude',
                        destination:
                            '${latitude.toString()},${longitude.toString()}')
                    : checkLocationPermission();
              },
              child: customButton('getDirection'.tr, kPrimaryColor),
            )),
      ),
    );
  }

//-- for in app directions --

  // getDirections() async {
  //   try {
  //     LatLng origin = LatLng(double.parse(mylatitude.toString()),
  //         double.parse(mylongitude.toString()));
  //     LatLng destination = LatLng(double.parse(latitude.toString()),
  //         double.parse(longitude.toString()));
  //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       apiKey,
  //       PointLatLng(origin.latitude, origin.longitude),
  //       PointLatLng(destination.latitude, destination.longitude),
  //     );

  //     if (result.points.isNotEmpty) {
  //       result.points.forEach((PointLatLng point) {
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //       });

  //       PolylineId id = PolylineId('poly');
  //       Polyline polyline = Polyline(
  //         polylineId: id,
  //         color: Colors.blue,
  //         points: polylineCoordinates,
  //         width: 3,
  //       );

  //       setState(() {
  //         polylines[id] = polyline;
  //       });
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     customSnackBar('error'.tr, 'somethingWentWrong'.tr);
  //   }
  // }

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
          openAppSettings().then((value) {
            //checkLocationPermission();
          });
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
      mylatitude = position?.latitude.toString();
      mylongitude = position?.longitude.toString();
    }
  }

  launchGoogleMapsDirections(
      {required String origin, required String destination}) async {
    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=driving';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }
}
