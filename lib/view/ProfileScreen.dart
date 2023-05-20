import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/CreateAccountScreen.dart';
import 'package:tiqarte/view/EditProfileScreen.dart';
import 'package:tiqarte/view/HelpCenterScreen.dart';
import 'package:tiqarte/view/InviteFriendScreen.dart';
import 'package:tiqarte/view/LanguageScreen.dart';
import 'package:tiqarte/view/LinkedAccountScreen.dart';
import 'package:tiqarte/view/LoginScreen.dart';
import 'package:tiqarte/view/NotificationSettingScreen.dart';
import 'package:tiqarte/view/OtpVerificationScreen.dart';
import 'package:tiqarte/view/PreLoginScreen.dart';
import 'package:tiqarte/view/SecurityScreen.dart';
import 'package:tiqarte/view/ViewPaymentsScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        //backgroundColor: kSecondBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        appLogo,
                        height: 25.h,
                      ),
                      20.horizontalSpace,
                      Text(
                        profile,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.background),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Icon(
                      Icons.more_horiz_sharp,
                      size: 25,
                    ),
                  )
                ],
              ),
              30.verticalSpace,
              customProfileImage(userImage, 110.h, 110.h),
              20.verticalSpace,
              Text(
                userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.verticalSpace,
              Expanded(
                  child: ListView(
                children: [
                  Divider(
                    color: kDisabledColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.h,
                          width: 0.5.w,
                          color: kDisabledColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Text(
                                "12",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              5.verticalSpace,
                              Text(
                                events,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        // Column(
                        //   children: [
                        //     Text(
                        //       "7,389",
                        //       textAlign: TextAlign.start,
                        //       style: TextStyle(
                        //           fontSize: 32,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black),
                        //     ),
                        //     5.verticalSpace,
                        //     Text(
                        //       followers,
                        //       textAlign: TextAlign.start,
                        //       style: TextStyle(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.bold,
                        //           color: Color(0xff616161)),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          height: 50.h,
                          width: 0.5.w,
                          color: kDisabledColor,
                        ),
                        // Column(
                        //   children: [
                        //     Text(
                        //       "125",
                        //       textAlign: TextAlign.start,
                        //       style: TextStyle(
                        //           fontSize: 32,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black),
                        //     ),
                        //     5.verticalSpace,
                        //     Text(
                        //       following,
                        //       textAlign: TextAlign.start,
                        //       style: TextStyle(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.bold,
                        //           color: Color(0xff616161)),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Divider(
                    color: kDisabledColor,
                  ),
                  20.verticalSpace,
                  customRow(calendarIcon, manageEvents),
                  20.verticalSpace,
                  customRow(messageCenterIcon, messageCenter),
                  20.verticalSpace,
                  Divider(
                    color: kDisabledColor,
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => EditProfileScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: customRow(profileIcon, profile),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => NotificationSettingScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: customRow(notificationIcon, notification),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ViewPaymentsScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: customRow(paymentIcon, payments),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => LinkedAccountScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: customRow(linkedAccountIcon, linkedAccounts),
                  ),
                  20.verticalSpace,
                  customRow(ticketIcon, ticketIssues),
                  20.verticalSpace,
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(() => SecurityScreen(),
                  //         transition: Transition.rightToLeft);
                  //   },
                  //   child: customRow(securityIcon, security),
                  // ),
                  // 20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => LanguageScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(languageIcon,
                                height: 28,
                                color:
                                    Theme.of(context).colorScheme.background),
                            10.horizontalSpace,
                            Text(
                              language,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "English (US)",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            10.horizontalSpace,
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            darkModeIcon,
                            height: 28,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          10.horizontalSpace,
                          Text(
                            darkMode,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      ObxValue(
                        (data) => Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: kPrimaryColor,
                            onChanged: (val) {
                              isDarkTheme.value = val;

                              Get.changeThemeMode(
                                //ThemeMode.dark

                                isDarkTheme.value
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                              );

                              // setState(
                              //   () {
                              //     isDarkMode = value;
                              //   },
                              // );
                            },
                            value: isDarkTheme.value,
                          ),
                        ),
                        false.obs,
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => HelpCenterScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: customRow(helpCenterIcon, helpCenter),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => InviteFriendsScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: customRow(inviteFriendsIcon, inviteFriends),
                  ),
                  20.verticalSpace,
                  customRow(rateUsIcon, rateUs),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      logoutSheet(context);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          logoutIcon,
                          height: 28,
                          color: Color(0xffF75555),
                        ),
                        10.horizontalSpace,
                        Text(
                          logout,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffF75555)),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              20.verticalSpace
            ],
          ),
        ),
      ),
    );
  }

  customRow(String iconImage, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(iconImage,
                height: 28, color: Theme.of(context).colorScheme.background),
            10.horizontalSpace,
            Text(
              name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right_outlined,
          size: 30,
        )
      ],
    );
  }

  logoutSheet(BuildContext context) {
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
                  15.verticalSpace,
                  Text(
                    logout,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF75555)),
                  ),
                  Divider(),
                  10.verticalSpace,
                  Text(
                    logoutSub,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 55,
                          width: 0.4.sw,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(cancel,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      20.horizontalSpace,
                      InkWell(
                        onTap: () {
                          Get.back();
                          Get.offAll(() => PreLoginScreen(),
                              transition: Transition.leftToRight);
                        },
                        child: Container(
                          height: 55,
                          width: 0.4.sw,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(yesLogout,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
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
