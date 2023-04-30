import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/eventDetailController.dart';
import 'package:tiqarte/controller/homeController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/BookEventScreen.dart';
import 'package:tiqarte/view/EventLocationScreen.dart';
import 'package:tiqarte/view/GalleryScreen.dart';
import 'package:tiqarte/view/GoingScreen.dart';
import 'package:tiqarte/view/OrganizerProfileScreen.dart';
import 'package:tiqarte/view/SeeAllEventsScreen.dart';

class EventDetailScreen extends StatefulWidget {
  final String eventId;
  const EventDetailScreen({super.key, required this.eventId});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  GoogleMapController? _controller;
  final _homeController = Get.put(HomeController());

  final _eventDetailController = Get.put(EventDetailController());

  List eventDetailImages = [eventImage, eventImage, eventImage];

  List eventUserImages = [
    eventUserImage1,
    eventUserImage2,
    eventUserImage3,
    eventUserImage4,
    eventUserImage5
  ];

  //ScrollController _scrollController = ScrollController();

  //Color appBarIconColor = Colors.white;

  String? latitude;
  String? longitude;
  Position? position;
  LocationPermission? permission;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getEventDetail(widget.eventId);
    if (res != null && res is Map) {
      _eventDetailController.addEventDetail(res);
    } else if (res != null && res is String) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventDetailController>(builder: (_edc) {
      return _edc.eventDetailModel.eventId == null
          ? Scaffold(
              body: Container(
                height: 1.sh,
                child: Center(
                  child: spinkit,
                ),
              ),
            )
          : Scaffold(
              // backgroundColor: kSecondBackgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: _edc.appBarIconColor,
                    size: 35,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   widget.data['isFavorite'] = !widget.data['isFavorite'];
                      // });
                    },
                    child: Image.asset(
                      // widget.data['isFavorite'] == true
                      //     ? favoriteIconSelected
                      //     :
                      favoriteIcon,
                      height: 50,
                      color:
                          // widget.data['isFavorite'] == true
                          //     ? kPrimaryColor
                          //     :
                          _edc.appBarIconColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share('Check out this awesome event!',
                          subject: 'Event Invitation');
                    },
                    child: Image.asset(
                      sendIcon,
                      height: 50,
                      color: _edc.appBarIconColor,
                    ),
                  ),
                ],
              ),
              extendBodyBehindAppBar: true,
              body: Container(
                height: 1.sh,
                width: 1.sw,
                child: SingleChildScrollView(
                  controller: _edc.scrollController,
                  child: Column(
                    children: [
                      Container(
                        height: 0.45.sh,
                        child: PageView.builder(
                          itemCount: _edc.eventDetailModel.eventImages?.length,
                          itemBuilder: (context, pageViewindex) {
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                customImageForDetail(
                                    _edc.eventDetailModel
                                        .eventImages![pageViewindex],
                                    1.sw,
                                    0.45.sh),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List<Widget>.generate(
                                      _edc.eventDetailModel.eventImages!.length,
                                      (index) => Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          height: 10,
                                          width:
                                              index == pageViewindex ? 30 : 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              color: index == pageViewindex
                                                  ? kPrimaryColor
                                                  : Color(0xffE0E0E0))),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      20.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 0.8.sw,
                              child: Text(
                                _edc.eventDetailModel.name.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            10.verticalSpace,
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(9.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                          color: kPrimaryColor, width: 1)),
                                  child: Text(
                                    "Music",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                ),
                                10.horizontalSpace,
                                Row(
                                  children: List<Widget>.generate(
                                      eventUserImages.length,
                                      (index) => Align(
                                            widthFactor: 0.6,
                                            child: customProfileImage(
                                                eventUserImages[index], 30, 30),
                                          )),
                                ),
                                15.horizontalSpace,
                                Text(
                                  "20,000+ going",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                10.verticalSpace,
                                IconButton(
                                  onPressed: () {
                                    Get.to(() => GoingScreen(),
                                        transition: Transition.rightToLeft);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Divider(),
                            10.verticalSpace,
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(30.0),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: kPrimaryColor.withOpacity(0.3)),
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: kPrimaryColor,
                                      size: 30,
                                    ),
                                  ),
                                  15.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 0.6.sw,
                                        child: Text(
                                          splitDateOnly(_edc
                                              .eventDetailModel.eventDate
                                              .toString()),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      8.verticalSpace,
                                      SizedBox(
                                        width: 0.6.sw,
                                        child: Text(
                                          splitTimeOnly(_edc
                                              .eventDetailModel.eventDate
                                              .toString()),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                      15.verticalSpace,
                                      Container(
                                        // width: 0.2.sh,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            10.horizontalSpace,
                                            Text(
                                              addToMyCalender,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            10.verticalSpace,
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(30.0),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: kPrimaryColor.withOpacity(0.3)),
                                    child: Icon(
                                      Icons.location_on,
                                      color: kPrimaryColor,
                                      size: 30,
                                    ),
                                  ),
                                  15.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 0.6.sw,
                                        child: Text(
                                          _edc.eventDetailModel.city.toString(),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      8.verticalSpace,
                                      SizedBox(
                                        width: 0.6.sw,
                                        child: Text(
                                          _edc.eventDetailModel.location
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                      15.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          if (latitude != null) {
                                            Get.to(
                                              () => EventLocationScreen(
                                                  lat: latitude.toString(),
                                                  long: longitude.toString()),
                                            );
                                          } else {
                                            checkLocationPermission();
                                          }
                                        },
                                        child: Container(
                                          // width: 0.2.sh,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 10.0),
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              10.horizontalSpace,
                                              Text(
                                                seeLocationOnMaps,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            10.verticalSpace,
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(30.0),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color:
                                              kPrimaryColor.withOpacity(0.3)),
                                      child: Image.asset(
                                        ticketIconSelected,
                                        color: kPrimaryColor,
                                        height: 30,
                                      )),
                                  15.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 0.6.sw,
                                        child: Text(
                                          "\$ " +
                                              _edc.eventDetailModel.price
                                                  .toString(),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      8.verticalSpace,
                                      SizedBox(
                                        width: 0.6.sw,
                                        child: Text(
                                          "Ticket price depends on package.",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            10.verticalSpace,
                            Divider(),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => OrganizerProfileScreen(),
                                            transition: Transition.rightToLeft);
                                      },
                                      child: customProfileImage(
                                          organizerImage, 50.h, 50.h),
                                    ),
                                    15.horizontalSpace,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 0.4.sw,
                                          child: Text(
                                            "World of Music",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Organizer",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                _edc.isFollow
                                    ? InkWell(
                                        onTap: () {
                                          _edc.followUnFollow();
                                        },
                                        child: Container(
                                          // width: 0.2.sh,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                  color: kPrimaryColor,
                                                  width: 2)),
                                          child: Text(
                                            following,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: kPrimaryColor),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          _edc.followUnFollow();
                                        },
                                        child: Container(
                                          // width: 0.2.sh,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Text(
                                            follow,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            10.verticalSpace,
                            Text(
                              aboutEvent,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            10.verticalSpace,
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: _edc.eventDetailModel.discription
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                ),
                                TextSpan(
                                    text: " " + readMore,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryColor))
                              ]),
                            ),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  galleryPreEvent,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => GalleryScreen(),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: Text(
                                    seeAll,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customCardImage(
                                      galleryEventImage1, 90.h, 90.h),
                                  customCardImage(
                                      galleryEventImage2, 90.h, 90.h),
                                  customCardImageWithMore(
                                      galleryEventImage1, 90.h, 90.h)
                                ],
                              ),
                            ),
                            10.verticalSpace,
                            Text(location,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: kPrimaryColor,
                                  size: 25,
                                ),
                                10.horizontalSpace,
                                SizedBox(
                                  width: 0.75.sw,
                                  child: Text(
                                      "Grand City St. 100, New York, United States",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14)),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Container(
                              height: 0.25.sh,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: GoogleMap(
                                mapType: MapType
                                    .normal, //  mapType: MapType.satellite,

                                markers: Set<Marker>.of(
                                  <Marker>[
                                    Marker(
                                        draggable: true,
                                        markerId: MarkerId("Event Location"),
                                        position:
                                            LatLng(20.02, -80.99), //hardcoded
                                        icon: BitmapDescriptor.defaultMarker,
                                        infoWindow: const InfoWindow(
                                          title: 'Event',
                                        ),
                                        onDragEnd: ((newPosition) {
                                          // setState(() {
                                          //   latitude = newPosition.latitude;
                                          //   longitude = newPosition.longitude;
                                          //   getLocationName(latitude!, longitude!);
                                          // });
                                        }))
                                  ],
                                ),
                                onMapCreated: (GoogleMapController controller) {
                                  _controller = controller;
                                },
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(20.02, -80.99), //hardcoded
                                  zoom: 12,
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  moreEventsLikeThis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Get.to(
                                      () => SeeAllEventsScreen(
                                          name: "Events", img: ''),
                                      transition: Transition.rightToLeft),
                                  child: Text(
                                    seeAll,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                ),
                              ],
                            ),
                            20.verticalSpace,
                            GetBuilder<HomeController>(builder: (_hc) {
                              return CarouselSlider.builder(
                                  options: CarouselOptions(
                                      height: 0.425.sh,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      enableInfiniteScroll: false,
                                      viewportFraction: 0.8),
                                  itemCount: _hc.eventList.length,
                                  itemBuilder: (BuildContext context,
                                      int itemIndex, int pageViewIndex) {
                                    return InkWell(
                                      // onTap: () {
                                      //   Get.to(() => EventDetailScreen(
                                      //         data: _hc.eventList[itemIndex],
                                      //       ));
                                      // },
                                      child: Container(
                                        padding: EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: Theme.of(context)
                                                .secondaryHeaderColor),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customCardImage(
                                                  eventImage, 250.w, 160.h),
                                              12.verticalSpace,
                                              SizedBox(
                                                width: 0.7.sw,
                                                child: Text(
                                                  _hc.eventList[itemIndex]
                                                      ['name'],
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              12.verticalSpace,
                                              FittedBox(
                                                child: Text(
                                                  _hc.eventList[itemIndex]
                                                      ['date'],
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kPrimaryColor),
                                                ),
                                              ),
                                              12.verticalSpace,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: kPrimaryColor,
                                                        size: 25,
                                                      ),
                                                      10.horizontalSpace,
                                                      SizedBox(
                                                        width: 0.4.sw,
                                                        child: Text(
                                                          _hc.eventList[
                                                                  itemIndex]
                                                              ['location'],
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            //color: Color(0xff616161)
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _hc.addRemoveToFavorite(
                                                          itemIndex,
                                                          _hc.eventList[
                                                              itemIndex]);
                                                    },
                                                    child: Image.asset(
                                                      _hc.eventList[itemIndex][
                                                                  'isFavorite'] ==
                                                              true
                                                          ? favoriteIconSelected
                                                          : favoriteIcon,
                                                      color: kPrimaryColor,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                            80.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                width: 1.sw,
                color: Theme.of(context).secondaryHeaderColor,
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => BookEventScreen(),
                            transition: Transition.rightToLeft);
                      },
                      child: customButton(bookEvent, kPrimaryColor),
                    )),
              ),
            );
    });
  }

  customImageForDetail(String url, double width, double height) {
    return url != "" && url != "null"
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(40),
                  //     bottomRight: Radius.circular(40)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              );
            },
            placeholder: (context, url) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(40),
                //     bottomRight: Radius.circular(40)),
                image: DecorationImage(
                    image: AssetImage(placeholder), fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(40),
                //     bottomRight: Radius.circular(40)),
                image: DecorationImage(
                    image: AssetImage(placeholder), fit: BoxFit.cover),
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(40),
              //     bottomRight: Radius.circular(40)),
              image: DecorationImage(
                  image: AssetImage(eventImage), fit: BoxFit.cover),
            ),
          ); //AssetImage(placeholder)
  }

  customCardImageWithMore(String url, double width, double height) {
    return url == "" && url == "null"
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) {
              return Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      // border: Border.all(
                      //   color: kPrimaryColor,
                      //   style: BorderStyle.solid,
                      // ),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)));
            },
            placeholder: (context, url) => InkWell(
              onTap: () {
                Get.to(() => GalleryScreen(),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      // border: Border.all(
                      //   color: kPrimaryColor,
                      //   style: BorderStyle.solid,
                      // ),
                      image: DecorationImage(
                          image: AssetImage(eventImage), fit: BoxFit.cover))),
            ),
            errorWidget: (context, url, error) => InkWell(
              onTap: () {
                Get.to(() => GalleryScreen(),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      // border: Border.all(
                      //   color: kPrimaryColor,
                      //   style: BorderStyle.solid,
                      // ),
                      image: DecorationImage(
                          image: AssetImage(eventImage), fit: BoxFit.cover))),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(
                //   color: kPrimaryColor,
                //   style: BorderStyle.solid,
                // ),
                color: Colors.black.withOpacity(0.2),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: AssetImage(eventImage),
                    fit: BoxFit.cover)),
            child: Center(
              child: Text(
                "20+",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ); //AssetImage(placeholder)
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
}
