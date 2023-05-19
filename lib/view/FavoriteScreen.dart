import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/favoriteController.dart';
import 'package:tiqarte/controller/homeController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';

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

  List popularEventsCatergoryList = [
    {"name": homeAllString, "icon": allIcon, "isSelected": true},
    {"name": homeMusicString, "icon": musicIcon, "isSelected": false},
    {"name": homeArtString, "icon": artIcon, "isSelected": false},
    {"name": homeWorkshopsString, "icon": workshopIcon, "isSelected": false}
  ];

  // bool isListSelected = true;

  final _favoriteController = Get.put(FavoriteController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getFavorites("1"); //hard coded
    if (res != null && res is List) {
      _favoriteController.addFavoriteData(res);
    } else if (res != null && res is String) {
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _favoriteController.favoriteList = null;
    _favoriteController.isSearchFav = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //      backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          //     backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GetBuilder<FavoriteController>(builder: (_fc) {
              return _fc.favoriteList == null
                  ? Center(
                      child: spinkit,
                    )
                  : Column(
                      children: [
                        20.verticalSpace,
                        _fc.isSearchFav
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    appLogo,
                                    height: 25.h,
                                  ),
                                  10.horizontalSpace,
                                  Expanded(
                                    child: TextFormField(
                                      //  focusNode: _fc.searchFocusNode,
                                      cursorColor: kPrimaryColor,
                                      controller: _searchController,
                                      //  style: const TextStyle(color: Colors.black),
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
                                            color: _fc.iconColorSearch,
                                          ),
                                          errorBorder: customOutlineBorder,
                                          enabledBorder: customOutlineBorder,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0)),
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor)),
                                          disabledBorder: customOutlineBorder,
                                          //  fillColor: filledColorSearch,
                                          filled: true,
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                              color: Color(0xff9E9E9E),
                                              fontSize: 14)),
                                      onChanged: _fc.searchEvent,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            textRegExp),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _fc.favoriteOnSearchClose(
                                            _searchController);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        appLogo,
                                        height: 25.h,
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        favorites,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _fc.favoriteOnSearch();
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
                                          )),
                                    ],
                                  )
                                ],
                              ),
                        20.verticalSpace,
                        Container(
                          height: 45,
                          width: 1.sw,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _fc.favCategoryList?.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  _fc.selectFavCategory(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  decoration: BoxDecoration(
                                    color: _fc.favCategoryList![index]
                                                .isSelected ==
                                            true
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
                                        // Image.asset(
                                        //     upcomingEventsCatergoryList[
                                        //         index]['icon']),
                                        5.horizontalSpace,
                                        Text(
                                          _fc.favCategoryList![index]
                                              .catagoryName
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: _fc.favCategoryList![index]
                                                          .isSelected ==
                                                      true
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
                              _fc.favoriteList!.length.toString() +
                                  " " +
                                  favorites.toLowerCase(),
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
                                      _fc.favoriteListGridSelect(true);
                                    },
                                    icon: Icon(
                                      Icons.list_alt,
                                      color: _fc.isListSelectedFav
                                          ? kPrimaryColor
                                          : kDisabledColor,
                                      size: 25,
                                    )),
                                5.horizontalSpace,
                                IconButton(
                                    onPressed: () {
                                      _fc.favoriteListGridSelect(false);
                                    },
                                    icon: Icon(
                                      Icons.grid_view,
                                      color: _fc.isListSelectedFav
                                          ? kDisabledColor
                                          : kPrimaryColor,
                                      size: 25,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        5.verticalSpace,
                        _fc.isSearchFav && _fc.favoriteList!.isEmpty
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              )
                            : !_fc.isSearchFav && _fc.favoriteList!.isEmpty
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // 20.verticalSpace,
                                        // Text(
                                        //   notificationEmptySrting,
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(
                                        //     fontSize: 18,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: ListView(
                                      children: [
                                        !_fc.isListSelectedFav
                                            ? GridView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 1,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 20,
                                                        mainAxisExtent: 245),
                                                itemCount:
                                                    _fc.favoriteList!.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      // Get.to(
                                                      //     () => EventDetailScreen(
                                                      //         data: _fc.favoriteList![
                                                      //             index]),
                                                      //     transition:
                                                      //         Transition.rightToLeft);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          color: Theme.of(
                                                                  context)
                                                              .secondaryHeaderColor),
                                                      child: Column(
                                                        // mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          customCardImage(
                                                              _fc
                                                                      .favoriteList![
                                                                          index]
                                                                      .eventImages!
                                                                      .isNotEmpty
                                                                  ? _fc
                                                                      .favoriteList![
                                                                          index]
                                                                      .eventImages![
                                                                          0]
                                                                      .toString()
                                                                  : "null",
                                                              140.h,
                                                              100.h),
                                                          8.verticalSpace,
                                                          SizedBox(
                                                            width: 0.5.sw,
                                                            child: Text(
                                                              _fc
                                                                  .favoriteList![
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          8.verticalSpace,
                                                          FittedBox(
                                                            child: Text(
                                                              splitDateTimeWithoutYear(_fc
                                                                  .favoriteList![
                                                                      index]
                                                                  .eventDate
                                                                  .toString()),
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
                                                                SizedBox(
                                                                  width: 0.3.sw,
                                                                  child: Text(
                                                                    _fc
                                                                        .favoriteList![
                                                                            index]
                                                                        .city
                                                                        .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                5.horizontalSpace,
                                                                InkWell(
                                                                  onTap: () {
                                                                    removeFavoriteBottomSheet(
                                                                        context,
                                                                        index);
                                                                  },
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
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount:
                                                    _fc.favoriteList!.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      // Get.to(
                                                      //     () => EventDetailScreen(
                                                      //         data: _fc.favoriteList![
                                                      //             index]),
                                                      //     transition:
                                                      //         Transition.rightToLeft);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                            color: Theme.of(
                                                                    context)
                                                                .secondaryHeaderColor),
                                                        child: Row(
                                                          // mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            customCardImage(
                                                                _fc
                                                                        .favoriteList![
                                                                            index]
                                                                        .eventImages!
                                                                        .isNotEmpty
                                                                    ? _fc
                                                                        .favoriteList![
                                                                            index]
                                                                        .eventImages![
                                                                            0]
                                                                        .toString()
                                                                    : "null",
                                                                110.h,
                                                                100.h),
                                                            8.horizontalSpace,
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 0.5.sw,
                                                                  child: Text(
                                                                    _fc
                                                                        .favoriteList![
                                                                            index]
                                                                        .name
                                                                        .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                8.verticalSpace,
                                                                FittedBox(
                                                                  child: Text(
                                                                    splitDateTimeWithoutYear(_fc
                                                                        .favoriteList![
                                                                            index]
                                                                        .eventDate
                                                                        .toString()),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
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
                                                                        size:
                                                                            25,
                                                                      ),
                                                                      5.horizontalSpace,
                                                                      SizedBox(
                                                                        width: 0.3
                                                                            .sw,
                                                                        child:
                                                                            Text(
                                                                          _fc.favoriteList![index]
                                                                              .city
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      5.horizontalSpace,
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          removeFavoriteBottomSheet(
                                                                              context,
                                                                              index);
                                                                        },
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
        ),
      ),
    );
  }

  removeFavoriteBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                        removeFromFavorites,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      10.verticalSpace,
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
                              customCardImage(
                                  _favoriteController.favoriteList![index]
                                          .eventImages!.isNotEmpty
                                      ? _favoriteController
                                          .favoriteList![index].eventImages![0]
                                          .toString()
                                      : "null",
                                  110.h,
                                  100.h),
                              8.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 0.4.sw,
                                    child: Text(
                                      _favoriteController
                                          .favoriteList![index].name
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  8.verticalSpace,
                                  FittedBox(
                                    child: Text(
                                      splitDateTimeWithoutYear(
                                          _favoriteController
                                              .favoriteList![index].eventDate
                                              .toString()),
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
                                            _favoriteController
                                                .favoriteList![index].city
                                                .toString(),
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        5.horizontalSpace,
                                        InkWell(
                                          onTap: () {
                                            removeFavoriteBottomSheet(
                                                context, index);
                                          },
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
                                child: Text(cancel,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                            ),
                          ),
                          20.horizontalSpace,
                          InkWell(
                            onTap: () async {
                              String data =
                                  "?eventID=${_favoriteController.favoriteList![index].eventId!.toInt()}&fav=false&customerID=${_favoriteController.favoriteList![index].creationUserId!.toInt()}";

                              var res = await ApiService()
                                  .removeFavorite(context, data);
                              if (res != null && res is String) {
                                Get.back();
                                Get.back();
                                if (!res.contains("Something went wrong")) {
                                  _favoriteController.favoriteList!
                                      .removeAt(index);
                                  _favoriteController.update();
                                  customSnackBar("Success!", res);
                                } else {
                                  customSnackBar(
                                      "Error!", "Something went wrong!");
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 0.3.sw,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Center(
                                child: Text(yesRemove,
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
