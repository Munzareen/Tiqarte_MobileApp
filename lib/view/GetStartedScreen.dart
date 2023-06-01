import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/PreLoginScreen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    backgroundColor: Color(0xffF5F5F5),
      body: Container(
          height: 1.sh,
          width: 1.sw,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  80.verticalSpace,
                  Container(
                    //  height: 380,
                    // width: 280,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage(
                              backgroundLogo,
                            ),
                            fit: BoxFit.contain)),
                    child: Image.asset(
                      index == 0
                          ? getStartedGirl1
                          : index == 1
                              ? getStartedGirl2
                              : getStartedGirl3,
                      height: 400,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                      // height: 0.39.sh,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0))),
                      child: Builder(builder: (context) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                index == 0
                                    ? getStarted1HeadingString
                                    : index == 1
                                        ? getStarted2HeadingString
                                        : getStarted3HeadingString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ),
                              20.verticalSpace,
                              Text(
                                index == 0
                                    ? getStarted1SubString
                                    : index == 1
                                        ? getStarted2SubString
                                        : getStarted3SubString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              20.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: index == 0 ? 30 : 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: index == 0
                                            ? kPrimaryColor
                                            : Color(0xffE0E0E0)),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    height: 10,
                                    width: index == 1 ? 30 : 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: index == 1
                                            ? kPrimaryColor
                                            : Color(0xffE0E0E0)),
                                  ),
                                  Container(
                                    height: 10,
                                    width: index == 2 ? 30 : 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: index == 2
                                            ? kPrimaryColor
                                            : Color(0xffE0E0E0)),
                                  ),
                                ],
                              ),
                              20.verticalSpace,
                              GestureDetector(
                                  onTap: () {
                                    if (index != 2) {
                                      _pageController.nextPage(
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeIn);
                                    } else {
                                      Get.to(() => PreLoginScreen(),
                                          transition: Transition.rightToLeft);
                                    }
                                  },
                                  child: customButton(
                                      index == 0
                                          ? getStarted1ButtonString
                                          : index == 1
                                              ? getStarted2ButtonString
                                              : getStarted3ButtonString,
                                      kPrimaryColor)),
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
