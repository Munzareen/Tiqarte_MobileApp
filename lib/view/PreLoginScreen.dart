import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/AccountSetupScreen.dart';
import 'package:tiqarte/view/CreateAccountScreen.dart';
import 'package:tiqarte/view/LoginScreen.dart';
import 'package:tiqarte/view/MainScreen.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  State<PreLoginScreen> createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        //   backgroundColor: kSecondBackgroundColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
            )),
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(preLoginLogo),
              30.verticalSpace,
              Text(
                preLoginHeadingString,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.verticalSpace,
              GestureDetector(
                // onTap: () => Get.to(() => MainScreen(),
                //     transition: Transition.rightToLeft),
                child: Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: kDisabledColor,
                        width: 1,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(facebookIcon),
                      10.horizontalSpace,
                      Text(
                        preLoginFacebookString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {
                  ApiService().googleSignIn(context);
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: kDisabledColor,
                        width: 1,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(googleIcon),
                      10.horizontalSpace,
                      Text(
                        preLoginGoogleString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              Platform.isIOS
                  ? Column(
                      children: [
                        20.verticalSpace,
                        GestureDetector(
                          // onTap: () => Get.to(() => MainScreen(),
                          //     transition: Transition.rightToLeft),
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 25.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: kDisabledColor,
                                  width: 1,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(appleIcon),
                                10.horizontalSpace,
                                Text(
                                  preLoginAppleString,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              // 30.verticalSpace,
              // Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //     child: Row(children: <Widget>[
              //       Expanded(child: Divider()),
              //       10.horizontalSpace,
              //       Text(
              //         preLoginOrString,
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Color(0xff616161)),
              //       ),
              //       10.horizontalSpace,
              //       Expanded(child: Divider()),
              //     ])),
              // 30.verticalSpace,
              // InkWell(
              //   onTap: () {
              //     Get.to(() => LoginScreen(),
              //         transition: Transition.rightToLeft);
              //   },
              //   child: customButton(preLoginButtonString, kPrimaryColor),
              // ),
              // 30.verticalSpace,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       preLoginDontHaveAccountString,
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w300,
              //           color: Color(0xff9E9E9E)),
              //     ),
              //     5.horizontalSpace,
              //     TextButton(
              //       child: Text(preLoginSignUpString,
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600,
              //               color: kPrimaryColor)),
              //       onPressed: () {
              //         Get.to(() => CreateAccountScreen(),
              //             transition: Transition.rightToLeft);
              //       },
              //     ),
              //   ],
              // ),
              // 30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
