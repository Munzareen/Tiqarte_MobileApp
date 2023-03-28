import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notificationList = [
    {
      "icon": Icons.calendar_month,
      "color": kPrimaryColor,
      "title": "Booking Successful!",
      "date": "20 Dec, 2022",
      "time": "20:49 PM",
      "isNew": true,
      "body":
          "You have successfully booked the Art Workshops. The event will be held on Sunday, December 22, 2022, 13.00 - 14.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
    {
      "icon": Icons.person,
      "color": Color(0xff22BB9C),
      "title": "Account Setup Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "isNew": true,
      "body":
          "Your account creation is successful, you can now experience our services."
    },
    {
      "icon": Icons.airplane_ticket,
      "color": kSecondaryColor,
      "title": "New Services Available!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "isNew": false,
      "body":
          "You have successfully booked the National Music Festival. The event will be held on Monday, December 24, 2022, 18.00 - 23.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
    {
      "icon": Icons.calendar_month,
      "color": kPrimaryColor,
      "title": "Booking Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "isNew": false,
      "body":
          "You have successfully booked the Art Workshops. The event will be held on Sunday, December 22, 2022, 13.00 - 14.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
    {
      "icon": Icons.calendar_month,
      "color": kPrimaryColor,
      "title": "Booking Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "isNew": false,
      "body":
          "You have successfully booked the Art Workshops. The event will be held on Sunday, December 22, 2022, 13.00 - 14.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
    {
      "icon": Icons.calendar_month,
      "color": kPrimaryColor,
      "title": "Booking Successful!",
      "date": "12 Dec, 2022",
      "time": "20:49 PM",
      "isNew": false,
      "body":
          "You have successfully booked the Art Workshops. The event will be held on Sunday, December 22, 2022, 13.00 - 14.00 PM. Don't forget to activate your reminder. Enjoy the event!"
    },
  ];

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
                        notificationHeadingSrting,
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
              20.verticalSpace,
              notificationList.isEmpty
                  ? Expanded(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 0.1.sh,
                          ),
                          Image.asset(
                            noNotificationImage,
                            height: 300,
                          ),
                          20.verticalSpace,
                          Text(
                            notificationEmptySrting,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          10.verticalSpace,
                          FittedBox(
                            child: Text(
                              notificationSubSrting,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: notificationList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: notificationList[index]
                                                      ['color']
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          child: Icon(
                                            notificationList[index]['icon'],
                                            color: notificationList[index]
                                                ['color'],
                                          ),
                                        ),
                                        10.horizontalSpace,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 0.5.sw,
                                              child: Text(
                                                notificationList[index]
                                                    ['title'],
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            5.verticalSpace,
                                            Row(
                                              children: [
                                                FittedBox(
                                                  child: Text(
                                                    notificationList[index]
                                                        ['date'],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color:
                                                            Color(0xff616161)),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                                  height: 15,
                                                  width: 1,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff616161),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    notificationList[index]
                                                        ['time'],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff616161)),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    notificationList[index]['isNew'] == true
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                            decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        13.0)),
                                            child: Text(
                                              "New",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                                10.verticalSpace,
                                Text(
                                  notificationList[index]['body'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff616161)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
