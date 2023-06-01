import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/strings.dart';

class EventLocationScreen extends StatefulWidget {
  final String lat;
  final String long;
  const EventLocationScreen({super.key, required this.lat, required this.long});

  @override
  State<EventLocationScreen> createState() => _EventLocationScreenState();
}

class _EventLocationScreenState extends State<EventLocationScreen> {
  double? latitude;
  double? longitude;
  GoogleMapController? _controller;

  bool isDirection = false;

  @override
  void initState() {
    super.initState();
    latitude = double.parse(widget.lat);
    longitude = double.parse(widget.long);
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
          isDirection ? direction : eventLocation,
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
                          Marker(
                              draggable: true,
                              markerId: MarkerId("my Location"),
                              position: LatLng(latitude!, longitude!),
                              icon: BitmapDescriptor.defaultMarker,
                              infoWindow: const InfoWindow(
                                title: 'Event',
                              ),
                              onDragEnd: ((newPosition) {
                                setState(() {
                                  latitude = newPosition.latitude;
                                  longitude = newPosition.longitude;
                                });
                              })),
                          Marker(
                            draggable: true,
                            markerId: MarkerId("Event Location"),
                            position: LatLng(latitude!, longitude!), //hardcoded
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
              },
              child: customButton(getDirection, kPrimaryColor),
            )),
      ),
    );
  }
}
