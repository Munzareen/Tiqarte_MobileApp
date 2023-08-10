import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/images.dart';

class LinkedAccountScreen extends StatefulWidget {
  const LinkedAccountScreen({super.key});

  @override
  State<LinkedAccountScreen> createState() => _LinkedAccountScreenState();
}

class _LinkedAccountScreenState extends State<LinkedAccountScreen> {
  bool isGoogleEnable = true;
  bool isFacebookEnable = false;
  bool isAppleEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          //  backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            height: 1.sh,
            width: 1.sw,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
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
                          'linkedAccounts'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(googleIcon),
                            10.horizontalSpace,
                            Text('google'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track,
                            // thumb,
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              // setState(
                              //   () {
                              //     isGoogleEnable = value;
                              //   },
                              // );
                            },
                            value: isGoogleEnable,
                          ),
                        )
                      ],
                    ),
                    Platform.isIOS
                        ? Column(
                            children: [
                              20.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(appleIcon),
                                      10.horizontalSpace,
                                      Text('apple'.tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                  Transform.scale(
                                    scale: 0.7,
                                    child: CupertinoSwitch(
                                      // track,
                                      // thumb,
                                      activeColor: kPrimaryColor,
                                      onChanged: (value) {
                                        // setState(
                                        //   () {
                                        //     isAppleEnable = value;
                                        //   },
                                        // );
                                      },
                                      value: isAppleEnable,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : SizedBox(),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(facebookIcon),
                            10.horizontalSpace,
                            Text('facebook'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            // track,
                            // thumb,
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              // setState(
                              //   () {
                              //     isFacebookEnable = value;
                              //   },
                              // );
                            },
                            value: isFacebookEnable,
                          ),
                        )
                      ],
                    ),
                  ]),
                ))));
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
  //               // track,
  //               // thumb,
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
