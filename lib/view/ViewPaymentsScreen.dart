import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/AddCardScreen.dart';

class ViewPaymentsScreen extends StatefulWidget {
  const ViewPaymentsScreen({super.key});

  @override
  State<ViewPaymentsScreen> createState() => _ViewPaymentsScreenState();
}

class _ViewPaymentsScreenState extends State<ViewPaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: kSecondBackgroundColor,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back)),
                        10.horizontalSpace,
                        Text(
                          'payments'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(scanIcon),
                  ],
                ),
                40.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: customRow(paypalIcon, 'payPal'.tr),
                        ),
                        20.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: customRow(googleIcon, 'googlePay'.tr),
                        ),
                        Platform.isIOS
                            ? Column(
                                children: [
                                  20.verticalSpace,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 15.0),
                                    child: customRow(appleIcon, 'applePay'.tr),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        20.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child:
                              customRow(cardLogo, "•••• •••• •••• •••• 4679"),
                        ),
                        20.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child:
                              customRow(cardLogo, "•••• •••• •••• •••• 2766"),
                        ),
                        20.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child:
                              customRow(cardLogo, "•••• •••• •••• •••• 3892"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: 1.sw,
          color: Theme.of(context).secondaryHeaderColor,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: GestureDetector(
                  onTap: () {
                    Get.to(() => AddCardScreen(),
                        transition: Transition.rightToLeft);
                  },
                  child: customButton('addNewCard'.tr, kPrimaryColor))),
        ));
  }

  customRow(String img, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(img),
            15.horizontalSpace,
            Text(
              name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          'connected'.tr,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
      ],
    );
  }
}
