import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/MainScreen.dart';

class ViewETicketScreen extends StatefulWidget {
  const ViewETicketScreen({super.key});

  @override
  State<ViewETicketScreen> createState() => _ViewETicketScreenState();
}

class _ViewETicketScreenState extends State<ViewETicketScreen> {
  @override
  Widget build(BuildContext context) {
    //      onWillPop: onWillPop,

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
          child: Column(
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
                      Text(
                        eTicket,
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
              Expanded(
                  child: ListView(
                children: [
                  20.verticalSpace,
                  Container(
                    width: 1.sw,
                    child: Image.asset(
                      qrImage,
                      height: 300,
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
                        customColumn(event, "National Music Festival"),
                        15.verticalSpace,
                        customColumn(
                            dateAndHour, "Monday, Dec 24 • 18.00 - 23.00 PM"),
                        15.verticalSpace,
                        customColumn(
                            eventLocation, "Grand Park, New York City, US"),
                        15.verticalSpace,
                        customColumn(eventOrganizer, "World of Music"),
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
                        customRow(fullName, "Andrew Ainsley"),
                        10.verticalSpace,
                        customRow(nickName, "Andrew"),
                        10.verticalSpace,
                        customRow(gender, "Male"),
                        10.verticalSpace,
                        customRow(dateOfBirth, "12/27/1995"),
                        10.verticalSpace,
                        customRow(country, "Andrew Ainsley"),
                        10.verticalSpace,
                        customRow(phone, "+1 111 467 378 399"),
                        10.verticalSpace,
                        customRow(email, "andrew_ainsley@yo...com"),
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
                        customRow(tax, "\$5.00"),
                        10.verticalSpace,
                        Divider(
                          color: kDisabledColor,
                        ),
                        10.verticalSpace,
                        customRow(total, "\$55.00"),
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
                        customRow(paymentMethods, "MasterCard"),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              orderID,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "5457383979",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                5.horizontalSpace,
                                GestureDetector(
                                  onTap: () async {
                                    await Clipboard.setData(
                                        ClipboardData(text: "5457383979"));
                                  },
                                  child: Image.asset(
                                    copyIcon,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              status,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1.5)),
                              child: Text(
                                paid,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  90.verticalSpace,
                ],
              )),
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
                Get.offAll(() => MainScreen(),
                    transition: Transition.leftToRight);
              },
              child: customButton(downloadTicket, kPrimaryColor),
            )),
      ),
    );
  }

  customRow(String name, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Text(
          data,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  customColumn(String name, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        10.verticalSpace,
        Text(
          data,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Future<bool> onWillPop() {
    Get.offAll(() => MainScreen(), transition: Transition.leftToRight);

    return Future.value(false);
  }
}
