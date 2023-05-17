import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/NavigationBarController.dart';
import 'package:tiqarte/controller/homeController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';
import 'package:tiqarte/view/NotificationScreen.dart';
import 'package:tiqarte/view/SeeAllEventsScreen.dart';
import 'package:tiqarte/view/SeeAllProductsScreen.dart';
import 'package:tiqarte/view/ViewProductScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  // List upcomingEventsCatergoryList = [
  //   {"name": homeAllString, "icon": allIcon, "isSelected": true},
  //   {"name": homeMusicString, "icon": musicIcon, "isSelected": false},
  //   {"name": homeArtString, "icon": artIcon, "isSelected": false},
  //   {"name": homeWorkshopsString, "icon": workshopIcon, "isSelected": false}
  // ];

  final _homeController = Get.put(HomeController());
  final nbc = Get.put(NavigationBarController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getHomeData();
    if (res != null && res is Map) {
      _homeController.addHomeData(res);
    } else if (res != null && res is String) {
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          automaticallyImplyLeading: kFlutterMemoryAllocationsEnabled,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: GetBuilder<HomeController>(builder: (_hc) {
              return _hc.homeDataModel.welcomeMessage == null &&
                      _hc.upcomingCategoryList == null
                  ? Center(
                      child: spinkit,
                    )
                  : Column(
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
                                      _hc.homeDataModel.profilePictureUrl
                                          .toString(),
                                      40.h,
                                      40.h),
                                ),
                                15.horizontalSpace,
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          _hc.homeDataModel.welcomeMessage
                                              .toString(),
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
                                        _hc.homeDataModel.userName.toString(),
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
                            InkWell(
                              onTap: () => Get.to(() => NotificationScreen(),
                                  transition: Transition.rightToLeft),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                      color: kDisabledColor, width: 1),
                                  // image: DecorationImage(
                                  //   image: AssetImage(notificationIconWithBadge),
                                  // )
                                ),
                                child: Center(
                                  child: Image.asset(notificationIcon,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
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
                              hintStyle: TextStyle(
                                  color: Color(0xff9E9E9E), fontSize: 14)),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(textRegExp),
                          ],
                        ),
                        10.verticalSpace,
                        Expanded(
                          child: ListView(
                            children: [
                              _hc.homeDataModel.featuredEvents!.isEmpty
                                  ? SizedBox()
                                  : Column(
                                      children: [
                                        20.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              featured,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            _hc.homeDataModel.featuredEvents!
                                                        .length >
                                                    12
                                                ? InkWell(
                                                    onTap: () => Get.to(
                                                        () =>
                                                            SeeAllEventsScreen(
                                                                name: featured,
                                                                img: ''),
                                                        transition: Transition
                                                            .rightToLeft),
                                                    child: Text(
                                                      seeAll,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kPrimaryColor),
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
                                            itemCount: _hc.homeDataModel
                                                .featuredEvents?.length,
                                            itemBuilder: (BuildContext context,
                                                int itemIndex,
                                                int pageViewIndex) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () => EventDetailScreen(
                                                            eventId: _hc
                                                                .homeDataModel
                                                                .featuredEvents![
                                                                    itemIndex]
                                                                .eventId!
                                                                .toInt()
                                                                .toString(),
                                                          ));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        customCardImage(
                                                            _hc
                                                                .homeDataModel
                                                                .featuredEvents![
                                                                    itemIndex]
                                                                .eventImages![0],
                                                            250.w,
                                                            160.h),
                                                        12.verticalSpace,
                                                        SizedBox(
                                                          width: 0.7.sw,
                                                          child: Text(
                                                            _hc
                                                                .homeDataModel
                                                                .featuredEvents![
                                                                    itemIndex]
                                                                .name
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
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
                                                                .homeDataModel
                                                                .featuredEvents![
                                                                    itemIndex]
                                                                .eventDate
                                                                .toString()),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 18,
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
                                                                  width: 0.5.sw,
                                                                  child: Text(
                                                                    _hc
                                                                        .homeDataModel
                                                                        .featuredEvents![
                                                                            itemIndex]
                                                                        .city
                                                                        .toString(),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      //color: Color(0xff616161)
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                String data =
                                                                    "?eventID=${_hc.homeDataModel.featuredEvents![itemIndex].eventId!.toInt()}&fav=true&customerID=${_hc.homeDataModel.featuredEvents![itemIndex].creationUserId!.toInt()}";

                                                                var res = await ApiService()
                                                                    .addFavorite(
                                                                        data);
                                                                if (res !=
                                                                        null &&
                                                                    res is String) {
                                                                  customSnackBar(
                                                                      "Alert!",
                                                                      res);
                                                                }
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                _hc.homeDataModel.featuredEvents![itemIndex]
                                                                            .isFav ==
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
                              _hc.homeDataModel.upComingEvents!.isEmpty
                                  ? SizedBox()
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            _hc.homeDataModel.upComingEvents!
                                                        .length >
                                                    12
                                                ? InkWell(
                                                    onTap: () => Get.to(
                                                        () => SeeAllEventsScreen(
                                                            name: upcomingEvent,
                                                            img: fireIcon),
                                                        transition: Transition
                                                            .rightToLeft),
                                                    child: Text(
                                                      seeAll,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kPrimaryColor),
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
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _hc
                                                .upcomingCategoryList?.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  _hc.selectUpcomingEventCategory(
                                                      index);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                                  decoration: BoxDecoration(
                                                    color: _hc
                                                                .upcomingCategoryList![
                                                                    index]
                                                                .isSelected ==
                                                            true
                                                        ? kPrimaryColor
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: [
                                                        // Image.asset(
                                                        //     upcomingEventsCatergoryList[
                                                        //         index]['icon']),
                                                        5.horizontalSpace,
                                                        Text(
                                                          _hc
                                                              .upcomingCategoryList![
                                                                  index]
                                                              .catagoryName
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: _hc.upcomingCategoryList![index]
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
                                            itemCount: _hc.homeDataModel
                                                .upComingEvents?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () => EventDetailScreen(
                                                            eventId: _hc
                                                                .homeDataModel
                                                                .upComingEvents![
                                                                    index]
                                                                .eventId!
                                                                .toInt()
                                                                .toString(),
                                                          ));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(12.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      // mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        customCardImage(
                                                            _hc
                                                                .homeDataModel
                                                                .upComingEvents![
                                                                    index]
                                                                .eventImages![0]
                                                                .toString(),
                                                            140.h,
                                                            100.h),
                                                        8.verticalSpace,
                                                        SizedBox(
                                                          width: 0.5.sw,
                                                          child: Text(
                                                            _hc
                                                                .homeDataModel
                                                                .upComingEvents![
                                                                    index]
                                                                .name
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
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
                                                            splitDateTimeWithoutYear(_hc
                                                                .homeDataModel
                                                                .upComingEvents![
                                                                    index]
                                                                .eventDate
                                                                .toString()),
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
                                                                  _hc
                                                                      .homeDataModel
                                                                      .upComingEvents![
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
                                                                onTap:
                                                                    () async {
                                                                  String data =
                                                                      '';
                                                                  if (_hc
                                                                          .homeDataModel
                                                                          .upComingEvents![
                                                                              index]
                                                                          .isFav ==
                                                                      true) {
                                                                    data =
                                                                        "?eventID=${_hc.homeDataModel.upComingEvents![index].eventId!.toInt()}&fav=true&customerID=${_hc.homeDataModel.upComingEvents![index].creationUserId!.toInt()}";
                                                                  } else {
                                                                    data =
                                                                        "?eventID=${_hc.homeDataModel.upComingEvents![index].eventId!.toInt()}&fav=false&customerID=${_hc.homeDataModel.upComingEvents![index].creationUserId!.toInt()}";
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
                                                                      _hc
                                                                          .homeDataModel
                                                                          .upComingEvents![
                                                                              index]
                                                                          .isFav = true;
                                                                      _hc.update();
                                                                    } else if (res
                                                                        .toUpperCase()
                                                                        .contains(
                                                                            "REMOVED")) {
                                                                      _hc
                                                                          .homeDataModel
                                                                          .upComingEvents![
                                                                              index]
                                                                          .isFav = false;
                                                                      _hc.update();
                                                                    }
                                                                    customSnackBar(
                                                                        "Alert!",
                                                                        res);
                                                                  }
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  _hc.homeDataModel.upComingEvents![index]
                                                                              .isFav ==
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
                              _hc.homeDataModel.shop!.isEmpty
                                  ? SizedBox()
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              shop,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            _hc.homeDataModel.shop!.length > 12
                                                ? InkWell(
                                                    onTap: () => Get.to(
                                                        () =>
                                                            SeeAllProductsScreen(),
                                                        transition: Transition
                                                            .rightToLeft),
                                                    child: Text(
                                                      seeAll,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kPrimaryColor),
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
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                _hc.shopCategoryList?.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  _hc.selectShopCategory(index);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                                  decoration: BoxDecoration(
                                                    color: _hc
                                                                .shopCategoryList![
                                                                    index]
                                                                .isSelected ==
                                                            true
                                                        ? kPrimaryColor
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: [
                                                        // Image.asset(
                                                        //     upcomingEventsCatergoryList[
                                                        //         index]['icon']),
                                                        5.horizontalSpace,
                                                        Text(
                                                          _hc
                                                              .shopCategoryList![
                                                                  index]
                                                              .catagoryName
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: _hc.shopCategoryList![index]
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
                                            itemCount:
                                                _hc.homeDataModel.shop?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ViewProductScreen());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(12.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      // mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        customCardImage(
                                                            _hc
                                                                .homeDataModel
                                                                .shop![index]
                                                                .image
                                                                .toString(),
                                                            140.h,
                                                            120.h),
                                                        8.verticalSpace,
                                                        SizedBox(
                                                          width: 0.5.sw,
                                                          child: Text(
                                                            _hc
                                                                .homeDataModel
                                                                .shop![index]
                                                                .name
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        5.verticalSpace,
                                                        Text(
                                                          forMen,
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        5.verticalSpace,
                                                        FittedBox(
                                                          child: Text(
                                                            _hc
                                                                .homeDataModel
                                                                .shop![index]
                                                                .price
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 16,
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
                                    )
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
}
