import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/seeAllEventController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getEventsByType(widget.eventTypeId);
    if (res != null && res is List) {
      _seeAllEventController.addSeeAllData(res);
    } else if (res != null && res is String) {
      customSnackBar(error, somethingWentWrong);
    }
  }

  @override
  void dispose() {
    _seeAllEventController.searchController.clear();
    _seeAllEventController.isSearch = false;

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
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor)),
                                          disabledBorder: customOutlineBorder,
                                          //  fillColor: filledColorSearch,
                                          filled: true,
                                          hintText: "Search",
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
                                      notFound,
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
                                                    mainAxisExtent: 245),
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
                                                                      alert,
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
                                                                            alert,
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
}
