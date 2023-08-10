import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/AddCardScreen.dart';
import 'package:tiqarte/view/PaymentPinScreen.dart';

class ReviewSummaryScreen extends StatefulWidget {
  const ReviewSummaryScreen({super.key});

  @override
  State<ReviewSummaryScreen> createState() => _ReviewSummaryScreenState();
}

class _ReviewSummaryScreenState extends State<ReviewSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          // backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.verticalSpace,
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.arrow_back)),
                      10.horizontalSpace,
                      Text(
                        'reviewSummary'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).secondaryHeaderColor),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          customCardImage(eventImage, 110.h, 110.h),
                          8.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  "National Music Festival",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              8.verticalSpace,
                              FittedBox(
                                child: Text(
                                  "Mon, Dec 24 • 18.00 - 23.00 PM",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: kPrimaryColor),
                                ),
                              ),
                              8.verticalSpace,
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: kPrimaryColor,
                                      size: 25,
                                    ),
                                    5.horizontalSpace,
                                    Text(
                                      "Grand Park, New York",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).secondaryHeaderColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRow('fullName'.tr, "Andrew Ainsley"),
                        10.verticalSpace,
                        customRow('phone'.tr, "+1 111 467 378 399"),
                        10.verticalSpace,
                        customRow('email'.tr, "andrew_ainsley@yo...com"),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRow("1 Seats (Economy)", "\$50.00"),
                        10.verticalSpace,
                        customRow('tax'.tr, "\$5.00"),
                        10.verticalSpace,
                        Divider(
                          color: kDisabledColor,
                        ),
                        10.verticalSpace,
                        customRow('total'.tr, "\$55.00"),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(cardLogo),
                            15.horizontalSpace,
                            Text(
                              "•••• •••• •••• •••• 4679",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AddCardScreen(),
                                transition: Transition.rightToLeft);
                          },
                          child: Text(
                            'change'.tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                    Get.to(() => PaymentPinScreen(),
                        transition: Transition.rightToLeft);
                  },
                  child: customButton('continueButton'.tr, kPrimaryColor))),
        ));
  }

  customRow(String name, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        Text(
          data,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
