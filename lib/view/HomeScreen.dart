import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/NavigationBarController.dart';
import 'package:tiqarte/controller/homeController.dart';
import 'package:tiqarte/controller/myBasketController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';
import 'package:tiqarte/view/MyBasketScreen.dart';
import 'package:tiqarte/view/NewsDetailScreen.dart';
import 'package:tiqarte/view/NotificationScreen.dart';
import 'package:tiqarte/view/SeeAllEventsScreen.dart';
import 'package:tiqarte/view/SeeAllNewsScreen.dart';
import 'package:tiqarte/view/SeeAllProductsScreen.dart';
import 'package:tiqarte/view/ViewProductScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.put(HomeController());
  final _myBasketController = Get.put(MyBasketController());

  final nbc = Get.put(NavigationBarController());

  @override
  void initState() {
    super.initState();
    getData();
    getCartProducts();
    getNewsList();
  }

  getCartProducts() async {
    var res = await ApiService().getAddToCartByUser();

    if (res != null && res is List) {
      _myBasketController.addMyBasketData(res);
    }
  }

  getNewsList() async {
    var res = await ApiService().getArticles();

    if (res != null && res is List) {
      _homeController.addNews(res);
    }
  }

  @override
  void dispose() {
    _homeController.featuredEventList = _homeController.featuredEventListAll;
    _homeController.upcomingEventList = _homeController.upcomingEventListAll;
    _homeController.shopList = _homeController.shopListAll;
    _homeController.searchController.clear();
    super.dispose();
  }

  getData() async {
    var res = await ApiService().getHomeData();
    if (res != null && res is Map) {
      _homeController.addHomeData(res);
    } else if (res != null && res is String) {
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    accessToken;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: GetBuilder<HomeController>(builder: (_hc) {
              return Column(
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
                            child: customProfileImage(
                                userImage.toString(), 40.h, 40.h),
                          ),
                          15.horizontalSpace,
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    getWelcomeMessage(),
                                    textAlign: TextAlign.start,
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
                              SizedBox(
                                width: 0.3.sw,
                                child: Text(
                                  userName,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
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
                            child: Image.asset(notificationIcon,
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                        ),
                      )
                    ],
                  ),
                  20.verticalSpace,
                  TextFormField(
                    cursorColor: kPrimaryColor,
                    controller: _hc.searchController,
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
                        suffixIcon: GestureDetector(
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
                        hintText: 'whatEventAreYouLookingFor'.tr,
                        hintStyle:
                            TextStyle(color: Color(0xff9E9E9E), fontSize: 14)),
                    onChanged: _hc.homeSearch,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(textRegExp),
                    ],
                  ),
                  10.verticalSpace,
                  _hc.homeDataModel.featuredEvents == null &&
                          _hc.upcomingCategoryList == null
                      ? Expanded(
                          child: Center(
                            child: spinkit,
                          ),
                        )
                      : Expanded(
                          child: ListView(
                            children: [
                              _hc.featuredEventListAll!.isEmpty
                                  ? SizedBox()
                                  : _hc.featuredEventListAll!.isNotEmpty &&
                                          _hc.featuredEventList!.isEmpty
                                      ? Column(
                                          children: [
                                            20.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'featured'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            20.verticalSpace,
                                            Image.asset(
                                              notFoundImage,
                                              height: 250,
                                            ),
                                            10.verticalSpace,
                                            Text(
                                              'notFound'.tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            10.verticalSpace,
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            20.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'featured'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                _hc.featuredEventList!.length >
                                                        12
                                                    ? GestureDetector(
                                                        onTap: () => Get.to(
                                                            () => SeeAllEventsScreen(
                                                                name: 'featured'
                                                                    .tr,
                                                                img: '',
                                                                eventTypeId: _hc
                                                                    .featuredEventList![
                                                                        0]
                                                                    .eventTypeId!
                                                                    .toInt()
                                                                    .toString()),
                                                            transition: Transition
                                                                .rightToLeft),
                                                        child: Text(
                                                          'seeAll'.tr,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            20.verticalSpace,
                                            CarouselSlider.builder(
                                                options: CarouselOptions(
                                                    height: 0.425.sh,
                                                    enlargeCenterPage: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    enableInfiniteScroll: false,
                                                    viewportFraction: 0.8),
                                                itemCount: _hc
                                                    .featuredEventList?.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int itemIndex,
                                                        int pageViewIndex) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          EventDetailScreen(
                                                            eventId: _hc
                                                                .featuredEventList![
                                                                    itemIndex]
                                                                .eventId!
                                                                .toInt()
                                                                .toString(),
                                                          ));
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
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            customCardImage(
                                                                _hc
                                                                        .featuredEventList![
                                                                            itemIndex]
                                                                        .postEventImages!
                                                                        .isNotEmpty
                                                                    ? _hc
                                                                        .featuredEventList![
                                                                            itemIndex]
                                                                        .postEventImages![
                                                                            0]
                                                                        .toString()
                                                                    : "null",
                                                                250.w,
                                                                160.h),
                                                            12.verticalSpace,
                                                            SizedBox(
                                                              width: 0.7.sw,
                                                              child: Text(
                                                                _hc
                                                                    .featuredEventList![
                                                                        itemIndex]
                                                                    .name
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
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            12.verticalSpace,
                                                            FittedBox(
                                                              child: Text(
                                                                splitDateTimeWithoutYear(_hc
                                                                    .featuredEventList![
                                                                        itemIndex]
                                                                    .eventDate
                                                                    .toString()),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kPrimaryColor),
                                                              ),
                                                            ),
                                                            12.verticalSpace,
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color:
                                                                          kPrimaryColor,
                                                                      size: 25,
                                                                    ),
                                                                    10.horizontalSpace,
                                                                    SizedBox(
                                                                      width: 0.5
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        _hc.featuredEventList![itemIndex]
                                                                            .city
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          //color: Color(0xff616161)
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    String
                                                                        data =
                                                                        '';
                                                                    if (_hc.featuredEventList![itemIndex]
                                                                            .isFav ==
                                                                        true) {
                                                                      data =
                                                                          "?eventID=${_hc.featuredEventList![itemIndex].eventId!.toInt()}&fav=false&customerID=$userId";
                                                                    } else {
                                                                      data =
                                                                          "?eventID=${_hc.featuredEventList![itemIndex].eventId!.toInt()}&fav=true&customerID=$userId";
                                                                    }

                                                                    var res = await ApiService()
                                                                        .addFavorite(
                                                                            data);
                                                                    if (res !=
                                                                            null &&
                                                                        res is String) {
                                                                      if (res
                                                                          .toUpperCase()
                                                                          .contains(
                                                                              "ADDED")) {
                                                                        _hc.featuredEventList![itemIndex].isFav =
                                                                            true;
                                                                        _hc.update();
                                                                      } else if (res
                                                                          .toUpperCase()
                                                                          .contains(
                                                                              "REMOVED")) {
                                                                        _hc.featuredEventList![itemIndex].isFav =
                                                                            false;
                                                                        _hc.update();
                                                                      }
                                                                      customSnackBar(
                                                                          'alert'
                                                                              .tr,
                                                                          res);
                                                                    }
                                                                  },
                                                                  child: Image
                                                                      .asset(
                                                                    _hc.featuredEventList![itemIndex].isFav ==
                                                                            true
                                                                        ? favoriteIconSelected
                                                                        : favoriteIcon,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                              20.verticalSpace,
                              _hc.upcomingEventListAll!.isEmpty
                                  ? SizedBox()
                                  : _hc.upcomingEventListAll!.isNotEmpty &&
                                          _hc.upcomingEventList!.isEmpty
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'upcomingEvent'.tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    Image.asset(fireIcon),
                                                  ],
                                                ),
                                                _hc.upcomingEventList!.length >
                                                        12
                                                    ? GestureDetector(
                                                        onTap: () => Get.to(
                                                            () => SeeAllEventsScreen(
                                                                name:
                                                                    'upcomingEvent'
                                                                        .tr,
                                                                img: fireIcon,
                                                                eventTypeId: _hc
                                                                    .upcomingEventList![
                                                                        0]
                                                                    .eventTypeId!
                                                                    .toInt()
                                                                    .toString()),
                                                            transition: Transition
                                                                .rightToLeft),
                                                        child: Text(
                                                          'seeAll'.tr,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            20.verticalSpace,
                                            Container(
                                              height: 45,
                                              width: 1.sw,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: _hc
                                                    .upcomingCategoryList
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _hc.selectUpcomingEventCategory(
                                                          index);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.0),
                                                      decoration: BoxDecoration(
                                                        color: _hc
                                                                    .upcomingCategoryList![
                                                                        index]
                                                                    .isSelected ==
                                                                true
                                                            ? kPrimaryColor
                                                            : Colors
                                                                .transparent,
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                kPrimaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          children: [
                                                            customCategoryImage(_hc
                                                                .upcomingCategoryList![
                                                                    index]
                                                                .imageURL
                                                                .toString()),
                                                            5.horizontalSpace,
                                                            Text(
                                                              _hc
                                                                  .upcomingCategoryList![
                                                                      index]
                                                                  .catagoryName
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: _hc.upcomingCategoryList![index].isSelected ==
                                                                          true
                                                                      ? Colors
                                                                          .white
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
                                            Column(
                                              children: [
                                                20.verticalSpace,
                                                Image.asset(
                                                  notFoundImage,
                                                  height: 250,
                                                ),
                                                10.verticalSpace,
                                                Text(
                                                  'notFound'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                10.verticalSpace,
                                              ],
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'upcomingEvent'.tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    Image.asset(fireIcon),
                                                  ],
                                                ),
                                                _hc.upcomingEventList!.length >
                                                        12
                                                    ? GestureDetector(
                                                        onTap: () => Get.to(
                                                            () => SeeAllEventsScreen(
                                                                name:
                                                                    'upcomingEvent'
                                                                        .tr,
                                                                img: fireIcon,
                                                                eventTypeId: _hc
                                                                    .upcomingEventList![
                                                                        0]
                                                                    .eventTypeId!
                                                                    .toInt()
                                                                    .toString()),
                                                            transition: Transition
                                                                .rightToLeft),
                                                        child: Text(
                                                          'seeAll'.tr,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            20.verticalSpace,
                                            Container(
                                              height: 45,
                                              width: 1.sw,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: _hc
                                                    .upcomingCategoryList
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _hc.selectUpcomingEventCategory(
                                                          index);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.0),
                                                      decoration: BoxDecoration(
                                                        color: _hc
                                                                    .upcomingCategoryList![
                                                                        index]
                                                                    .isSelected ==
                                                                true
                                                            ? kPrimaryColor
                                                            : Colors
                                                                .transparent,
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                kPrimaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          children: [
                                                            customCategoryImage(_hc
                                                                .upcomingCategoryList![
                                                                    index]
                                                                .imageURL
                                                                .toString()),
                                                            5.horizontalSpace,
                                                            Text(
                                                              _hc
                                                                  .upcomingCategoryList![
                                                                      index]
                                                                  .catagoryName
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: _hc.upcomingCategoryList![index].isSelected ==
                                                                          true
                                                                      ? Colors
                                                                          .white
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
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 1,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 20,
                                                        mainAxisExtent: 240),
                                                itemCount: _hc
                                                    .upcomingEventList?.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          EventDetailScreen(
                                                            eventId: _hc
                                                                .upcomingEventList![
                                                                    index]
                                                                .eventId!
                                                                .toInt()
                                                                .toString(),
                                                          ));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(12.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          color: Theme.of(
                                                                  context)
                                                              .secondaryHeaderColor),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          // mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            customCardImage(
                                                                _hc
                                                                        .upcomingEventList![
                                                                            index]
                                                                        .postEventImages!
                                                                        .isNotEmpty
                                                                    ? _hc
                                                                        .upcomingEventList![
                                                                            index]
                                                                        .postEventImages![
                                                                            0]
                                                                        .toString()
                                                                    : "null",
                                                                140.h,
                                                                100.h),
                                                            8.verticalSpace,
                                                            SizedBox(
                                                              width: 0.5.sw,
                                                              child: Text(
                                                                _hc
                                                                    .upcomingEventList![
                                                                        index]
                                                                    .name
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
                                                                splitDateTimeWithoutYear(_hc
                                                                    .upcomingEventList![
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
                                                                    size: 25,
                                                                  ),
                                                                  5.horizontalSpace,
                                                                  SizedBox(
                                                                    width:
                                                                        0.3.sw,
                                                                    child: Text(
                                                                      _hc
                                                                          .upcomingEventList![
                                                                              index]
                                                                          .city
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
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
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      String
                                                                          data =
                                                                          '';
                                                                      if (_hc.upcomingEventList![index]
                                                                              .isFav ==
                                                                          true) {
                                                                        data =
                                                                            "?eventID=${_hc.upcomingEventList![index].eventId!.toInt()}&fav=false&customerID=$userId";
                                                                      } else {
                                                                        data =
                                                                            "?eventID=${_hc.upcomingEventList![index].eventId!.toInt()}&fav=true&customerID=$userId";
                                                                      }

                                                                      var res =
                                                                          await ApiService()
                                                                              .addFavorite(data);
                                                                      if (res !=
                                                                              null &&
                                                                          res is String) {
                                                                        if (res
                                                                            .toUpperCase()
                                                                            .contains(
                                                                                "ADDED")) {
                                                                          _hc.upcomingEventList![index].isFav =
                                                                              true;
                                                                          _hc.update();
                                                                        } else if (res
                                                                            .toUpperCase()
                                                                            .contains("REMOVED")) {
                                                                          _hc.upcomingEventList![index].isFav =
                                                                              false;
                                                                          _hc.update();
                                                                        }
                                                                        customSnackBar(
                                                                            'alert'.tr,
                                                                            res);
                                                                      }
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      _hc.upcomingEventList![index].isFav ==
                                                                              true
                                                                          ? favoriteIconSelected
                                                                          : favoriteIcon,
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
                                              ),
                                            ),
                                          ],
                                        ),
                              20.verticalSpace,
                              _hc.shopListAll!.isEmpty
                                  ? SizedBox()
                                  : _hc.shopListAll!.isNotEmpty &&
                                          _hc.shopList!.isEmpty
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'shop'.tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    GetBuilder<
                                                            MyBasketController>(
                                                        builder: (_mbc) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              MyBasketScreen());
                                                        },
                                                        child: Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .shopping_cart,
                                                              size: 35,
                                                            ),
                                                            _mbc.myBasketProductsModel ==
                                                                        null ||
                                                                    _mbc.myBasketProductsModel!
                                                                        .isEmpty
                                                                ? SizedBox()
                                                                : Positioned(
                                                                    top: -15,
                                                                    right: -5,
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              3.0,
                                                                          horizontal:
                                                                              8),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              6.0),
                                                                          color:
                                                                              Colors.red),
                                                                      child:
                                                                          Text(
                                                                        _mbc.myBasketProductsModel!
                                                                            .length
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ],
                                                ),
                                                _hc.shopList!.length > 12
                                                    ? GestureDetector(
                                                        onTap: () => Get.to(
                                                            () =>
                                                                SeeAllProductsScreen(),
                                                            transition: Transition
                                                                .rightToLeft),
                                                        child: Text(
                                                          'seeAll'.tr,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            20.verticalSpace,
                                            Container(
                                              height: 45,
                                              width: 1.sw,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: _hc
                                                    .shopCategoryList?.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _hc.selectShopCategory(
                                                          index);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.0),
                                                      decoration: BoxDecoration(
                                                        color: _hc
                                                                    .shopCategoryList![
                                                                        index]
                                                                    .isSelected ==
                                                                true
                                                            ? kPrimaryColor
                                                            : Colors
                                                                .transparent,
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                kPrimaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          children: [
                                                            customCategoryImage(_hc
                                                                .upcomingCategoryList![
                                                                    index]
                                                                .imageURL
                                                                .toString()),
                                                            5.horizontalSpace,
                                                            Text(
                                                              _hc
                                                                  .shopCategoryList![
                                                                      index]
                                                                  .catagoryName
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: _hc.shopCategoryList![index].isSelected ==
                                                                          true
                                                                      ? Colors
                                                                          .white
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
                                            Column(
                                              children: [
                                                20.verticalSpace,
                                                Image.asset(
                                                  notFoundImage,
                                                  height: 250,
                                                ),
                                                10.verticalSpace,
                                                Text(
                                                  'notFound'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                10.verticalSpace,
                                              ],
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'shop'.tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    GetBuilder<
                                                            MyBasketController>(
                                                        builder: (_mbc) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              MyBasketScreen());
                                                        },
                                                        child: Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .shopping_cart,
                                                              size: 35,
                                                            ),
                                                            _mbc.myBasketProductsModel ==
                                                                        null ||
                                                                    _mbc.myBasketProductsModel!
                                                                        .isEmpty
                                                                ? SizedBox()
                                                                : Positioned(
                                                                    top: -15,
                                                                    right: -5,
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              3.0,
                                                                          horizontal:
                                                                              8),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              6.0),
                                                                          color:
                                                                              Colors.red),
                                                                      child:
                                                                          Text(
                                                                        _mbc.myBasketProductsModel!
                                                                            .length
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ],
                                                ),
                                                _hc.shopList!.length > 12
                                                    ? GestureDetector(
                                                        onTap: () => Get.to(
                                                            () =>
                                                                SeeAllProductsScreen(),
                                                            transition: Transition
                                                                .rightToLeft),
                                                        child: Text(
                                                          'seeAll'.tr,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            20.verticalSpace,
                                            Container(
                                              height: 45,
                                              width: 1.sw,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: _hc
                                                    .shopCategoryList?.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _hc.selectShopCategory(
                                                          index);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.0),
                                                      decoration: BoxDecoration(
                                                        color: _hc
                                                                    .shopCategoryList![
                                                                        index]
                                                                    .isSelected ==
                                                                true
                                                            ? kPrimaryColor
                                                            : Colors
                                                                .transparent,
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                kPrimaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Row(
                                                          children: [
                                                            customCategoryImage(_hc
                                                                .upcomingCategoryList![
                                                                    index]
                                                                .imageURL
                                                                .toString()),
                                                            5.horizontalSpace,
                                                            Text(
                                                              _hc
                                                                  .shopCategoryList![
                                                                      index]
                                                                  .catagoryName
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: _hc.shopCategoryList![index].isSelected ==
                                                                          true
                                                                      ? Colors
                                                                          .white
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
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 1,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 20,
                                                        mainAxisExtent: 255),
                                                itemCount: _hc.shopList?.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          ViewProductScreen(
                                                            productId: _hc
                                                                .shopList![
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            categoryId: _hc
                                                                .shopList![
                                                                    index]
                                                                .catagoryId
                                                                .toString(),
                                                          ));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(12.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          color: Theme.of(
                                                                  context)
                                                              .secondaryHeaderColor),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          // mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            customCardImage(
                                                                _hc
                                                                        .shopList![
                                                                            index]
                                                                        .productImages!
                                                                        .isNotEmpty
                                                                    ? _hc
                                                                        .shopList![
                                                                            index]
                                                                        .productImages![
                                                                            0]
                                                                        .toString()
                                                                    : "null",
                                                                140.h,
                                                                120.h),
                                                            8.verticalSpace,
                                                            SizedBox(
                                                              width: 0.5.sw,
                                                              child: Text(
                                                                _hc
                                                                    .shopList![
                                                                        index]
                                                                    .productName
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
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            5.verticalSpace,
                                                            Text(
                                                              _hc
                                                                  .shopList![
                                                                      index]
                                                                  .productFor
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            5.verticalSpace,
                                                            FittedBox(
                                                              child: Text(
                                                                _hc
                                                                    .shopList![
                                                                        index]
                                                                    .price
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        kPrimaryColor),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                              20.verticalSpace,
                              _hc.newsListAll.isEmpty
                                  ? SizedBox()
                                  : _hc.newsListAll.isNotEmpty &&
                                          _hc.newsList.isEmpty
                                      ? Column(
                                          children: [
                                            20.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'news'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            20.verticalSpace,
                                            Image.asset(
                                              notFoundImage,
                                              height: 250,
                                            ),
                                            10.verticalSpace,
                                            Text(
                                              'notFound'.tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            10.verticalSpace,
                                          ],
                                        )
                                      : Column(children: [
                                          20.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'news'.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              _hc.newsList.length > 12
                                                  ? GestureDetector(
                                                      onTap: () => Get.to(
                                                          () =>
                                                              SeeAllNewsScreen(),
                                                          transition: Transition
                                                              .rightToLeft),
                                                      child: Text(
                                                        'seeAll'.tr,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                          20.verticalSpace,
                                          CarouselSlider.builder(
                                              options: CarouselOptions(
                                                  height: 0.425.sh,
                                                  enlargeCenterPage: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  enableInfiniteScroll: false,
                                                  viewportFraction: 0.8),
                                              itemCount:
                                                  _hc.newsList.length > 12
                                                      ? 12
                                                      : _hc.newsList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int itemIndex,
                                                      int pageViewIndex) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                        () => NewsDetailScreen(
                                                              newsModel: _hc
                                                                      .newsList[
                                                                  itemIndex],
                                                            ));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        color: Theme.of(context)
                                                            .secondaryHeaderColor),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          customCardImage(
                                                              _hc.newsList[itemIndex].imageUrl ==
                                                                          null ||
                                                                      _hc
                                                                          .newsList[
                                                                              itemIndex]
                                                                          .imageUrl!
                                                                          .trim()
                                                                          .isEmpty
                                                                  ? "null"
                                                                  : _hc
                                                                      .newsList[
                                                                          itemIndex]
                                                                      .imageUrl
                                                                      .toString(),
                                                              250.w,
                                                              160.h),
                                                          12.verticalSpace,
                                                          SizedBox(
                                                            width: 0.7.sw,
                                                            child: Text(
                                                              _hc
                                                                  .newsList[
                                                                      itemIndex]
                                                                  .title
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          12.verticalSpace,
                                                          SizedBox(
                                                            width: 0.7.sw,
                                                            child: FittedBox(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        'learnMore'
                                                                            .tr,
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: kPrimaryColor),
                                                                      ),
                                                                      3.horizontalSpace,
                                                                      Icon(
                                                                        Icons
                                                                            .arrow_outward,
                                                                        size:
                                                                            20,
                                                                        color:
                                                                            kPrimaryColor,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    splitDateForNews(_hc
                                                                        .newsList[
                                                                            itemIndex]
                                                                        .scheduled
                                                                        .toString()),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                        ])
                            ],
                          ),
                        ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<String> getLocationName(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    return "${place.subLocality}, ${place.locality}, ${place.country}";
  }

  String getWelcomeMessage() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    if (currentHour >= 6 && currentHour < 12) {
      return 'goodMorning'.tr;
    } else if (currentHour >= 12 && currentHour < 18) {
      return 'goodAfternoon'.tr;
    } else if (currentHour >= 18 && currentHour < 24) {
      return 'goodEvening'.tr;
    } else {
      return 'goodNight'.tr;
    }
  }
}
