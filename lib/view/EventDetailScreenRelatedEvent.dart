import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/bookEventController.dart';
import 'package:tiqarte/controller/eventDetailController.dart';
import 'package:tiqarte/controller/homeController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/BookEventScreen.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';
import 'package:tiqarte/view/EventLocationScreen.dart';
import 'package:tiqarte/view/GalleryScreen.dart';
import 'package:tiqarte/view/GoingScreen.dart';
import 'package:tiqarte/view/ImagePreviewDialog.dart';
import 'package:tiqarte/view/OrganizerDetailScreen.dart';
import 'package:tiqarte/view/SeeAllEventsScreen.dart';

class EventDetailScreenRelatedEvent extends StatefulWidget {
  final String eventId;
  const EventDetailScreenRelatedEvent({super.key, required this.eventId});

  @override
  State<EventDetailScreenRelatedEvent> createState() =>
      _EventDetailScreenRelatedEventState();
}

class _EventDetailScreenRelatedEventState
    extends State<EventDetailScreenRelatedEvent> {
  GoogleMapController? _controller;
  // ignore: unused_field
  final _homeController = Get.put(HomeController());

  final _eventDetailController = Get.put(EventDetailController());
  final _bookEventController = Get.put(BookEventController());

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
      _eventDetailController.addEventDetail(res, widget.eventId);
    } else if (res != null && res is String) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventDetailController>(builder: (_edc) {
      return _edc.eventDetailModel.event?.eventId == null
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
                    onTap: () async {
                      String data = '';
                      if (_edc.eventDetailModel.event?.isFav == true) {
                        data =
                            "?eventID=${_edc.eventDetailModel.event?.eventId!.toInt()}&fav=false&customerID=$userId";
                      } else {
                        data =
                            "?eventID=${_edc.eventDetailModel.event?.eventId!.toInt()}&fav=true&customerID=$userId";
                      }

                      var res = await ApiService().addFavorite(data);
                      if (res != null && res is String) {
                        if (res.toUpperCase().contains("ADDED")) {
                          _edc.eventDetailModel.event?.isFav = true;
                          _edc.update();
                        } else if (res.toUpperCase().contains("REMOVED")) {
                          _edc.eventDetailModel.event?.isFav = false;
                          _edc.update();
                        }
                        customSnackBar('alert'.tr, res);
                      }
                    },
                    child: Image.asset(
                      _edc.eventDetailModel.event?.isFav == true
                          ? favoriteIconSelected
                          : favoriteIcon,
                      height: 50,
                      color: _edc.appBarIconColor,
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
                  controller: _edc.scrollControllerForRelatedEvent,
                  child: Column(
                    children: [
                      Container(
                        height: 0.45.sh,
                        child: PageView.builder(
                          itemCount: _edc
                              .eventDetailModel.event?.postEventImages?.length,
                          itemBuilder: (context, pageViewindex) {
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                customImageForDetail(
                                    _edc.eventDetailModel.event!
                                            .postEventImages!.isNotEmpty
                                        ? _edc.eventDetailModel.event!
                                            .postEventImages![pageViewindex]
                                            .toString()
                                        : "null",
                                    1.sw,
                                    0.45.sh),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List<Widget>.generate(
                                      _edc.eventDetailModel.event!
                                          .postEventImages!.length,
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
                              width: 0.9.sw,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 0.5.sw,
                                    child: Text(
                                      _edc.eventDetailModel.event!.name
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  _edc.eventDetailModel.reviewRating != null &&
                                          (_edc.eventDetailModel.reviewRating
                                              is num)
                                      ? SizedBox(
                                          width: 0.4.sw,
                                          child: Column(
                                            children: [
                                              RatingBar(
                                                ignoreGestures: true,
                                                itemSize: 30,
                                                initialRating: _edc
                                                    .eventDetailModel
                                                    .reviewRating!
                                                    .toDouble(),
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                ratingWidget: RatingWidget(
                                                  full: Icon(
                                                    Icons.star,
                                                    color: kPrimaryColor,
                                                  ),
                                                  half: Icon(
                                                    Icons.star_half,
                                                    color: kPrimaryColor,
                                                  ),
                                                  empty: Icon(
                                                    Icons.star_border,
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                onRatingUpdate: (rating) =>
                                                    null,
                                              ),
                                              5.verticalSpace,
                                              _edc.eventReviewList.isEmpty
                                                  ? SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        reviewsBottomSheet(
                                                            context, _edc);
                                                      },
                                                      child: Text(
                                                        'seeAll'.tr,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: 0.8.sw,
                            //   child: Text(
                            //     _edc.eventDetailModel.event!.name.toString(),
                            //     textAlign: TextAlign.start,
                            //     style: TextStyle(
                            //       fontSize: 32,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
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
                                    'music'.tr,
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
                                      _edc.eventDetailModel.customers!.length >
                                              6
                                          ? 6
                                          : _edc.eventDetailModel.customers!
                                              .length,
                                      (index) => Align(
                                            widthFactor: 0.6,
                                            child: customProfileImage(
                                                _edc.eventDetailModel
                                                    .customers![index].imageUrl
                                                    .toString(),
                                                30,
                                                30),
                                          )),
                                ),
                                15.horizontalSpace,
                                Text(
                                  _edc.eventDetailModel.customers!.length
                                          .toString() +
                                      " going",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                10.verticalSpace,
                                _edc.eventDetailModel.customers!.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          Get.to(
                                              () => GoingScreen(
                                                  customerList: _edc
                                                      .eventDetailModel
                                                      .customers!),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward,
                                          size: 20,
                                        ),
                                      )
                                    : SizedBox(),
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
                                              .eventDetailModel.event!.eventDate
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
                                              .eventDetailModel.event!.eventDate
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
                                              'addToMyCalender'.tr,
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
                                          _edc.eventDetailModel.event!.city
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
                                          _edc.eventDetailModel.event!
                                              .locationName
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                      15.verticalSpace,
                                      GestureDetector(
                                        onTap: () {
                                          if (_edc.eventDetailModel.event!
                                                  .location
                                                  .toString() !=
                                              "null") {
                                            Get.to(
                                              () => EventLocationScreen(
                                                  lat: _edc.eventDetailModel
                                                      .event!.location!
                                                      .split(",")
                                                      .first
                                                      .trim(),
                                                  long: _edc.eventDetailModel
                                                      .event!.location!
                                                      .split(",")
                                                      .last
                                                      .trim(),
                                                  eventName: _edc
                                                      .eventDetailModel
                                                      .event!
                                                      .name
                                                      .toString()),
                                            );
                                          } else {
                                            customSnackBar('error'.tr,
                                                'somethingWentWrong'.tr);
                                            //checkLocationPermission();
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
                                                'seeLocationOnMaps'.tr,
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
                                              _edc.eventDetailModel.event!.price
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
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            () => OrganizerDetailScreen(
                                                orgnizerId: _edc
                                                    .eventDetailModel
                                                    .organizer!
                                                    .id!
                                                    .toInt()
                                                    .toString()),
                                            transition: Transition.rightToLeft);
                                      },
                                      child: customProfileImage(
                                          _edc.eventDetailModel.organizer !=
                                                  null
                                              ? _edc.eventDetailModel.organizer!
                                                  .imageUrl
                                                  .toString()
                                              : "null",
                                          50.h,
                                          50.h),
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
                                            _edc.eventDetailModel.organizer !=
                                                    null
                                                ? _edc.eventDetailModel
                                                    .organizer!.name
                                                    .toString()
                                                : "null",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0.4.sw,
                                          child: Text(
                                            _edc.eventDetailModel.organizer !=
                                                        null &&
                                                    _edc
                                                            .eventDetailModel
                                                            .organizer!
                                                            .description !=
                                                        null
                                                ? _edc.eventDetailModel
                                                    .organizer!.description
                                                    .toString()
                                                : "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    String data = '';
                                    if (_edc.eventDetailModel
                                            .isOrganizerFollow ==
                                        true) {
                                      data =
                                          "?organizerID=${_edc.eventDetailModel.organizer?.id?.toInt()}&customerID=$userId&follow=false";
                                    } else {
                                      data =
                                          "?organizerID=${_edc.eventDetailModel.organizer?.id?.toInt()}&customerID=$userId&follow=true";
                                    }

                                    var res = await ApiService()
                                        .setOrganizerFollow(data);
                                    if (res != null && res is String) {
                                      if (res.toUpperCase().contains("ADDED")) {
                                        _edc.eventDetailModel
                                            .isOrganizerFollow = true;
                                        _edc.update();
                                        customSnackBar('alert'.tr,
                                            "You are now following ${_edc.eventDetailModel.organizer?.name.toString()}");
                                      } else if (res
                                          .toUpperCase()
                                          .contains("REMOVE")) {
                                        _edc.eventDetailModel
                                            .isOrganizerFollow = false;
                                        _edc.update();
                                        customSnackBar('alert'.tr,
                                            "You unfollowed ${_edc.eventDetailModel.organizer?.name.toString()}");
                                      }
                                    }
                                  },
                                  child: Container(
                                    // width: 0.2.sh,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                        color: _edc.eventDetailModel
                                                    .isOrganizerFollow ==
                                                true
                                            ? kPrimaryColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: kPrimaryColor, width: 2)),
                                    child: Text(
                                      _edc.eventDetailModel.isOrganizerFollow ==
                                              true
                                          ? 'following'.tr
                                          : 'follow'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: _edc.eventDetailModel
                                                      .isOrganizerFollow ==
                                                  true
                                              ? Colors.white
                                              : kPrimaryColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            10.verticalSpace,
                            Text(
                              'aboutEvent'.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            10.verticalSpace,
                            ReadMoreWidget(
                              text: _edc.eventDetailModel.event!.discription
                                  .toString(),
                              maxLines: 2,
                            ),
                            10.verticalSpace,
                            _edc.eventDetailModel.event!.preEventImages!.isEmpty
                                ? SizedBox()
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'galleryPreEvent'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                    () => GalleryScreen(
                                                        previousEventImages: _edc
                                                            .eventDetailModel
                                                            .event!
                                                            .preEventImages!),
                                                    transition:
                                                        Transition.rightToLeft);
                                              },
                                              child: Text(
                                                'seeAll'.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: kPrimaryColor),
                                              )),
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: _edc.eventDetailModel.event!
                                                    .preEventImages!.length ==
                                                1
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            ImagePreviewDialog(
                                                          imagePath: _edc
                                                                  .eventDetailModel
                                                                  .event!
                                                                  .preEventImages!
                                                                  .isNotEmpty
                                                              ? _edc
                                                                  .eventDetailModel
                                                                  .event!
                                                                  .preEventImages![
                                                                      0]
                                                                  .toString()
                                                              : "null",
                                                        ),
                                                      );
                                                    },
                                                    child: customCardImage(
                                                        _edc
                                                                .eventDetailModel
                                                                .event!
                                                                .preEventImages!
                                                                .isNotEmpty
                                                            ? _edc
                                                                .eventDetailModel
                                                                .event!
                                                                .preEventImages![
                                                                    0]
                                                                .toString()
                                                            : "null",
                                                        90.h,
                                                        90.h),
                                                  )
                                                ],
                                              )
                                            : _edc
                                                        .eventDetailModel
                                                        .event!
                                                        .preEventImages!
                                                        .length ==
                                                    2
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  ImagePreviewDialog(
                                                                imagePath: _edc
                                                                    .eventDetailModel
                                                                    .event!
                                                                    .preEventImages![
                                                                        0]
                                                                    .toString(),
                                                              ),
                                                            );
                                                          },
                                                          child: customCardImage(
                                                              _edc
                                                                  .eventDetailModel
                                                                  .event!
                                                                  .preEventImages![
                                                                      0]
                                                                  .toString(),
                                                              90.h,
                                                              90.h)),
                                                      5.horizontalSpace,
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                ImagePreviewDialog(
                                                              imagePath: _edc
                                                                  .eventDetailModel
                                                                  .event!
                                                                  .preEventImages![
                                                                      1]
                                                                  .toString(),
                                                            ),
                                                          );
                                                        },
                                                        child: customCardImage(
                                                            _edc
                                                                .eventDetailModel
                                                                .event!
                                                                .preEventImages![
                                                                    1]
                                                                .toString(),
                                                            90.h,
                                                            90.h),
                                                      )
                                                    ],
                                                  )
                                                : _edc
                                                            .eventDetailModel
                                                            .event!
                                                            .preEventImages!
                                                            .length ==
                                                        3
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    ImagePreviewDialog(
                                                                  imagePath: _edc
                                                                          .eventDetailModel
                                                                          .event!
                                                                          .preEventImages!
                                                                          .isNotEmpty
                                                                      ? _edc
                                                                          .eventDetailModel
                                                                          .event!
                                                                          .preEventImages![
                                                                              0]
                                                                          .toString()
                                                                      : "null",
                                                                ),
                                                              );
                                                            },
                                                            child: customCardImage(
                                                                _edc
                                                                        .eventDetailModel
                                                                        .event!
                                                                        .preEventImages!
                                                                        .isNotEmpty
                                                                    ? _edc
                                                                        .eventDetailModel
                                                                        .event!
                                                                        .preEventImages![
                                                                            0]
                                                                        .toString()
                                                                    : "null",
                                                                90.h,
                                                                90.h),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    ImagePreviewDialog(
                                                                  imagePath: _edc
                                                                      .eventDetailModel
                                                                      .event!
                                                                      .preEventImages![
                                                                          1]
                                                                      .toString(),
                                                                ),
                                                              );
                                                            },
                                                            child: customCardImage(
                                                                _edc
                                                                    .eventDetailModel
                                                                    .event!
                                                                    .preEventImages![
                                                                        1]
                                                                    .toString(),
                                                                90.h,
                                                                90.h),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    ImagePreviewDialog(
                                                                  imagePath: _edc
                                                                      .eventDetailModel
                                                                      .event!
                                                                      .preEventImages![
                                                                          2]
                                                                      .toString(),
                                                                ),
                                                              );
                                                            },
                                                            child: customCardImage(
                                                                _edc
                                                                    .eventDetailModel
                                                                    .event!
                                                                    .preEventImages![
                                                                        2]
                                                                    .toString(),
                                                                90.h,
                                                                90.h),
                                                          )
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          customCardImage(
                                                              _edc
                                                                  .eventDetailModel
                                                                  .event!
                                                                  .preEventImages![
                                                                      0]
                                                                  .toString(),
                                                              90.h,
                                                              90.h),
                                                          customCardImage(
                                                              _edc
                                                                  .eventDetailModel
                                                                  .event!
                                                                  .preEventImages![
                                                                      1]
                                                                  .toString(),
                                                              90.h,
                                                              90.h),
                                                          customCardImageWithMore(
                                                              _edc
                                                                  .eventDetailModel
                                                                  .event!
                                                                  .preEventImages![
                                                                      2]
                                                                  .toString(),
                                                              90.h,
                                                              90.h,
                                                              _edc
                                                                      .eventDetailModel
                                                                      .event!
                                                                      .preEventImages!
                                                                      .length -
                                                                  3,
                                                              _edc
                                                                  .eventDetailModel
                                                                  .event!
                                                                  .preEventImages!)
                                                        ],
                                                      ),
                                      ),
                                      10.verticalSpace,
                                    ],
                                  ),
                            Text('location'.tr,
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
                                      _edc.eventDetailModel.event!.locationName
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14)),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            _edc.eventDetailModel.event!.location != null
                                ? Container(
                                    height: 0.25.sh,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: GoogleMap(
                                      mapType: MapType
                                          .normal, //  mapType: MapType.satellite,

                                      markers: Set<Marker>.of(
                                        <Marker>[
                                          Marker(
                                              draggable: true,
                                              markerId:
                                                  MarkerId("Event Location"),
                                              position: LatLng(
                                                  double.parse(
                                                    _edc.eventDetailModel.event!
                                                        .location!
                                                        .split(",")
                                                        .first
                                                        .trim(),
                                                  ),
                                                  double.parse(
                                                    _edc.eventDetailModel.event!
                                                        .location!
                                                        .split(",")
                                                        .last
                                                        .trim(),
                                                  )),
                                              icon: BitmapDescriptor
                                                  .defaultMarker,
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
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controller = controller;
                                      },
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            double.parse(
                                              _edc.eventDetailModel.event!
                                                  .location!
                                                  .split(",")
                                                  .first
                                                  .trim(),
                                            ),
                                            double.parse(
                                              _edc.eventDetailModel.event!
                                                  .location!
                                                  .split(",")
                                                  .last
                                                  .trim(),
                                            )),
                                        zoom: 12,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            20.verticalSpace,
                            _edc.relatedEventModelList.isEmpty
                                ? SizedBox()
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'moreEventsLikeThis'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () => Get.to(
                                                  () => SeeAllEventsScreen(
                                                      name: "Events",
                                                      img: '',
                                                      eventTypeId: "4.00"),
                                                  transition:
                                                      Transition.rightToLeft),
                                              child: Text(
                                                'seeAll'.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: kPrimaryColor),
                                              )),
                                        ],
                                      ),
                                      20.verticalSpace,
                                      CarouselSlider.builder(
                                          options: CarouselOptions(
                                              height: 0.45.sh,
                                              enlargeCenterPage: true,
                                              scrollDirection: Axis.horizontal,
                                              enableInfiniteScroll: false,
                                              viewportFraction: 0.8),
                                          itemCount:
                                              _edc.relatedEventModelList.length,
                                          itemBuilder: (BuildContext context,
                                              int itemIndex,
                                              int pageViewIndex) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(() => EventDetailScreen(
                                                      eventId: _edc
                                                          .relatedEventModelList[
                                                              itemIndex]
                                                          .eventId
                                                          .toString(),
                                                    ));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    color: Theme.of(context)
                                                        .secondaryHeaderColor),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      customCardImage(
                                                          _edc
                                                                  .relatedEventModelList[
                                                                      itemIndex]
                                                                  .postEventImages!
                                                                  .isNotEmpty
                                                              ? _edc
                                                                  .relatedEventModelList[
                                                                      itemIndex]
                                                                  .postEventImages![
                                                                      0]
                                                                  .toString()
                                                              : "null",
                                                          250.w,
                                                          160.h),
                                                      8.verticalSpace,
                                                      SizedBox(
                                                        width: 0.7.sw,
                                                        child: Text(
                                                          _edc
                                                              .relatedEventModelList[
                                                                  itemIndex]
                                                              .name
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      8.verticalSpace,
                                                      FittedBox(
                                                        child: Text(
                                                          splitDateTimeWithoutYear(_edc
                                                              .relatedEventModelList[
                                                                  itemIndex]
                                                              .eventDate
                                                              .toString()),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      ),
                                                      8.verticalSpace,
                                                      _edc
                                                                      .relatedEventModelList[
                                                                          itemIndex]
                                                                      .reviewRating !=
                                                                  null &&
                                                              (_edc
                                                                  .relatedEventModelList[
                                                                      itemIndex]
                                                                  .reviewRating is num)
                                                          ? SizedBox(
                                                              width: 0.5.sw,
                                                              child: RatingBar(
                                                                ignoreGestures:
                                                                    true,
                                                                itemSize: 22,
                                                                initialRating: _edc
                                                                    .relatedEventModelList[
                                                                        itemIndex]
                                                                    .reviewRating!
                                                                    .toDouble(),
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                ratingWidget:
                                                                    RatingWidget(
                                                                  full: Icon(
                                                                    Icons.star,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                  half: Icon(
                                                                    Icons
                                                                        .star_half,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                  empty: Icon(
                                                                    Icons
                                                                        .star_border,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                ),
                                                                itemPadding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            1.0),
                                                                onRatingUpdate:
                                                                    (rating) =>
                                                                        null,
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                      8.verticalSpace,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                color:
                                                                    kPrimaryColor,
                                                                size: 25,
                                                              ),
                                                              10.horizontalSpace,
                                                              SizedBox(
                                                                width: 0.4.sw,
                                                                child: Text(
                                                                  _edc
                                                                      .relatedEventModelList[
                                                                          itemIndex]
                                                                      .city
                                                                      .toString(),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    //color: Color(0xff616161)
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              String data = '';
                                                              if (_edc
                                                                      .relatedEventModelList[
                                                                          itemIndex]
                                                                      .isFav ==
                                                                  true) {
                                                                data =
                                                                    "?eventID=${_edc.relatedEventModelList[itemIndex].eventId!.toInt()}&fav=false&customerID=$userId";
                                                              } else {
                                                                data =
                                                                    "?eventID=${_edc.relatedEventModelList[itemIndex].eventId!.toInt()}&fav=true&customerID=$userId";
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
                                                                  _edc
                                                                      .relatedEventModelList[
                                                                          itemIndex]
                                                                      .isFav = true;
                                                                  _edc.update();
                                                                } else if (res
                                                                    .toUpperCase()
                                                                    .contains(
                                                                        "REMOVED")) {
                                                                  _edc
                                                                      .relatedEventModelList[
                                                                          itemIndex]
                                                                      .isFav = false;
                                                                  _edc.update();
                                                                }
                                                                customSnackBar(
                                                                    'alert'.tr,
                                                                    res);
                                                              }
                                                            },
                                                            child: Image.asset(
                                                              _edc.relatedEventModelList[itemIndex]
                                                                          .isFav ==
                                                                      true
                                                                  ? favoriteIconSelected
                                                                  : favoriteIcon,
                                                              color:
                                                                  kPrimaryColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                            80.verticalSpace
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
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                  onWillPop: () async => false, child: spinkit);
                            });
                        if (_eventDetailController
                            .eventDetailModel.eventTicketDetails!.isNotEmpty) {
                          _bookEventController.eventId =
                              int.parse(widget.eventId);
                          _bookEventController.eventName =
                              _edc.eventDetailModel.event!.name.toString();
                          _eventDetailController
                              .eventDetailModel.eventTicketDetails
                              ?.forEach((element) {
                            if (element.ticketType!
                                .toUpperCase()
                                .contains("ECO")) {
                              _bookEventController.economyPrice = 0.0;
                              // element.ticketPrice!.toDouble();
                              _bookEventController.baseEconomyPrice =
                                  element.ticketPrice!.toDouble();
                              _bookEventController.economyId =
                                  element.id?.toInt();
                            } else if (element.ticketType!
                                .toUpperCase()
                                .contains("VIP")) {
                              _bookEventController.vipPrice = 0.0;
                              //   element.ticketPrice!.toDouble();
                              _bookEventController.baseVipPrice =
                                  element.ticketPrice!.toDouble();
                              _bookEventController.vipId = element.id?.toInt();
                            }
                          });
                          if (_bookEventController.economyPrice == null ||
                              _bookEventController.vipPrice == null) {
                            Get.back();
                            customSnackBar('error'.tr, 'somethingWentWrong'.tr);
                          } else {
                            Get.back();
                            Get.to(() => BookEventScreen(),
                                transition: Transition.rightToLeft);
                          }
                        } else {
                          Get.back();
                          customSnackBar('error'.tr, 'somethingWentWrong'.tr);
                        }
                      },
                      child: customButton('bookEvent'.tr, kPrimaryColor),
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
                    image: AssetImage(eventPlaceholder), fit: BoxFit.cover),
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
                    image: AssetImage(eventPlaceholder), fit: BoxFit.cover),
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
                  image: AssetImage(eventPlaceholder), fit: BoxFit.cover),
            ),
          ); //AssetImage(placeholder)
  }

  customCardImageWithMore(String url, double width, double height,
      int remaining, List<String> preEventImages) {
    return url != "" && url != "null"
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                      () => GalleryScreen(
                            previousEventImages: preEventImages,
                          ),
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
                            image: imageProvider, fit: BoxFit.cover))),
              );
            },
            placeholder: (context, url) => GestureDetector(
              onTap: () {
                Get.to(
                    () => GalleryScreen(
                          previousEventImages: preEventImages,
                        ),
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
                          image: AssetImage(eventPlaceholder),
                          fit: BoxFit.cover))),
            ),
            errorWidget: (context, url, error) => GestureDetector(
              onTap: () {
                Get.to(
                    () => GalleryScreen(
                          previousEventImages: preEventImages,
                        ),
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
                          image: AssetImage(eventPlaceholder),
                          fit: BoxFit.cover))),
            ),
          )
        : GestureDetector(
            onTap: () {
              Get.to(
                  () => GalleryScreen(
                        previousEventImages: preEventImages,
                      ),
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
                  color: Colors.black.withOpacity(0.2),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.darken),
                      image: AssetImage(eventPlaceholder),
                      fit: BoxFit.cover)),
              child: Center(
                child: Text(
                  remaining.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
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
      setState(() {
        latitude = position?.latitude.toString();
        longitude = position?.longitude.toString();
      });
    }
  }

  String limitStringLength(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength);
    }
  }

  reviewsBottomSheet(BuildContext context, EventDetailController _edc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  5.verticalSpace,
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: kDisabledColor.withOpacity(0.6)),
                  ),
                  20.verticalSpace,
                  _edc.eventReviewList.isEmpty
                      ? Center(
                          child: Text(
                            'notFound'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 0.5.sh,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _edc.eventReviewList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 0.4.sw,
                                          child: Text(
                                            _edc.eventReviewList[index].userName
                                                .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        10.horizontalSpace,
                                        _edc.eventReviewList[index].rating !=
                                                    null &&
                                                (_edc.eventReviewList[index]
                                                    .rating is num)
                                            ? SizedBox(
                                                width: 0.4.sw,
                                                child: Column(children: [
                                                  RatingBar(
                                                    ignoreGestures: true,
                                                    itemSize: 25,
                                                    initialRating: _edc
                                                        .eventReviewList[index]
                                                        .rating!
                                                        .toDouble(),
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    ratingWidget: RatingWidget(
                                                      full: Icon(
                                                        Icons.star,
                                                        color: kPrimaryColor,
                                                      ),
                                                      half: Icon(
                                                        Icons.star_half,
                                                        color: kPrimaryColor,
                                                      ),
                                                      empty: Icon(
                                                        Icons.star_border,
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.0),
                                                    onRatingUpdate: (rating) =>
                                                        null,
                                                  ),
                                                ]))
                                            : SizedBox()
                                      ]),
                                  5.verticalSpace,
                                  Text(
                                    _edc.eventReviewList[index].description
                                        .toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  5.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        splitDateForNews(_edc
                                            .eventReviewList[index].createDate
                                            .toString()),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.verticalSpace,
                                  _edc.eventReviewList.length == index + 1
                                      ? SizedBox()
                                      : Divider(
                                          color: Colors.grey,
                                        ),
                                ],
                              );
                            },
                          ),
                        ),
                  20.verticalSpace
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ReadMoreWidget extends StatefulWidget {
  final String text;
  final int maxLines;

  ReadMoreWidget({required this.text, this.maxLines = 2});

  @override
  _ReadMoreWidgetState createState() => _ReadMoreWidgetState();
}

class _ReadMoreWidgetState extends State<ReadMoreWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(text: widget.text);
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: isExpanded ? null : widget.maxLines,
                text: TextSpan(
                  text: widget.text,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.background),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'showLess'.tr : 'readMore'.tr,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }

        return RichText(
          text: TextSpan(
            text: widget.text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.background),
          ),
        );
      },
    );
  }
}
