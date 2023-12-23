import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/seeAllEventController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/model/CategoryModel.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';

class SeeAllEventsScreen extends StatefulWidget {
  final String name;
  final String img;
  final String eventTypeId;
  const SeeAllEventsScreen(
      {super.key,
      required this.name,
      required this.img,
      required this.eventTypeId});

  @override
  State<SeeAllEventsScreen> createState() => _SeeAllEventsScreenState();
}

class _SeeAllEventsScreenState extends State<SeeAllEventsScreen> {
  // final _searchController = TextEditingController();
  final _seeAllEventController = Get.put(SeeAllEventController());
  // Timer? _debounceTimer;

  String? latitude;
  String? longitude;
  Position? position;
  LocationPermission? permission;

  @override
  void initState() {
    super.initState();
    _seeAllEventController.eventTypeId = widget.eventTypeId;
    getData();
    _seeAllEventController.locationsList.isEmpty ? getLocationsList() : null;

    checkLocationPermission();
  }

  getData() async {
    var res = await ApiService().getEventsByType(widget.eventTypeId);
    if (res != null && res is List) {
      _seeAllEventController.addSeeAllData(res);
    } else if (res != null && res is String) {
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getLocationsList() async {
    var res = await ApiService().getAllLocations();

    if (res != null && res is List) {
      _seeAllEventController.addLocations(res);
    }
  }

  @override
  void dispose() {
    _seeAllEventController.searchController.clear();
    _seeAllEventController.isSearch = false;
    _seeAllEventController.distanceValue = 100.0;

    // _seeAllEventController.cityListForFilter = [];
    _seeAllEventController.selectedLocation = null;

    _seeAllEventController.filterCategoryList?.forEach((element) {
      element.isSelected = false;
    });
    _seeAllEventController.filterCategoryList?[0].isSelected = true;

    super.dispose();
  }

  // void _onTextChanged() {
  //   if (_debounceTimer?.isActive ?? false) {
  //     _debounceTimer!.cancel();
  //   }

  //   _debounceTimer = Timer(Duration(milliseconds: 1200), () async {
  //     if (_seeAllEventController.isSearch &&
  //         _searchController.text.trim() != '') {
  //       var res = await ApiService()
  //           .getEventSearch(context, _searchController.text.trim());
  //       if (res != null && res is List) {
  //         _seeAllEventController.addSeeAllData(res);
  //       } else {
  //         customSnackBar(error, somethingWentWrong);
  //       }
  //     }
  //   });
  // }

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
        body: GetBuilder<SeeAllEventController>(builder: (_sc) {
          return Container(
            height: 1.sh,
            width: 1.sw,
            child: _sc.seeAllEventModel == null
                ? Center(
                    child: spinkit,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        20.verticalSpace,
                        _sc.isSearch
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () => Get.back(),
                                      icon: Icon(Icons.arrow_back)),
                                  Expanded(
                                    child: TextFormField(
                                      focusNode: _sc.searchFocusNode,
                                      cursorColor: kPrimaryColor,
                                      controller: _sc.searchController,
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
                                            color: _sc.iconColorSearch,
                                          ),
                                          suffixIcon: GestureDetector(
                                              onTap: () =>
                                                  filterBottomSheetSeeAll(
                                                      context),
                                              child: Image.asset(filterIcon)),
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
                                          hintText: "search".tr,
                                          hintStyle: TextStyle(
                                              color: Color(0xff9E9E9E),
                                              fontSize: 14)),
                                      //onChanged: _sc.searchEvent,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            textRegExp),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _sc.isSearchOrNot(false);
                                        _sc.searchController.clear();
                                        _sc.seeAllEventModel = null;
                                        _sc.update();
                                        getData();
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
                                      IconButton(
                                          onPressed: () => Get.back(),
                                          icon: Icon(Icons.arrow_back)),
                                      Text(
                                        widget.name.toString(),
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
                                        _sc.isSearchOrNot(true);
                                      },
                                      icon: Icon(Icons.search))
                                ],
                              ),
                        20.verticalSpace,
                        Container(
                          height: 45,
                          width: 1.sw,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _sc.seeAllCategoryList?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _sc.selectSeeAllCategory(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  decoration: BoxDecoration(
                                    color: _sc.seeAllCategoryList![index]
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
                                        customCategoryImage(_sc
                                            .seeAllCategoryList![index].imageURL
                                            .toString()),
                                        5.horizontalSpace,
                                        Text(
                                          _sc.seeAllCategoryList![index]
                                              .catagoryName
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  _sc.seeAllCategoryList![index]
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
                              _sc.seeAllEventModel!.length.toString() +
                                  " " +
                                  'found'.tr,
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
                                      _sc.isListSelectedOrNot(true);
                                    },
                                    icon: Icon(
                                      Icons.list_alt,
                                      color: _sc.isListSelected
                                          ? kPrimaryColor
                                          : kDisabledColor,
                                      size: 25,
                                    )),
                                5.horizontalSpace,
                                IconButton(
                                    onPressed: () {
                                      _sc.isListSelectedOrNot(false);
                                    },
                                    icon: Icon(
                                      Icons.grid_view,
                                      color: _sc.isListSelected
                                          ? kDisabledColor
                                          : kPrimaryColor,
                                      size: 25,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        5.verticalSpace,
                        _sc.seeAllEventModel!.isEmpty
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
                                      'notFound'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    10.verticalSpace,
                                    Text(
                                      'foundSubString'.tr,
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
                                    !_sc.isListSelected
                                        ? Container(
                                            child: GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 1,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 20,
                                                    mainAxisExtent: 280),
                                            itemCount:
                                                _sc.seeAllEventModel?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      () => EventDetailScreen(
                                                          eventId: _sc
                                                              .seeAllEventModel![
                                                                  index]
                                                              .eventId
                                                              .toString()),
                                                      transition: Transition
                                                          .rightToLeft);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                  child: Column(
                                                    // mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      customCardImage(
                                                          _sc
                                                                  .seeAllEventModel![
                                                                      index]
                                                                  .postEventImages!
                                                                  .isNotEmpty
                                                              ? _sc
                                                                  .seeAllEventModel![
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
                                                          _sc
                                                              .seeAllEventModel![
                                                                  index]
                                                              .name
                                                              .toString(),
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
                                                          splitDateTimeWithoutYear(_sc
                                                              .seeAllEventModel![
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
                                                      _sc
                                                                      .seeAllEventModel![
                                                                          index]
                                                                      .reviewRating !=
                                                                  null &&
                                                              (_sc
                                                                  .seeAllEventModel![
                                                                      index]
                                                                  .reviewRating is num)
                                                          ? SizedBox(
                                                              width: 0.4.sw,
                                                              child: RatingBar(
                                                                ignoreGestures:
                                                                    true,
                                                                itemSize: 20,
                                                                initialRating: _sc
                                                                    .seeAllEventModel![
                                                                        index]
                                                                    .reviewRating!
                                                                    .toDouble(),
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                ratingWidget:
                                                                    RatingWidget(
                                                                  full: Icon(
                                                                    Icons.star,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                  half: Icon(
                                                                    Icons
                                                                        .star_half,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                  empty: Icon(
                                                                    Icons
                                                                        .star_border,
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                ),
                                                                itemPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                onRatingUpdate:
                                                                    (rating) =>
                                                                        null,
                                                              ),
                                                            )
                                                          : SizedBox(),
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
                                                                _sc
                                                                    .seeAllEventModel![
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
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                            5.horizontalSpace,
                                                            GestureDetector(
                                                              onTap: () async {
                                                                String data =
                                                                    '';
                                                                if (_sc
                                                                        .seeAllEventModel![
                                                                            index]
                                                                        .isFav ==
                                                                    true) {
                                                                  data =
                                                                      "?eventID=${_sc.seeAllEventModel![index].eventId!.toInt()}&fav=false&customerID=$userId";
                                                                } else {
                                                                  data =
                                                                      "?eventID=${_sc.seeAllEventModel![index].eventId!.toInt()}&fav=true&customerID=$userId";
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
                                                                    _sc
                                                                        .seeAllEventModel![
                                                                            index]
                                                                        .isFav = true;
                                                                    _sc.update();
                                                                  } else if (res
                                                                      .toUpperCase()
                                                                      .contains(
                                                                          "REMOVED")) {
                                                                    _sc
                                                                        .seeAllEventModel![
                                                                            index]
                                                                        .isFav = false;
                                                                    _sc.update();
                                                                  }
                                                                  customSnackBar(
                                                                      'alert'
                                                                          .tr,
                                                                      res);
                                                                }
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                _sc.seeAllEventModel![index]
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
                                              );
                                            },
                                          ))
                                        : ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                _sc.seeAllEventModel?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      () => EventDetailScreen(
                                                          eventId: _sc
                                                              .seeAllEventModel![
                                                                  index]
                                                              .eventId
                                                              .toString()),
                                                      transition: Transition
                                                          .rightToLeft);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        color: Theme.of(context)
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
                                                            _sc
                                                                    .seeAllEventModel![
                                                                        index]
                                                                    .postEventImages!
                                                                    .isNotEmpty
                                                                ? _sc
                                                                    .seeAllEventModel![
                                                                        index]
                                                                    .postEventImages![
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
                                                                _sc
                                                                    .seeAllEventModel![
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
                                                                splitDateTimeWithoutYear(_sc
                                                                    .seeAllEventModel![
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
                                                            _sc.seeAllEventModel![index].reviewRating !=
                                                                        null &&
                                                                    (_sc
                                                                        .seeAllEventModel![
                                                                            index]
                                                                        .reviewRating is num)
                                                                ? SizedBox(
                                                                    width:
                                                                        0.4.sw,
                                                                    child:
                                                                        RatingBar(
                                                                      ignoreGestures:
                                                                          true,
                                                                      itemSize:
                                                                          20,
                                                                      initialRating: _sc
                                                                          .seeAllEventModel![
                                                                              index]
                                                                          .reviewRating!
                                                                          .toDouble(),
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      allowHalfRating:
                                                                          true,
                                                                      itemCount:
                                                                          5,
                                                                      ratingWidget:
                                                                          RatingWidget(
                                                                        full:
                                                                            Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              kPrimaryColor,
                                                                        ),
                                                                        half:
                                                                            Icon(
                                                                          Icons
                                                                              .star_half,
                                                                          color:
                                                                              kPrimaryColor,
                                                                        ),
                                                                        empty:
                                                                            Icon(
                                                                          Icons
                                                                              .star_border,
                                                                          color:
                                                                              kPrimaryColor,
                                                                        ),
                                                                      ),
                                                                      itemPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      onRatingUpdate:
                                                                          (rating) =>
                                                                              null,
                                                                    ),
                                                                  )
                                                                : SizedBox(),
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
                                                                      _sc
                                                                          .seeAllEventModel![
                                                                              index]
                                                                          .city
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
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
                                                                      if (_sc.seeAllEventModel![index]
                                                                              .isFav ==
                                                                          true) {
                                                                        data =
                                                                            "?eventID=${_sc.seeAllEventModel![index].eventId!.toInt()}&fav=false&customerID=$userId";
                                                                      } else {
                                                                        data =
                                                                            "?eventID=${_sc.seeAllEventModel![index].eventId!.toInt()}&fav=true&customerID=$userId";
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
                                                                          _sc.seeAllEventModel![index].isFav =
                                                                              true;
                                                                          _sc.update();
                                                                        } else if (res
                                                                            .toUpperCase()
                                                                            .contains("REMOVED")) {
                                                                          _sc.seeAllEventModel![index].isFav =
                                                                              false;
                                                                          _sc.update();
                                                                        }
                                                                        customSnackBar(
                                                                            'alert'.tr,
                                                                            res);
                                                                      }
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      _sc.seeAllEventModel![index].isFav ==
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
          );
        }),
      ),
    );
  }

  filterBottomSheetSeeAll(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return GetBuilder<SeeAllEventController>(builder: (_sae) {
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
                          'filter'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: kDisabledColor,
                        ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'eventCategory'.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        Container(
                          height: 45,
                          width: 1.sw,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _sae.filterCategoryList?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _sae.filterCategoryList?.forEach((element) {
                                    element.isSelected = false;
                                  });
                                  _sae.filterCategoryList?[index].isSelected =
                                      true;

                                  _sae.seeAllCategoryList?.forEach((element) {
                                    element.isSelected = false;
                                  });
                                  _sae.seeAllCategoryList?[index].isSelected =
                                      true;
                                  _sae.update();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  decoration: BoxDecoration(
                                    color: _sae.filterCategoryList![index]
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
                                        customCategoryImage(_sae
                                            .filterCategoryList![index].imageURL
                                            .toString()),
                                        5.horizontalSpace,
                                        Text(
                                          _sae.filterCategoryList![index]
                                              .catagoryName
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: _sae
                                                          .filterCategoryList![
                                                              index]
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'location'.tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: DropdownButtonFormField(
                            dropdownColor:
                                Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12.0),
                            decoration: InputDecoration(
                                constraints: BoxConstraints(),
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                            alignment: AlignmentDirectional.centerStart,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                              // color: Colors.black,
                            ),
                            iconEnabledColor: kDisabledColor,
                            hint: Text(
                              "Please select",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            value: _sae.selectedLocation,
                            onChanged: (value) {
                              _sae.selectedLocation = value;
                              _sae.update();
                            },
                            items: _sae.locationsList //items
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item.locationName,
                                    child: Text(
                                      item.locationName.toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        20.verticalSpace,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'eventLocationRange'.tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                inactiveColor: kDisabledColor,
                                activeColor: kPrimaryColor,
                                value: _sae.distanceValue,
                                min: 0,
                                max: 100,
                                divisions: 100,
                                label:
                                    "${_sae.distanceValue.toInt().toString()} km",
                                onChanged: (double values) {
                                  _sae.updateDistanceValues(values);
                                },
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _sae.resetHomeFilter();
                              },
                              child: Container(
                                height: 50,
                                width: 0.3.sw,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Center(
                                  child: Text('reset'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ),
                              ),
                            ),
                            20.horizontalSpace,
                            GestureDetector(
                              onTap: () async {
                                Get.back();
                                CategoryModel catId = _sae.filterCategoryList!
                                    .firstWhere((element) =>
                                        element.isSelected == true);
                                String selectedLocation =
                                    _sae.selectedLocation != null
                                        ? _sae.selectedLocation!
                                        : '';
                                String filterData;

                                if (selectedLocation == '') {
                                  if (catId.id?.toInt() == 1) {
                                    filterData =
                                        "?searchText=${_sae.searchController.text.trim()}&eventDate&eventCategoryId=&eventTypeId=${_sae.eventTypeId}&cityName=";
                                  } else {
                                    filterData =
                                        "?searchText=${_sae.searchController.text.trim()}&eventDate&eventCategoryId=${catId.id!.toInt().toString()}&eventTypeId=${_sae.eventTypeId}&cityName=";
                                  }
                                } else {
                                  if (catId.id?.toInt() == 1) {
                                    filterData =
                                        "?searchText=${_sae.searchController.text.trim()}&eventDate&eventCategoryId=&eventTypeId=${_sae.eventTypeId}&cityName=$selectedLocation";
                                  } else {
                                    filterData =
                                        "?searchText=${_sae.searchController.text.trim()}&eventDate&eventCategoryId=${catId.id!.toInt().toString()}&eventTypeId=${_sae.eventTypeId}&cityName=$selectedLocation";
                                  }
                                }

                                var res = await ApiService()
                                    .getEventSearch(Get.context!, filterData);
                                if (res != null && res is List) {
                                  _sae.addSeeAllData(res);
                                } else {
                                  customSnackBar(
                                      'error'.tr, 'somethingWentWrong'.tr);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 0.3.sw,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: Center(
                                  child: Text('apply'.tr,
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
        });
      },
    );
  }

  checkLocationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        getLatLng();
      } else if (permission == LocationPermission.deniedForever) {
        customAlertDialogForPermission(
            context,
            backgroundLogo,
            Icons.location_on,
            'enableLocation'.tr,
            'locationDialogSubString'.tr,
            'enableLocation'.tr,
            'cancel'.tr, () {
          openAppSettings().then((value) {
            //checkLocationPermission();
          });
          Get.back();
        });
      }
    } else if (permission == LocationPermission.deniedForever) {
      customAlertDialogForPermission(
          context,
          backgroundLogo,
          Icons.location_on,
          'enableLocation'.tr,
          'locationDialogSubString'.tr,
          'enableLocation'.tr,
          'cancel'.tr, () {
        openAppSettings().then((value) {
          //checkLocationPermission();
        });
        Get.back();
      });
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      getLatLng();
    }
  }

  getLatLng() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (position != null) {
      latitude = position?.latitude.toString();
      longitude = position?.longitude.toString();
    }
    // _seeAllEventController.cityListForFilter = await getCitiesByCountry(
    //     double.parse(latitude!), double.parse(longitude!));
  }

  // Future<List<String>> getCitiesByCountry(
  //     double latitude, double longitude) async {
  //   try {
  //     final placemarks = await placemarkFromCoordinates(latitude, longitude,
  //         localeIdentifier: 'en_US');
  //     final cityNames = placemarks
  //         .where((placemark) => placemark.name != null)
  //         .map((placemark) => placemark.name!)
  //         .toList();

  //     return cityNames.toSet().toList();
  //   } catch (e) {
  //     print("Error: $e");
  //     return [];
  //   }
  // }
}
