import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/controller/homeController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // bool isSearch = false;
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

  // bool isListSelected = true;

  final _homeController = Get.put(HomeController());

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
        backgroundColor: kSecondBackgroundColor,
        body: SafeArea(
            child: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GetBuilder<HomeController>(builder: (_hc) {
              return Column(
                children: [
                  20.verticalSpace,
                  _hc.isSearchFav
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              appLogo,
                              height: 20,
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: TextFormField(
                                focusNode: _searchFocusNode,
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
                                      color: iconColorSearch,
                                    ),
                                    errorBorder: customOutlineBorder,
                                    enabledBorder: customOutlineBorder,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        borderSide:
                                            BorderSide(color: kPrimaryColor)),
                                    disabledBorder: customOutlineBorder,
                                    fillColor: filledColorSearch,
                                    filled: true,
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                        color: Color(0xff9E9E9E),
                                        fontSize: 14)),
                                onChanged: _hc.searchEvent,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(textRegExp),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  // setState(() {
                                  //   isSearch = false;
                                  //   _searchController.clear();
                                  //   _hc.eventList =
                                  //       _hc.allEventList;
                                  // });
                                  _hc.favoriteOnSearchClose(_searchController);
                                },
                                icon: Icon(Icons.close))
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  appLogo,
                                  height: 20,
                                ),
                                20.horizontalSpace,
                                Text(
                                  favoriteHeadingString,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   isSearch = true;
                                      // });
                                      _hc.favoriteOnSearch();
                                    },
                                    icon: Icon(Icons.search)),
                                10.horizontalSpace,
                                InkWell(
                                    onTap: () => filterBottomSheet(
                                        context,
                                        eventsCatergoryList,
                                        locationList,
                                        selectedLocation,
                                        currentRangeValues),
                                    child: Image.asset(
                                      filterIcon,
                                      color: Colors.black,
                                    )),
                              ],
                            )
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
                              border:
                                  Border.all(width: 2, color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Image.asset(popularEventsCatergoryList[index]
                                      ['icon']),
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
                        _hc.favEventList.length.toString() +
                            " " +
                            favoriteHeadingString.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                _hc.favoriteListGridSelect(true);
                              },
                              icon: Icon(
                                Icons.list_alt,
                                color: _hc.isListSelectedFav
                                    ? kPrimaryColor
                                    : kDisabledColor,
                                size: 25,
                              )),
                          5.horizontalSpace,
                          IconButton(
                              onPressed: () {
                                _hc.favoriteListGridSelect(false);
                              },
                              icon: Icon(
                                Icons.grid_view,
                                color: _hc.isListSelectedFav
                                    ? kDisabledColor
                                    : kPrimaryColor,
                                size: 25,
                              ))
                        ],
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  _hc.isSearchFav && _hc.favEventList.isEmpty
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
                                    color: Colors.black),
                              ),
                              10.verticalSpace,
                              Text(
                                seeAllEventNotFoundSubString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      : !_hc.isSearchFav && _hc.favEventList.isEmpty
                          ? Expanded(
                              child: ListView(
                                children: [
                                  30.verticalSpace,
                                  Image.asset(
                                    noNotificationImage,
                                    height: 250,
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
                                  // 20.verticalSpace,
                                  // Text(
                                  //   notificationEmptySrting,
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //       fontSize: 18, color: Colors.black),
                                  // ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView(
                                children: [
                                  !_hc.isListSelectedFav
                                      ? GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 20,
                                                  mainAxisExtent: 255),
                                          itemCount: _hc.favEventList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                removeFavoriteBottomSheet(
                                                    context, index);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    color: Colors.white),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    // mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      customCardImage(
                                                          "", 120.h, 100.h),
                                                      8.verticalSpace,
                                                      FittedBox(
                                                        child: Text(
                                                          _hc.favEventList[
                                                              index]['name'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      8.verticalSpace,
                                                      FittedBox(
                                                        child: Text(
                                                          _hc.favEventList[
                                                              index]['date'],
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                                            Text(
                                                              _hc.favEventList[
                                                                      index]
                                                                  ['location'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff616161)),
                                                            ),
                                                            5.horizontalSpace,
                                                            InkWell(
                                                              onTap: () {},
                                                              child:
                                                                  Image.asset(
                                                                favoriteIconSelected,
                                                                color:
                                                                    kPrimaryColor,
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
                                        )
                                      : ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: _hc.favEventList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                removeFavoriteBottomSheet(
                                                    context, index);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Colors.white),
                                                  child: Row(
                                                    // mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      customCardImage(
                                                          eventImage,
                                                          110.h,
                                                          100.h),
                                                      8.horizontalSpace,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          FittedBox(
                                                            child: Text(
                                                              _hc.favEventList[
                                                                      index]
                                                                  ['name'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          8.verticalSpace,
                                                          FittedBox(
                                                            child: Text(
                                                              _hc.favEventList[
                                                                      index]
                                                                  ['date'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
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
                                                                  Icons
                                                                      .location_on,
                                                                  color:
                                                                      kPrimaryColor,
                                                                  size: 25,
                                                                ),
                                                                5.horizontalSpace,
                                                                Text(
                                                                  _hc.favEventList[
                                                                          index]
                                                                      [
                                                                      'location'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Color(
                                                                          0xff616161)),
                                                                ),
                                                                5.horizontalSpace,
                                                                InkWell(
                                                                  onTap: () {},
                                                                  child: Image
                                                                      .asset(
                                                                    favoriteIconSelected,
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
              );
            }),
          ),
        )),
      ),
    );
  }

  removeFavoriteBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      5.verticalSpace,
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: kDisabledColor.withOpacity(0.6)),
                      ),
                      15.verticalSpace,
                      Text(
                        favoriteRemoveFavoriteString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Divider(),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customCardImage(eventImage, 110.h, 100.h),
                              8.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      _homeController.favEventList[index]
                                          ['name'],
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
                                      _homeController.favEventList[index]
                                          ['date'],
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
                                          _homeController.favEventList[index]
                                              ['location'],
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
                                            favoriteIconSelected,
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
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 50,
                              width: 0.3.sw,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Center(
                                child: Text(favoriteButtonCancelString,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                            ),
                          ),
                          20.horizontalSpace,
                          InkWell(
                            onTap: () {
                              _homeController.addRemoveToFavorite(
                                  index, _homeController.favEventList[index]);

                              Get.back();
                            },
                            child: Container(
                              height: 50,
                              width: 0.3.sw,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Center(
                                child: Text(favoriteButtonRemoveString,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
