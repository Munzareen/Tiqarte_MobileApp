import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/MainScreen.dart';
import 'package:tiqarte/view/WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  getPrefs() async {
    if (prefs == null) {
      await initializePrefs();
    }

    accessToken = prefs?.getString("accessToken") ?? '';
    userName = prefs?.getString("userName") ?? '';
    userImage = prefs?.getString("userImage") ?? '';
    userEmail = prefs?.getString("userEmail") ?? '';
    userId = prefs?.getString("userId") ?? '';
    userNickname = prefs?.getString("userNickname") ?? '';
    userDob = prefs?.getString("userDob") ?? '';
    userState = prefs?.getString("userState") ?? '';
    userCity = prefs?.getString("userCity") ?? '';
    userZipcode = prefs?.getString("userZipcode") ?? '';
    userCountrycode = prefs?.getString("userCountrycode") ?? '';
    userNumber = prefs?.getString("userNumber") ?? '';
    userGender = prefs?.getString("userGender") ?? '';

    if (accessToken.isNotEmpty) {
      Timer(Duration(seconds: 2), () {
        Get.offAll(() => MainScreen(), transition: Transition.rightToLeft);
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Get.offAll(() => WelcomeScreen(), transition: Transition.rightToLeft);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        child: Stack(
          children: [
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  appLogo,
                  height: 70.h,
                ),
                20.horizontalSpace,
                Text(
                  "Tiqarte",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )),
            Positioned(bottom: 150, width: 1.sw, child: spinkit)
          ],
        ),
      ),
    );
  }
}
