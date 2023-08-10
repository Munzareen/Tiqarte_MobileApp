import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/colors.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool isRememberMe = false;
  bool isFaceID = true;
  bool isBiometricID = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          //      backgroundColor: kSecondBackgroundColor,
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
                        'security'.tr,
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('rememberMe'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                )),
                            Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                // trackColor: Colors.black,
                                // thumbColor: Colors.black,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      isRememberMe = value;
                                    },
                                  );
                                },
                                value: isRememberMe,
                              ),
                            )
                          ],
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('faceID'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                )),
                            Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                // trackColor: Colors.black,
                                // thumbColor: Colors.black,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      isFaceID = value;
                                    },
                                  );
                                },
                                value: isFaceID,
                              ),
                            )
                          ],
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('biometricID'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                )),
                            Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                // trackColor: Colors.black,
                                // thumbColor: Colors.black,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      isBiometricID = value;
                                    },
                                  );
                                },
                                value: isBiometricID,
                              ),
                            )
                          ],
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'googleAuthenticator'.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 30,
                            )
                          ],
                        ),
                        30.verticalSpace,
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 25.0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text('changePIN'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        20.verticalSpace,
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 25.0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text('changePassword'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ))
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
  //               style: const TextStyle(fontSize: 18, color: Colors.black)),
  //           Transform.scale(
  //             scale: 0.7,
  //             child: CupertinoSwitch(
  //               // trackColor: Colors.black,
  //               // thumbColor: Colors.black,
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
