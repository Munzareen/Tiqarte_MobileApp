import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/notificationController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _notificationController = Get.put(NotificationController());
  List notificationList = [
    {
      "icon": Icons.calendar_month,
      "color": kPrimaryColor,
      "title": "Booking Successful!",
      "date": "20 Dec, 2022",
      "time": "20:49 PM",
      "isNew": true,
      "body":
          "You have successfully booked the Art Workshops. The event will be held on Sunday, December 22, 2022, 13.00 - 14.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
    {
      "icon": Icons.person,
      "color": Color(0xff22BB9C),
      "title": "Account Setup Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "isNew": true,
      "body":
          "Your account creation is successful, you can now experience our services."
    },
    {
      "icon": Icons.airplane_ticket,
      "color": kSecondaryColor,
      "title": "New Services Available!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "isNew": false,
      "body":
          "You have successfully booked the National Music Festival. The event will be held on Monday, December 24, 2022, 18.00 - 23.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
    {
      "icon": Icons.calendar_month,
      "color": kPrimaryColor,
      "title": "Booking Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "isNew": false,
      "body":
          "You have successfully booked the Art Workshops. The event will be held on Sunday, December 22, 2022, 13.00 - 14.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
    {
      "icon": Icons.calendar_month,
      "color": kPrimaryColor,
      "title": "Booking Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "isNew": false,
      "body":
          "You have successfully booked the Art Workshops. The event will be held on Sunday, December 22, 2022, 13.00 - 14.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
    {
      "icon": Icons.calendar_month,
      "color": kPrimaryColor,
      "title": "Booking Successful!",
      "date": "12 Dec, 2022",
      "time": "20:49 PM",
      "isNew": false,
      "body":
          "You have successfully booked the Art Workshops. The event will be held on Sunday, December 22, 2022, 13.00 - 14.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getNotifications();
    if (res != null && res is List) {
      _notificationController.addNotifications(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kSecondBackgroundColor,
      // appBar: AppBar(
      //   toolbarHeight: 0,
      //   //  backgroundColor: kSecondBackgroundColor,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      // ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'notification'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: GetBuilder<NotificationController>(builder: (_nc) {
            return _nc.notificationList == null
                ? Center(
                    child: spinkit,
                  )
                : _nc.notificationList!.isEmpty
                    ? ListView(
                        children: [
                          SizedBox(
                            height: 0.1.sh,
                          ),
                          Image.asset(
                            noNotificationImage,
                            height: 300,
                          ),
                          20.verticalSpace,
                          Text(
                            'empty'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.verticalSpace,
                          FittedBox(
                            child: Text(
                              'notificationSubSrting'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          20.verticalSpace,
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _nc.notificationList?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              customProfileImage(
                                                  _nc.notificationList![index]
                                                      .iconURL
                                                      .toString(),
                                                  60,
                                                  60),
                                              // Container(
                                              //   height: 60,
                                              //   width: 60,
                                              //   decoration: BoxDecoration(
                                              //       color:
                                              //           notificationList[
                                              //                       index]
                                              //                   ['color']
                                              //               .withOpacity(
                                              //                   0.3),
                                              //       borderRadius:
                                              //           BorderRadius
                                              //               .circular(
                                              //                   50.0)),
                                              //   child: Icon(
                                              //     notificationList[index]
                                              //         ['icon'],
                                              //     color: notificationList[
                                              //         index]['color'],
                                              //   ),
                                              // ),
                                              10.horizontalSpace,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 0.5.sw,
                                                    child: Text(
                                                      _nc
                                                          .notificationList![
                                                              index]
                                                          .notificationHeader
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  5.verticalSpace,
                                                  Row(
                                                    children: [
                                                      FittedBox(
                                                        child: Text(
                                                          splitDateOnly(_nc
                                                              .notificationList![
                                                                  index]
                                                              .creationTime
                                                              .toString()),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    5.0),
                                                        height: 15,
                                                        width: 1,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                kDisabledColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                      ),
                                                      FittedBox(
                                                        child: Text(
                                                          splitTimeOnly(
                                                            _nc
                                                                .notificationList![
                                                                    index]
                                                                .creationTime
                                                                .toString(),
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          _nc.notificationList![index].isRead ==
                                                  false
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10.0),
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13.0)),
                                                  child: Text(
                                                    "New",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Text(
                                        _nc.notificationList![index]
                                            .notificationText
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
          }),
        ),
      ),
    );
  }
}
