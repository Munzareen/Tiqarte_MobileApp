import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/ImagePreviewDialog.dart';

class OrganizerProfileScreen extends StatefulWidget {
  const OrganizerProfileScreen({super.key});

  @override
  State<OrganizerProfileScreen> createState() => _OrganizerProfileScreenState();
}

class _OrganizerProfileScreenState extends State<OrganizerProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  List eventList = [
    {
      "id": "1",
      "name": "International Concert",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": true,
      "isFree": true
    },
    {
      "id": "2",
      "name": "Jazz Music Festival",
      "date": "Tue, Dec 19 • 19.00 - 22.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
      "isFree": false
    },
    {
      "id": "3",
      "name": "DJ Music Competition",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "Central Park, Ne...",
      "isFavorite": false,
      "isFree": true
    },
    {
      "id": "4",
      "name": "National Music Fest",
      "date": "Sun, Dec 16 • 11.00 - 13.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": true,
      "isFree": false
    },
    {
      "id": "5",
      "name": "Art Workshops",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
      "isFree": true
    },
    {
      "id": "6",
      "name": "Tech Seminar",
      "date": "Sat, Dec 22 • 10.00 - 12.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
      "isFree": false
    },
    {
      "id": "7",
      "name": "Mural Painting",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "isFavorite": false,
      "isFree": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        //toolbarHeight: 0,
        backgroundColor: kSecondBackgroundColor,
        title: Text(
          organizer,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.all(12.0),
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
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.verticalSpace,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         IconButton(
                //             onPressed: () => Get.back(),
                //             icon: Icon(Icons.arrow_back)),
                //         10.horizontalSpace,
                //         Text(
                //           organizer,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //               fontSize: 24,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black),
                //         ),
                //       ],
                //     ),
                //     Container(
                //       height: 30,
                //       width: 30,
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.black, width: 1),
                //         borderRadius: BorderRadius.circular(50.0),
                //       ),
                //       child: Icon(
                //         Icons.more_horiz_sharp,
                //         color: Colors.black,
                //         size: 25,
                //       ),
                //     )
                //   ],
                // ),
                // 30.verticalSpace,
                customProfileImage(organizerImage, 90.h, 90.h),
                20.verticalSpace,
                Text(
                  "World of Music",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                20.verticalSpace,
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
                            "24",
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
                            "967K",
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
                            "20",
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 0.4.sw,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              followIcon,
                              color: Colors.white,
                              height: 20.h,
                            ),
                            10.horizontalSpace,
                            Text(
                              follow,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 0.4.sw,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border:
                                Border.all(width: 2.0, color: kPrimaryColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              chatIcon,
                              color: kPrimaryColor,
                              height: 20.h,
                            ),
                            10.horizontalSpace,
                            Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                TabBar(
                  labelStyle: TextStyle(color: kPrimaryColor),
                  unselectedLabelStyle: TextStyle(color: kDisabledColor),
                  labelColor: kPrimaryColor,
                  //  dividerColor: kDisabledColor,
                  unselectedLabelColor: Color(0xff9E9E9E),
                  isScrollable: false,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  controller: tabController,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 3.0,
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  // indicator: BoxDecoration(
                  //     color: Color(0xff3E5164),
                  //     borderRadius: BorderRadius.circular(8)),
                  indicatorColor: kPrimaryColor,
                  indicatorWeight: 3.0,
                  tabs: [
                    FittedBox(
                      child: Text(events,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    FittedBox(
                      child: Text(collections,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    FittedBox(
                      child: Text(about,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                10.verticalSpace,
                Expanded(
                    child: TabBarView(controller: tabController, children: [
                  //Events
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  customCardImage(eventImage, 110.h, 100.h),
                                  eventList[index]['isFree']
                                      ? Positioned(
                                          right: 10,
                                          top: 10,
                                          child: Container(
                                            // width: 0.2.sh,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 8.0),
                                            decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: Text(
                                              free,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              ),
                              8.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      eventList[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  8.verticalSpace,
                                  FittedBox(
                                    child: Text(
                                      eventList[index]['date'],
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
                                          eventList[index]['location'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff616161)),
                                        ),
                                        5.horizontalSpace,
                                        InkWell(
                                          onTap: () {},
                                          child: Image.asset(
                                            eventList[index]['isFavorite']
                                                ? favoriteIconSelected
                                                : favoriteIcon,
                                            color: kPrimaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  //Collections
                  GridView.builder(
                    //  physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: galleryEventImagesList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => ImagePreviewDialog(
                                imagePath: galleryEventImagesList[index]),
                          );
                        },
                        child: customCardImage(
                            galleryEventImagesList[index], 110.h, 110.h),
                      );
                    },
                  ),

                  //About
                  ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white),
                          child: Text(
                              "This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff424242))),
                        ),
                      );
                    },
                  ),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  List galleryEventImagesList = [
    galleryEventImage1,
    galleryEventImage2,
    galleryEventImage3,
    galleryEventImage4,
    galleryEventImage5,
    galleryEventImage6,
    galleryEventImage7,
    galleryEventImage1,
    galleryEventImage2,
    galleryEventImage3,
    galleryEventImage4,
    galleryEventImage5,
    galleryEventImage6,
    galleryEventImage7,
    galleryEventImage1,
    galleryEventImage2,
    galleryEventImage3,
    galleryEventImage4,
    galleryEventImage5,
    galleryEventImage6,
    galleryEventImage7,
    galleryEventImage1,
    galleryEventImage2,
    galleryEventImage3,
    galleryEventImage4,
    galleryEventImage5,
    galleryEventImage6,
    galleryEventImage7
  ];
}
