import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  List popularEventsCatergoryList = [
    {"name": homeAllString, "icon": allIcon, "isSelected": true},
    {"name": homeMusicString, "icon": musicIcon, "isSelected": false},
    {"name": homeArtString, "icon": artIcon, "isSelected": false},
    {"name": homeWorkshopsString, "icon": workshopIcon, "isSelected": false}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondBackgroundColor,
      body: SafeArea(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        customProfileImage('', 40.h, 40.h),
                        15.horizontalSpace,
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  homeGoodMorningString,
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
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(color: kDisabledColor, width: 1),
                          image: DecorationImage(
                              image: AssetImage(notificationIconWithBadge))),
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
                      suffixIcon: Image.asset(filterIcon),
                      errorBorder: customOutlineBorder,
                      enabledBorder: customOutlineBorder,
                      focusedBorder: customOutlineBorder,
                      // OutlineInputBorder(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(12.0)),
                      //     borderSide: BorderSide(color: kPrimaryColor)),
                      disabledBorder: customOutlineBorder,
                      fillColor: kDisabledColor.withOpacity(0.3),
                      filled: true,
                      hintText: homeSearchFieldString,
                      hintStyle:
                          TextStyle(color: Color(0xff9E9E9E), fontSize: 14)),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(textRegExp),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            homeFeaturedString,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            homeSeeAllString,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      CarouselSlider.builder(
                          options: CarouselOptions(
                              height: 0.45.sh,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.8),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.white),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    customCardImage(eventImage, 250.w, 160.h),
                                    12.verticalSpace,
                                    FittedBox(
                                      child: Text(
                                        "National Music Festival",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    12.verticalSpace,
                                    FittedBox(
                                      child: Text(
                                        "Mon, Dec 24 • 18.00 - 23.00 PM",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                    12.verticalSpace,
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
                                          10.horizontalSpace,
                                          Text(
                                            "Grand Park, New York",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff616161)),
                                          ),
                                          10.horizontalSpace,
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
                            );
                          }),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                homePopularEventString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              5.horizontalSpace,
                              Image.asset(fireIcon),
                            ],
                          ),
                          Text(
                            homeSeeAllString,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Container(
                        height: 45,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: popularEventsCatergoryList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  popularEventsCatergoryList.forEach((element) {
                                    element['isSelected'] = false;
                                  });
                                  popularEventsCatergoryList[index]
                                      ['isSelected'] = true;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                  color: popularEventsCatergoryList[index]
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
                                          popularEventsCatergoryList[index]
                                              ['icon']),
                                      5.horizontalSpace,
                                      Text(
                                        popularEventsCatergoryList[index]
                                            ['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: popularEventsCatergoryList[
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
                      )
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

  customCardImage(String url, double width, double height) {
    return url == "" && url == "null"
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) {
              return Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      // border: Border.all(
                      //   color: kPrimaryColor,
                      //   style: BorderStyle.solid,
                      // ),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)));
            },
            placeholder: (context, url) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // border: Border.all(
                    //   color: kPrimaryColor,
                    //   style: BorderStyle.solid,
                    // ),
                    image: DecorationImage(
                        image: AssetImage(eventImage), fit: BoxFit.cover))),
            errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // border: Border.all(
                    //   color: kPrimaryColor,
                    //   style: BorderStyle.solid,
                    // ),
                    image: DecorationImage(
                        image: AssetImage(eventImage), fit: BoxFit.cover))),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(
                //   color: kPrimaryColor,
                //   style: BorderStyle.solid,
                // ),
                image: DecorationImage(
                    image: AssetImage(eventImage),
                    fit: BoxFit.cover))); //AssetImage(placeholder)
  }
}
