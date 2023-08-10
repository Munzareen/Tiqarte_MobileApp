import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool isSoundEnable = false;
  bool isPurchaseTicket = true;
  bool isLikedEvents = false;
  bool isFollowedOrganizer = true;
  bool isSpecialOffer = false;
  bool isPayments = true;
  bool isReminders = true;
  bool isRecommendations = true;
  bool isAppUpdates = true;
  bool isNewServiceAvailable = false;
  bool isNewTipsAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //   backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          //    backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            height: 1.sh,
            width: 1.sw,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(children: [
                  20.verticalSpace,
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back)),
                      20.horizontalSpace,
                      Text(
                        'notification'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('EnableSoundVibrate'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isSoundEnable = value;
                                },
                              );
                            },
                            value: isSoundEnable,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('purchasedTickets'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isPurchaseTicket = value;
                                },
                              );
                            },
                            value: isPurchaseTicket,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('likedEvents'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isLikedEvents = value;
                                },
                              );
                            },
                            value: isLikedEvents,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('followedOrganizer'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isFollowedOrganizer = value;
                                },
                              );
                            },
                            value: isFollowedOrganizer,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('specialOffers'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isSpecialOffer = value;
                                },
                              );
                            },
                            value: isSpecialOffer,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('payment'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isPayments = value;
                                },
                              );
                            },
                            value: isPayments,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('reminders'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isReminders = value;
                                },
                              );
                            },
                            value: isReminders,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('recommendations'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isRecommendations = value;
                                },
                              );
                            },
                            value: isRecommendations,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('appUpdates'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isAppUpdates = value;
                                },
                              );
                            },
                            value: isAppUpdates,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('newServiceAvailable'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isNewServiceAvailable = value;
                                },
                              );
                            },
                            value: isNewServiceAvailable,
                          ),
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('newTipsAvailable'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track
                            // thumb
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isNewTipsAvailable = value;
                                },
                              );
                            },
                            value: isNewTipsAvailable,
                          ),
                        )
                      ],
                    ),
                  ])))
                ]))));
  }

  // customRow(String name, bool onOff) {
  //   return Container(
  //     height: 45.h,
  //     width: 0.9.sw,
  //     decoration: BoxDecoration(
  //         color: kSecondaryColor, borderRadius: BorderRadius.circular(12.0)),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(name,
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(fontSize: 18, )),
  //           Transform.scale(
  //             scale: 0.7,
  //             child: CupertinoSwitch(
  //               // track
  //               // thumb
  //               activeColor: kPrimaryColor,
  //               onChanged: (value) {
  //                 setState(
  //                   () {
  //                       isSoun = value;

  //                   },
  //                 );
  //               },
  //               value: onOff,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
