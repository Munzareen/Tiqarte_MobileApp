import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/ticketController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/model/TicketModel.dart';
import 'package:tiqarte/view/CancelBookingScreen.dart';
import 'package:tiqarte/view/ViewETicketScreen.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final _key = GlobalKey<ScaffoldState>();

  final _ticketController = Get.put(TicketController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    getData();
  }

  getData() async {
    var res = await ApiService().getCustomerTicketList();
    if (res != null && res is List) {
      _ticketController.addTicketData(ticketModelFromJson(res));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _key,
        // backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          // backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GetBuilder<TicketController>(builder: (_tc) {
              return _tc.upcomingTicketList == null
                  ? Center(
                      child: spinkit,
                    )
                  : Column(
                      children: [
                        20.verticalSpace,
                        _tc.isSearch
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
                                      focusNode: _tc.searchFocusNode,
                                      cursorColor: kPrimaryColor,
                                      controller: _tc.searchController,
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
                                            color: _tc.iconColorSearch,
                                          ),
                                          errorBorder: customOutlineBorder,
                                          enabledBorder: customOutlineBorder,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0)),
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor)),
                                          disabledBorder: customOutlineBorder,
                                          // fillColor: filledColorSearch,
                                          filled: true,
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                              color: Color(0xff9E9E9E),
                                              fontSize: 14)),
                                      onChanged: _tc.onSearch,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            textRegExp),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _tc.onSearchClose(_tc.searchController);
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
                                        ticketHeadingString,
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
                                            _tc.onSearchTap();
                                          },
                                          icon: Icon(Icons.search)),
                                      10.horizontalSpace,
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: Icon(
                                          Icons.more_horiz_sharp,
                                          size: 25,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                        20.verticalSpace,
                        TabBar(
                          labelStyle: TextStyle(color: kPrimaryColor),
                          unselectedLabelStyle:
                              TextStyle(color: kDisabledColor),
                          labelColor: kPrimaryColor,
                          //  dividerColor: kDisabledColor,
                          unselectedLabelColor: Color(0xff9E9E9E),
                          isScrollable: false,
                          labelPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          controller: tabController,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          // indicator: BoxDecoration(
                          //     color: Color(0xff3E5164),
                          //     borderRadius: BorderRadius.circular(8)),
                          indicatorColor: kPrimaryColor,
                          indicatorWeight: 3.0,
                          tabs: [
                            Text(ticketUpcomingString,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text(ticketCompletedString,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text(ticketCancelledString,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        20.verticalSpace,
                        Expanded(
                            child: TabBarView(
                          controller: tabController,
                          children: [
                            //Upcoming
                            _tc.isSearch && _tc.upcomingTicketList!.isEmpty
                                ? ListView(
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
                                  )
                                : !_tc.isSearch &&
                                        _tc.upcomingTicketListAll.isEmpty
                                    ? ListView(
                                        children: [
                                          30.verticalSpace,
                                          Image.asset(
                                            ticketEmptyImage,
                                            height: 250,
                                          ),
                                          20.verticalSpace,
                                          Text(
                                            ticketEmptyTicketsString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          20.verticalSpace,
                                          Text(
                                            ticketEmptyTicketSubString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          30.verticalSpace,
                                          Text(
                                            ticketFindEventsString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : !_tc.isSearch &&
                                            _tc.upcomingTicketListAll
                                                .isNotEmpty &&
                                            _tc.upcomingTicketList!.isEmpty
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
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                _tc.upcomingTicketList?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        // mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          customCardImage(
                                                              _tc
                                                                  .upcomingTicketList![
                                                                      index]
                                                                  .imageURL
                                                                  .toString(),
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
                                                                  _tc
                                                                      .upcomingTicketList![
                                                                          index]
                                                                      .eventName
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
                                                                  splitDateTimeWithoutYear(_tc
                                                                      .upcomingTicketList![
                                                                          index]
                                                                      .eventDate
                                                                      .toString()),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
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
                                                                      width: 0.3
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        _tc.upcomingTicketList![index]
                                                                            .city
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
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
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5.0,
                                                                          vertical:
                                                                              5.0),
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color:
                                                                                kPrimaryColor,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(8.0)),
                                                                      child:
                                                                          Text(
                                                                        ticketPaidString,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: kPrimaryColor),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      5.verticalSpace,
                                                      Divider(),
                                                      10.verticalSpace,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cancelBookingBottomSheet(
                                                                  context,
                                                                  _tc
                                                                      .upcomingTicketList![
                                                                          index]
                                                                      .ticketUniqueNumber!
                                                                      .toInt()
                                                                      .toString());
                                                            },
                                                            child: Container(
                                                              width: 0.4.sw,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          0.0,
                                                                      vertical:
                                                                          10.0),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              child: Text(
                                                                ticketCancelBookingHeadingString,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kPrimaryColor),
                                                              ),
                                                            ),
                                                          ),
                                                          10.horizontalSpace,
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.to(
                                                                  () => ViewETicketScreen(
                                                                      ticketUniqueNumber: _tc
                                                                          .upcomingTicketList![
                                                                              index]
                                                                          .ticketUniqueNumber!
                                                                          .toInt()
                                                                          .toString()),
                                                                  transition:
                                                                      Transition
                                                                          .rightToLeft);
                                                            },
                                                            child: Container(
                                                              width: 0.4.sw,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          0.0,
                                                                      vertical:
                                                                          10.0),
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              child: Text(
                                                                viewETicket,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),

                            //Completed
                            _tc.isSearch && _tc.completedTicketList.isEmpty
                                ? ListView(
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
                                  )
                                : !_tc.isSearch &&
                                        _tc.completedTicketListAll.isEmpty
                                    ? ListView(
                                        children: [
                                          30.verticalSpace,
                                          Image.asset(
                                            ticketEmptyImage,
                                            height: 250,
                                          ),
                                          20.verticalSpace,
                                          Text(
                                            ticketEmptyTicketsString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          20.verticalSpace,
                                          Text(
                                            ticketEmptyTicketSubString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          30.verticalSpace,
                                          Text(
                                            ticketFindEventsString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : !_tc.isSearch &&
                                            _tc.completedTicketListAll
                                                .isNotEmpty &&
                                            _tc.completedTicketList.isEmpty
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
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                _tc.completedTicketList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        // mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          customCardImage(
                                                              _tc
                                                                  .completedTicketList[
                                                                      index]
                                                                  .imageURL
                                                                  .toString(),
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
                                                                  _tc
                                                                      .completedTicketList[
                                                                          index]
                                                                      .eventName
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
                                                                  splitDateTimeWithoutYear(_tc
                                                                      .completedTicketList[
                                                                          index]
                                                                      .eventDate
                                                                      .toString()),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
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
                                                                      width: 0.25
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        _tc.completedTicketList[index]
                                                                            .city
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
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
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5.0,
                                                                          vertical:
                                                                              5.0),
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color:
                                                                                Color(0xff07BD74),
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(8.0)),
                                                                      child:
                                                                          Text(
                                                                        ticketCompletedString,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Color(0xff07BD74)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      5.verticalSpace,
                                                      Divider(),
                                                      10.verticalSpace,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              reviewSheet(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              width: 0.4.sw,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          0.0,
                                                                      vertical:
                                                                          10.0),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              child: Text(
                                                                leaveAReview,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kPrimaryColor),
                                                              ),
                                                            ),
                                                          ),
                                                          10.horizontalSpace,
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.to(
                                                                  () => ViewETicketScreen(
                                                                      ticketUniqueNumber: _tc
                                                                          .completedTicketList[
                                                                              index]
                                                                          .ticketUniqueNumber!
                                                                          .toInt()
                                                                          .toString()),
                                                                  transition:
                                                                      Transition
                                                                          .rightToLeft);
                                                            },
                                                            child: Container(
                                                              width: 0.4.sw,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          0.0,
                                                                      vertical:
                                                                          10.0),
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              child: Text(
                                                                viewETicket,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),

                            //Cancelled
                            _tc.isSearch && _tc.cancelledTicketList.isEmpty
                                ? ListView(
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
                                  )
                                : !_tc.isSearch &&
                                        _tc.cancelledTicketListAll.isEmpty
                                    ? ListView(
                                        children: [
                                          30.verticalSpace,
                                          Image.asset(
                                            ticketEmptyImage,
                                            height: 250,
                                          ),
                                          20.verticalSpace,
                                          Text(
                                            ticketEmptyTicketsString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          20.verticalSpace,
                                          Text(
                                            ticketEmptyTicketSubString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          30.verticalSpace,
                                          Text(
                                            ticketFindEventsString,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : !_tc.isSearch &&
                                            _tc.cancelledTicketListAll
                                                .isNotEmpty &&
                                            _tc.cancelledTicketList.isEmpty
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
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                _tc.cancelledTicketList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        // mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          customCardImage(
                                                              _tc
                                                                  .cancelledTicketList[
                                                                      index]
                                                                  .imageURL
                                                                  .toString(),
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
                                                                  _tc
                                                                      .cancelledTicketList[
                                                                          index]
                                                                      .eventName
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
                                                                  splitDateTimeWithoutYear(_tc
                                                                      .cancelledTicketList[
                                                                          index]
                                                                      .eventDate
                                                                      .toString()),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
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
                                                                      width: 0.25
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        _tc.cancelledTicketList[index]
                                                                            .city
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
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
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5.0,
                                                                          vertical:
                                                                              5.0),
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color:
                                                                                Color(0xffF75555),
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(8.0)),
                                                                      child:
                                                                          Text(
                                                                        ticketCancelledString,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Color(0xffF75555)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                          ],
                        ))
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }

  cancelBookingBottomSheet(BuildContext context, String ticketUniqueNumber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
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
                    ticketCancelBookingHeadingString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  10.verticalSpace,
                  Text(
                    ticketCancelBookingSubString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    ticketCancelBookingRefundString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
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
                          // width: 0.3.sw,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(ticketNoDontCancelButtonString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      20.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.to(
                              () => CancelBookingScreen(
                                  ticketUniqueNumber: ticketUniqueNumber),
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          height: 50,
                          //width: 0.3.sw,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),

                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(ticketYesCancelButtonString,
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
  }

  reviewSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
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
                    leaveAReview,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  10.verticalSpace,
                  Text(
                    leaveAReviewSub,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  20.verticalSpace,
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: kPrimaryColor,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  10.verticalSpace,
                  Divider(),
                  10.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      writeYourReview,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    height: 120,
                    child: TextFormField(
                      // focusNode: _otherReasonFocusNode,
                      cursorColor: kPrimaryColor,
                      //  controller: _otherReasonController,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter your username';
                      //   }
                      //   return null;
                      // },
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 90.0, horizontal: 10.0),
                          errorBorder: customOutlineBorder,
                          enabledBorder: customOutlineBorder,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: kPrimaryColor)),
                          disabledBorder: customOutlineBorder,
                          //  fillColor: kDisabledColor.withOpacity(0.4),
                          filled: true,
                          hintText: ticketCancelBookingReasonOthersSubString,
                          hintStyle: TextStyle(
                              color: Color(0xff9E9E9E), fontSize: 14)),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(textRegExp),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  Divider(),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 55,
                          width: 0.4.sw,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(maybeLater,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      20.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 55,
                          width: 0.4.sw,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(submit,
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
  }
}
