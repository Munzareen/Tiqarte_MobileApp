import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';

class SeeAllEventsScreen extends StatefulWidget {
  final String name;
  final String img;
  const SeeAllEventsScreen({super.key, required this.name, required this.img});

  @override
  State<SeeAllEventsScreen> createState() => _SeeAllEventsScreenState();
}

class _SeeAllEventsScreenState extends State<SeeAllEventsScreen> {
  bool isSearch = false;
  final _searchController = TextEditingController();
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final _searchFocusNode = FocusNode();

  List popularEventsCatergoryList = [
    {"name": homeAllString, "icon": allIcon, "isSelected": true},
    {"name": homeMusicString, "icon": musicIcon, "isSelected": false},
    {"name": homeArtString, "icon": artIcon, "isSelected": false},
    {"name": homeWorkshopsString, "icon": workshopIcon, "isSelected": false}
  ];

  List eventList = [
    {
      "name": "International Concert",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "Jazz Music Festival",
      "date": "Tue, Dec 19 • 19.00 - 22.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "DJ Music Competition",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "Central Park, Ne..."
    },
    {
      "name": "National Music Fest",
      "date": "Sun, Dec 16 • 11.00 - 13.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "Art Workshops",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "Tech Seminar",
      "date": "Sat, Dec 22 • 10.00 - 12.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "Mural Painting",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa..."
    },
  ];

  List allEventList = [
    {
      "name": "International Concert",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "Jazz Music Festival",
      "date": "Tue, Dec 19 • 19.00 - 22.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "DJ Music Competition",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "Central Park, Ne..."
    },
    {
      "name": "National Music Fest",
      "date": "Sun, Dec 16 • 11.00 - 13.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "Art Workshops",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "Tech Seminar",
      "date": "Sat, Dec 22 • 10.00 - 12.00...",
      "location": "New Avenue, Wa..."
    },
    {
      "name": "Mural Painting",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa..."
    },
  ];

  bool isListSelected = true;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        setState(() {
          filledColorSearch = kPrimaryColor.withOpacity(0.2);
          iconColorSearch = kPrimaryColor;
        });
      } else {
        setState(() {
          filledColorSearch = kDisabledColor.withOpacity(0.4);
          iconColorSearch = kDisabledColor;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                isSearch
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(Icons.arrow_back)),
                          Expanded(
                            child: TextFormField(
                              focusNode: _searchFocusNode,
                              cursorColor: kPrimaryColor,
                              controller: _searchController,
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
                                    color: iconColorSearch,
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
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  disabledBorder: customOutlineBorder,
                                  //  fillColor: filledColorSearch,
                                  filled: true,
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                      color: Color(0xff9E9E9E), fontSize: 14)),
                              onChanged: searchEvent,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(textRegExp),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isSearch = false;
                                  _searchController.clear();
                                  eventList = allEventList;
                                });
                              },
                              icon: Icon(Icons.close))
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => Get.back(),
                                  icon: Icon(Icons.arrow_back)),
                              Text(
                                widget.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              5.horizontalSpace,
                              widget.img == ''
                                  ? SizedBox()
                                  : Image.asset(widget.img),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isSearch = true;
                                });
                              },
                              icon: Icon(Icons.search))
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
                            popularEventsCatergoryList[index]['isSelected'] =
                                true;
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
                            border: Border.all(width: 2, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Image.asset(
                                    popularEventsCatergoryList[index]['icon']),
                                5.horizontalSpace,
                                Text(
                                  popularEventsCatergoryList[index]['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: popularEventsCatergoryList[index]
                                              ['isSelected']
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
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      eventList.length.toString() +
                          " " +
                          seeAllEventFoundString,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isListSelected = true;
                              });
                            },
                            icon: Icon(
                              Icons.list_alt,
                              color: isListSelected
                                  ? kPrimaryColor
                                  : kDisabledColor,
                              size: 25,
                            )),
                        5.horizontalSpace,
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isListSelected = false;
                              });
                            },
                            icon: Icon(
                              Icons.grid_view,
                              color: isListSelected
                                  ? kDisabledColor
                                  : kPrimaryColor,
                              size: 25,
                            ))
                      ],
                    ),
                  ],
                ),
                5.verticalSpace,
                eventList.isEmpty
                    ? Expanded(
                        child: ListView(
                          children: [
                            30.verticalSpace,
                            Image.asset(
                              notFoundImage,
                              height: 250,
                            ),
                            10.verticalSpace,
                            Text(
                              seeAllEventNotFoundString,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            10.verticalSpace,
                            Text(
                              seeAllEventNotFoundSubString,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          children: [
                            !isListSelected
                                ? Container(
                                    child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 20,
                                            mainAxisExtent: 245),
                                    itemCount: eventList.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          // Get.to(
                                          //     () => EventDetailScreen(
                                          //         data: eventList[index]),
                                          //     transition:
                                          //         Transition.rightToLeft);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor),
                                          child: Column(
                                            // mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customCardImage(
                                                  eventImage, 140.h, 100.h),
                                              8.verticalSpace,
                                              SizedBox(
                                                width: 0.5.sw,
                                                child: Text(
                                                  eventList[index]['name'],
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              8.verticalSpace,
                                              FittedBox(
                                                child: Text(
                                                  eventList[index]['date'],
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kPrimaryColor),
                                                ),
                                              ),
                                              8.verticalSpace,
                                              FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
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
                                                        eventList[index]
                                                            ['location'],
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                      );
                                    },
                                  ))
                                : ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: eventList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // Get.to(
                                          //     () => EventDetailScreen(
                                          //         data: eventList[index]),
                                          //     transition:
                                          //         Transition.rightToLeft);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Container(
                                            padding: EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor),
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                customCardImage(
                                                    eventImage, 110.h, 100.h),
                                                8.horizontalSpace,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 0.5.sw,
                                                      child: Text(
                                                        eventList[index]
                                                            ['name'],
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    8.verticalSpace,
                                                    FittedBox(
                                                      child: Text(
                                                        eventList[index]
                                                            ['date'],
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                                    8.verticalSpace,
                                                    FittedBox(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color:
                                                                kPrimaryColor,
                                                            size: 25,
                                                          ),
                                                          5.horizontalSpace,
                                                          SizedBox(
                                                            width: 0.3.sw,
                                                            child: Text(
                                                              eventList[index]
                                                                  ['location'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          5.horizontalSpace,
                                                          InkWell(
                                                            onTap: () {},
                                                            child: Image.asset(
                                                              favoriteIcon,
                                                              color:
                                                                  kPrimaryColor,
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
                                        ),
                                      );
                                    },
                                  )
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchEvent(String query) {
    eventList = allEventList;
    final suggestion = eventList.where((element) {
      final eventName = element['name']!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    setState(() {
      eventList = suggestion;
      // searchDoc = true;
    });
  }
}
