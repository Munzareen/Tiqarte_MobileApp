import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/controller/NavigationBarController.dart';
import 'package:tiqarte/controller/homeController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';
import 'package:tiqarte/view/NotificationScreen.dart';
import 'package:tiqarte/view/SeeAllEventsScreen.dart';
import 'package:tiqarte/view/ShopDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  List upcomingEventsCatergoryList = [
    {"name": homeAllString, "icon": allIcon, "isSelected": true},
    {"name": homeMusicString, "icon": musicIcon, "isSelected": false},
    {"name": homeArtString, "icon": artIcon, "isSelected": false},
    {"name": homeWorkshopsString, "icon": workshopIcon, "isSelected": false}
  ];

  final _homeController = Get.put(HomeController());
  final nbc = Get.put(NavigationBarController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //  backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          // backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: kFlutterMemoryAllocationsEnabled,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            nbc.navBarChange(4);
                          },
                          child: customProfileImage(profileImage, 40.h, 40.h),
                        ),
                        15.horizontalSpace,
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  goodMorning,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                5.horizontalSpace,
                                Image.asset(
                                  waveIcon,
                                )
                              ],
                            ),
                            5.verticalSpace,
                            Text(
                              "Andrew Ainsley",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Get.to(() => NotificationScreen(),
                          transition: Transition.rightToLeft),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(color: kDisabledColor, width: 1),
                          // image: DecorationImage(
                          //   image: AssetImage(notificationIconWithBadge),
                          // )
                        ),
                        child: Center(
                          child: Image.asset(
                            notificationIcon,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                20.verticalSpace,
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _searchController,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.text,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter your username';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                        color: kDisabledColor,
                      ),
                      suffixIcon: InkWell(
                          onTap: () => filterBottomSheet(
                              context,
                              eventsCatergoryList,
                              locationList,
                              selectedLocation,
                              currentRangeValues),
                          child: Image.asset(filterIcon)),
                      errorBorder: customOutlineBorder,
                      enabledBorder: customOutlineBorder,
                      focusedBorder: customOutlineBorder,
                      // OutlineInputBorder(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(12.0)),
                      //     borderSide: BorderSide(color: kPrimaryColor)),
                      disabledBorder: customOutlineBorder,
                      filled: true,
                      hintText: whatEventAreYouLookingFor,
                      hintStyle:
                          TextStyle(color: Color(0xff9E9E9E), fontSize: 14)),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(textRegExp),
                  ],
                ),
                10.verticalSpace,
                Expanded(
                  child: ListView(
                    children: [
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            featured,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.to(
                                () =>
                                    SeeAllEventsScreen(name: featured, img: ''),
                                transition: Transition.rightToLeft),
                            child: Text(
                              seeAll,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      GetBuilder<HomeController>(builder: (_hc) {
                        return CarouselSlider.builder(
                            options: CarouselOptions(
                                height: 0.425.sh,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                enableInfiniteScroll: false,
                                viewportFraction: 0.8),
                            itemCount: _hc.eventList.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => EventDetailScreen(
                                        data: _hc.eventList[itemIndex],
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customCardImage(
                                            eventImage, 250.w, 160.h),
                                        12.verticalSpace,
                                        SizedBox(
                                          width: 0.7.sw,
                                          child: Text(
                                            _hc.eventList[itemIndex]['name'],
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        12.verticalSpace,
                                        FittedBox(
                                          child: Text(
                                            _hc.eventList[itemIndex]['date'],
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: kPrimaryColor),
                                          ),
                                        ),
                                        12.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: kPrimaryColor,
                                                  size: 25,
                                                ),
                                                10.horizontalSpace,
                                                SizedBox(
                                                  width: 0.5.sw,
                                                  child: Text(
                                                    _hc.eventList[itemIndex]
                                                        ['location'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      //color: Color(0xff616161)
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _hc.addRemoveToFavorite(
                                                    itemIndex,
                                                    _hc.eventList[itemIndex]);
                                              },
                                              child: Image.asset(
                                                _hc.eventList[itemIndex]
                                                            ['isFavorite'] ==
                                                        true
                                                    ? favoriteIconSelected
                                                    : favoriteIcon,
                                                color: kPrimaryColor,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                upcomingEvent,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              5.horizontalSpace,
                              Image.asset(fireIcon),
                            ],
                          ),
                          InkWell(
                            onTap: () => Get.to(
                                () => SeeAllEventsScreen(
                                    name: upcomingEvent, img: fireIcon),
                                transition: Transition.rightToLeft),
                            child: Text(
                              seeAll,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Container(
                        height: 45,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingEventsCatergoryList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  upcomingEventsCatergoryList
                                      .forEach((element) {
                                    element['isSelected'] = false;
                                  });
                                  upcomingEventsCatergoryList[index]
                                      ['isSelected'] = true;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                  color: upcomingEventsCatergoryList[index]
                                          ['isSelected']
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 2, color: kPrimaryColor),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          upcomingEventsCatergoryList[index]
                                              ['icon']),
                                      5.horizontalSpace,
                                      Text(
                                        upcomingEventsCatergoryList[index]
                                            ['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: upcomingEventsCatergoryList[
                                                    index]['isSelected']
                                                ? Colors.white
                                                : kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 240),
                          itemCount: _homeController.eventList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => EventDetailScreen(
                                      data: _homeController.eventList[index],
                                    ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                                child: SingleChildScrollView(
                                  child: Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customCardImage(eventImage, 140.h, 100.h),
                                      8.verticalSpace,
                                      SizedBox(
                                        width: 0.5.sw,
                                        child: Text(
                                          "Art Workshops",
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
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
                                            SizedBox(
                                              width: 0.3.sw,
                                              child: Text(
                                                "Grand Park, New York",
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            5.horizontalSpace,
                                            InkWell(
                                              onTap: () {},
                                              child: Image.asset(
                                                favoriteIcon,
                                                color: kPrimaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      //
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shop,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.to(() => ShopDetailScreen(),
                                transition: Transition.rightToLeft),
                            child: Text(
                              seeAll,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Container(
                        height: 45,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingEventsCatergoryList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  upcomingEventsCatergoryList
                                      .forEach((element) {
                                    element['isSelected'] = false;
                                  });
                                  upcomingEventsCatergoryList[index]
                                      ['isSelected'] = true;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                  color: upcomingEventsCatergoryList[index]
                                          ['isSelected']
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 2, color: kPrimaryColor),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          upcomingEventsCatergoryList[index]
                                              ['icon']),
                                      5.horizontalSpace,
                                      Text(
                                        upcomingEventsCatergoryList[index]
                                            ['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: upcomingEventsCatergoryList[
                                                    index]['isSelected']
                                                ? Colors.white
                                                : kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 240),
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                              child: SingleChildScrollView(
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customCardImage(tshirtImage, 140.h, 120.h),
                                    8.verticalSpace,
                                    SizedBox(
                                      width: 0.5.sw,
                                      child: Text(
                                        "R.Madrid T-Shirtk",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    8.verticalSpace,
                                    FittedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.text_format,
                                            color: kPrimaryColor,
                                            size: 25,
                                          ),
                                          5.horizontalSpace,
                                          Text(
                                            "Starting from 70,00€",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
    );
  }
}
