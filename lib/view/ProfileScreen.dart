import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/EditProfileScreen.dart';
import 'package:tiqarte/view/HelpCenterScreen.dart';
import 'package:tiqarte/view/InviteFriendScreen.dart';
import 'package:tiqarte/view/LanguageScreen.dart';
import 'package:tiqarte/view/LinkedAccountScreen.dart';
import 'package:tiqarte/view/NotificationSettingScreen.dart';
import 'package:tiqarte/view/SecurityScreen.dart';
import 'package:tiqarte/view/ViewPaymentsScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: kSecondBackgroundColor,
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
                        height: 20,
                      ),
                      20.horizontalSpace,
                      Text(
                        profile,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Icon(
                      Icons.more_horiz_sharp,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                ],
              ),
              30.verticalSpace,
              customProfileImage(profileImage, 110.h, 110.h),
              20.verticalSpace,
              Text(
                "Andrew Ainsley",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              20.verticalSpace,
              Expanded(
                  child: ListView(
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "12",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            5.verticalSpace,
                            Text(
                              events,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff616161)),
                            ),
                          ],
                        ),
                        Container(
                          height: 50.h,
                          width: 0.5.w,
                          color: kDisabledColor,
                        ),
                        Column(
                          children: [
                            Text(
                              "7,389",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            5.verticalSpace,
                            Text(
                              followers,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff616161)),
                            ),
                          ],
                        ),
                        Container(
                          height: 50.h,
                          width: 0.5.w,
                          color: kDisabledColor,
                        ),
                        Column(
                          children: [
                            Text(
                              "125",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            5.verticalSpace,
                            Text(
                              following,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff616161)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  20.verticalSpace,
                  customRow(calendarIcon, manageEvents),
                  20.verticalSpace,
                  customRow(messageCenterIcon, messageCenter),
                  20.verticalSpace,
                  Divider(),
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
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SecurityScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: customRow(securityIcon, security),
                  ),
                  20.verticalSpace,
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
                            Image.asset(
                              languageIcon,
                              height: 28,
                              color: Colors.black,
                            ),
                            10.horizontalSpace,
                            Text(
                              language,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
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
                                  color: Colors.black),
                            ),
                            10.horizontalSpace,
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.black,
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
                            color: Colors.black,
                          ),
                          10.horizontalSpace,
                          Text(
                            darkMode,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          activeColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(
                              () {
                                isDarkMode = value;
                              },
                            );
                          },
                          value: isDarkMode,
                        ),
                      )
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
                  Row(
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
            Image.asset(
              iconImage,
              height: 28,
              color: Colors.black,
            ),
            10.horizontalSpace,
            Text(
              name,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
          size: 30,
        )
      ],
    );
  }
}
