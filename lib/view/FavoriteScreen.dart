import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/favoriteController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/highlightedText.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _favoriteController = Get.put(FavoriteController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getFavorites(userId);
    if (res != null && res is List) {
      _favoriteController.addFavoriteData(res);
    } else if (res != null && res is String) {
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  @override
  void dispose() {
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
                                      controller: _fc.searchController,
                                      //  style: const TextStyle(color: Colors.black),
                                      // keyboardType: TextInputType.text,
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
                                          hintText: "search".tr,
                                          hintStyle: TextStyle(
                                              color: Color(0xff9E9E9E),
                                              fontSize: 14)),
                                      onChanged: _fc.searchEvent,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            alphanumeric),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _fc.onSearchClose(_fc.searchController);
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
                                        'favorites'.tr,
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
                                      // 10.horizontalSpace,
                                      // GestureDetector(
                                      //     onTap: () => filterBottomSheet(
                                      //         context,
                                      //         eventsCatergoryList,
                                      //         locationList,
                                      //         selectedLocation,
                                      //         currentRangeValues),
                                      //     child: Image.asset(
                                      //       filterIcon,
                                      //     )),
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
                              return GestureDetector(
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
                                        customCategoryImage(_fc
                                            .favCategoryList![index].imageURL
                                            .toString()),
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
                              _fc.favoriteList!.length > 1
                                  ? _fc.favoriteList!.length.toString() +
                                      " " +
                                      'favorites'.tr.toLowerCase()
                                  : _fc.favoriteList!.length.toString() +
                                      " " +
                                      'favorite'.tr.toLowerCase(),
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              )
                            : !_fc.isSearchFav && _fc.favoriteListAll!.isEmpty
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
                                          'empty'.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // 20.verticalSpace,
                                        // Text(
                                        //   empty,
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(
                                        //     fontSize: 18,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  )
                                : !_fc.isSearchFav &&
                                        _fc.favoriteListAll!.isNotEmpty &&
                                        _fc.favoriteList!.isEmpty
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
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing: 20,
                                                            mainAxisExtent:
                                                                280),
                                                    itemCount: _fc
                                                        .favoriteList!.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              () => EventDetailScreen(
                                                                  eventId: _fc
                                                                      .favoriteList![
                                                                          index]
                                                                      .eventId
                                                                      .toString()),
                                                              transition: Transition
                                                                  .rightToLeft);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
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
                                                                          .postEventImages!
                                                                          .isNotEmpty
                                                                      ? _fc
                                                                          .favoriteList![
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
                                                                  child:
                                                                      HighlightedText(
                                                                    searchQuery: _fc
                                                                        .searchController
                                                                        .text,
                                                                    text: _fc
                                                                        .favoriteList![
                                                                            index]
                                                                        .name
                                                                        .toString(),
                                                                    color: Theme.of(
                                                                            context)
                                                                        .indicatorColor,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    maxlines: 1,
                                                                  )),
                                                              8.verticalSpace,
                                                              FittedBox(
                                                                  child:
                                                                      HighlightedText(
                                                                searchQuery: _fc
                                                                    .searchController
                                                                    .text,
                                                                text: splitDateTimeWithoutYear(_fc
                                                                    .favoriteList![
                                                                        index]
                                                                    .eventDate
                                                                    .toString()),
                                                                color:
                                                                    kPrimaryColor,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              )),
                                                              8.verticalSpace,
                                                              _fc.favoriteList![index].reviewRating !=
                                                                          null &&
                                                                      (_fc
                                                                          .favoriteList![
                                                                              index]
                                                                          .reviewRating is num)
                                                                  ? SizedBox(
                                                                      width: 0.4
                                                                          .sw,
                                                                      child:
                                                                          RatingBar(
                                                                        ignoreGestures:
                                                                            true,
                                                                        itemSize:
                                                                            20,
                                                                        initialRating: _fc
                                                                            .favoriteList![index]
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
                                                                            Icons.star,
                                                                            color:
                                                                                kPrimaryColor,
                                                                          ),
                                                                          half:
                                                                              Icon(
                                                                            Icons.star_half,
                                                                            color:
                                                                                kPrimaryColor,
                                                                          ),
                                                                          empty:
                                                                              Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                kPrimaryColor,
                                                                          ),
                                                                        ),
                                                                        itemPadding:
                                                                            EdgeInsets.zero,
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
                                                                        width: 0.3
                                                                            .sw,
                                                                        child:
                                                                            HighlightedText(
                                                                          searchQuery: _fc
                                                                              .searchController
                                                                              .text,
                                                                          text: _fc
                                                                              .favoriteList![index]
                                                                              .city
                                                                              .toString(),
                                                                          color:
                                                                              Theme.of(context).indicatorColor,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          maxlines:
                                                                              1,
                                                                        )),
                                                                    5.horizontalSpace,
                                                                    GestureDetector(
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
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount: _fc
                                                        .favoriteList!.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              () => EventDetailScreen(
                                                                  eventId: _fc
                                                                      .favoriteList![
                                                                          index]
                                                                      .eventId
                                                                      .toString()),
                                                              transition: Transition
                                                                  .rightToLeft);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
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
                                                                            .postEventImages!
                                                                            .isNotEmpty
                                                                        ? _fc
                                                                            .favoriteList![index]
                                                                            .postEventImages![0]
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
                                                                        width: 0.5
                                                                            .sw,
                                                                        child:
                                                                            HighlightedText(
                                                                          searchQuery: _fc
                                                                              .searchController
                                                                              .text,
                                                                          text: _fc
                                                                              .favoriteList![index]
                                                                              .name
                                                                              .toString(),
                                                                          color:
                                                                              Theme.of(context).indicatorColor,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          maxlines:
                                                                              1,
                                                                        )),
                                                                    8.verticalSpace,
                                                                    FittedBox(
                                                                        child:
                                                                            HighlightedText(
                                                                      searchQuery: _fc
                                                                          .searchController
                                                                          .text,
                                                                      text: splitDateTimeWithoutYear(_fc
                                                                          .favoriteList![
                                                                              index]
                                                                          .eventDate
                                                                          .toString()),
                                                                      color:
                                                                          kPrimaryColor,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    )),
                                                                    8.verticalSpace,
                                                                    _fc.favoriteList![index].reviewRating !=
                                                                                null &&
                                                                            (_fc.favoriteList![index].reviewRating
                                                                                is num)
                                                                        ? SizedBox(
                                                                            width:
                                                                                0.4.sw,
                                                                            child:
                                                                                RatingBar(
                                                                              ignoreGestures: true,
                                                                              itemSize: 20,
                                                                              initialRating: _fc.favoriteList![index].reviewRating!.toDouble(),
                                                                              direction: Axis.horizontal,
                                                                              allowHalfRating: true,
                                                                              itemCount: 5,
                                                                              ratingWidget: RatingWidget(
                                                                                full: Icon(
                                                                                  Icons.star,
                                                                                  color: kPrimaryColor,
                                                                                ),
                                                                                half: Icon(
                                                                                  Icons.star_half,
                                                                                  color: kPrimaryColor,
                                                                                ),
                                                                                empty: Icon(
                                                                                  Icons.star_border,
                                                                                  color: kPrimaryColor,
                                                                                ),
                                                                              ),
                                                                              itemPadding: EdgeInsets.zero,
                                                                              onRatingUpdate: (rating) => null,
                                                                            ),
                                                                          )
                                                                        : SizedBox(),
                                                                    8.verticalSpace,
                                                                    FittedBox(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.location_on,
                                                                            color:
                                                                                kPrimaryColor,
                                                                            size:
                                                                                25,
                                                                          ),
                                                                          5.horizontalSpace,
                                                                          SizedBox(
                                                                              width: 0.3.sw,
                                                                              child: HighlightedText(
                                                                                searchQuery: _fc.searchController.text,
                                                                                text: _fc.favoriteList![index].city.toString(),
                                                                                color: Theme.of(context).indicatorColor,
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.w400,
                                                                                maxlines: 1,
                                                                              )),
                                                                          5.horizontalSpace,
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              removeFavoriteBottomSheet(context, index);
                                                                            },
                                                                            child:
                                                                                Image.asset(
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
                        'removeFromFavorites'.tr,
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
                                          .postEventImages!.isNotEmpty
                                      ? _favoriteController.favoriteList![index]
                                          .postEventImages![0]
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
                                        GestureDetector(
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
                          GestureDetector(
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
                                child: Text('cancel'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                            ),
                          ),
                          20.horizontalSpace,
                          GestureDetector(
                            onTap: () async {
                              String data =
                                  "?eventID=${_favoriteController.favoriteList![index].eventId!.toInt()}&fav=false&customerID=$userId";

                              var res = await ApiService()
                                  .removeFavorite(context, data);
                              if (res != null && res is String) {
                                Get.back();
                                Get.back();
                                if (!res.contains('somethingWentWrong'.tr)) {
                                  _favoriteController.favoriteList!
                                      .removeAt(index);
                                  _favoriteController.update();
                                  customSnackBar("Success!", res);
                                } else {
                                  customSnackBar(
                                      'error'.tr, 'somethingWentWrong');
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
                                child: Text('yesRemove'.tr,
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
