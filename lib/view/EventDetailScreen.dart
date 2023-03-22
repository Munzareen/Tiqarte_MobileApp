import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tiqarte/controller/homeController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';

class EventDetailScreen extends StatefulWidget {
  final dynamic data;
  const EventDetailScreen({super.key, required this.data});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  GoogleMapController? _controller;
  final _homeController = Get.put(HomeController());

  List eventDetailImages = [eventImage, eventImage, eventImage];

  List eventUserImages = [
    eventUserImage1,
    eventUserImage2,
    eventUserImage3,
    eventUserImage4,
    eventUserImage5
  ];

  ScrollController _scrollController = ScrollController();

  Color appBarIconColor = Colors.white;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= 300) {
        setState(() {
          appBarIconColor = Colors.black;
        });
      } else {
        setState(() {
          appBarIconColor = Colors.white;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: appBarIconColor,
            size: 35,
          ),
        ),
        actions: [
          Image.asset(
            favoriteIcon,
            height: 50,
            color: appBarIconColor,
          ),
          Image.asset(
            sendIcon,
            height: 50,
            color: appBarIconColor,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                height: 0.45.sh,
                child: PageView.builder(
                  itemCount: eventDetailImages.length,
                  itemBuilder: (context, pageViewindex) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        customImageForDetail('', 1.sw, 0.45.sh),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(
                              eventDetailImages.length,
                              (index) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  height: 10,
                                  width: index == pageViewindex ? 30 : 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
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
                        widget.data['name'],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(9.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: kPrimaryColor, width: 1)),
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
                              fontWeight: FontWeight.bold,
                              color: Color(0xff424242)),
                        ),
                        10.verticalSpace,
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Color(0xff424242),
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
                          color: kSecondBackgroundColor),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: kPrimaryColor.withOpacity(0.2)),
                            child: Icon(
                              Icons.calendar_month,
                              color: kPrimaryColor,
                              size: 30,
                            ),
                          ),
                          15.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 0.6.sw,
                                child: Text(
                                  "Monday, December 24, 2022",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              8.verticalSpace,
                              SizedBox(
                                width: 0.6.sw,
                                child: Text(
                                  "18.00 - 23.00 PM (GMT +07:00)",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121)),
                                ),
                              ),
                              15.verticalSpace,
                              Container(
                                // width: 0.2.sh,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          color: kSecondBackgroundColor),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: kPrimaryColor.withOpacity(0.2)),
                            child: Icon(
                              Icons.location_on,
                              color: kPrimaryColor,
                              size: 30,
                            ),
                          ),
                          15.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 0.6.sw,
                                child: Text(
                                  "Grand Park, New York City, US",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              8.verticalSpace,
                              SizedBox(
                                width: 0.6.sw,
                                child: Text(
                                  "Grand City St. 100, New York, United States.",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121)),
                                ),
                              ),
                              15.verticalSpace,
                              Container(
                                // width: 0.2.sh,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          color: kSecondBackgroundColor),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: kPrimaryColor.withOpacity(0.2)),
                              child: Image.asset(
                                ticketIconSelected,
                                color: kPrimaryColor,
                                height: 30,
                              )),
                          15.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 0.6.sw,
                                child: Text(
                                  "\$20.00 - \$100.00",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121)),
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
                            customProfileImage(organizerImage, 60, 60),
                            15.horizontalSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "World of Music",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Organizer",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff616161)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          // width: 0.2.sh,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(
                            follow,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
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
                          color: Colors.black),
                    ),
                    10.verticalSpace,
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff424242))),
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
                          // onTap: () => Get.to(
                          //     () => SeeAllEvents(
                          //         name: homeFeaturedString, img: ''),
                          //     transition: Transition.rightToLeft),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customCardImage(galleryEventImage1, 110, 110),
                          customCardImage(galleryEventImage2, 110, 110),
                          customCardImageWithMore(galleryEventImage1, 110, 110)
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
                                  color: Color(0xff616161),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: GoogleMap(
                        mapType: MapType.normal, //  mapType: MapType.satellite,

                        markers: Set<Marker>.of(
                          <Marker>[
                            Marker(
                                draggable: true,
                                markerId: MarkerId("Event Location"),
                                position: LatLng(20.02, -80.99), //hardcoded
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
                              color: Colors.black),
                        ),
                        InkWell(
                          // onTap: () => Get.to(
                          //     () => SeeAllEvents(
                          //         name: homeFeaturedString, img: ''),
                          //     transition: Transition.rightToLeft),
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
                              height: 0.45.sh,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.8),
                          itemCount: _hc.eventList.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return InkWell(
                              // onTap: () {
                              //   Get.to(() => EventDetailScreen(
                              //         data: _hc.eventList[itemIndex],
                              //       ));
                              // },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      customCardImage(eventImage, 250.w, 160.h),
                                      12.verticalSpace,
                                      FittedBox(
                                        child: Text(
                                          _hc.eventList[itemIndex]['name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      12.verticalSpace,
                                      FittedBox(
                                        child: Text(
                                          _hc.eventList[itemIndex]['date'],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: kPrimaryColor),
                                        ),
                                      ),
                                      12.verticalSpace,
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
                                              _hc.eventList[itemIndex]
                                                  ['location'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff616161)),
                                            ),
                                            10.horizontalSpace,
                                            InkWell(
                                              onTap: () {
                                                _hc.addRemoveToFavorite(
                                                    itemIndex,
                                                    _hc.eventList[itemIndex]);
                                              },
                                              child: Image.asset(
                                                _hc.eventList[itemIndex]
                                                            ['isFavorite'] ==
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 1.sw,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: customButton(bookEvent, kPrimaryColor),
        ),
      ),
    );
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
            placeholder: (context, url) => Container(
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
            errorWidget: (context, url, error) => Container(
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
}
