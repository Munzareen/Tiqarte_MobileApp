import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/CancelBookingScreen.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
    with SingleTickerProviderStateMixin {
  bool isSearch = false;

  TabController? tabController;

  final _searchController = TextEditingController();
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final _searchFocusNode = FocusNode();

  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
        key: _key,
        backgroundColor: kSecondBackgroundColor,
        body: SafeArea(
            child: Container(
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
                                      color: Color(0xff9E9E9E), fontSize: 14)),
                              onChanged: searchTicket,
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
                                  ticketList = allTicketList;
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
                              Image.asset(
                                appLogo,
                                height: 20,
                              ),
                              20.horizontalSpace,
                              Text(
                                ticketHeadingString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSearch = true;
                                    });
                                  },
                                  icon: Icon(Icons.search)),
                              10.horizontalSpace,
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Icon(
                                  Icons.more_horiz_sharp,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                20.verticalSpace,
                TabBar(
                  labelStyle: TextStyle(color: kPrimaryColor),
                  unselectedLabelStyle: TextStyle(color: kDisabledColor),
                  labelColor: kPrimaryColor,
                  //  dividerColor: kDisabledColor,
                  unselectedLabelColor: Color(0xff9E9E9E),
                  isScrollable: false,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
                    isSearch && ticketList.isEmpty
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
                        : !isSearch && ticketList.isEmpty
                            ? Expanded(
                                child: ListView(
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
                                          color: Colors.black),
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      ticketEmptyTicketSubString,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
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
                                ),
                              )
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: ticketList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              customCardImage(
                                                  eventImage, 110.h, 100.h),
                                              8.horizontalSpace,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FittedBox(
                                                    child: Text(
                                                      ticketList[index]['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  8.verticalSpace,
                                                  FittedBox(
                                                    child: Text(
                                                      ticketList[index]['date'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                        Text(
                                                          ticketList[index]
                                                              ['location'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff616161)),
                                                        ),
                                                        5.horizontalSpace,
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.0,
                                                                  vertical:
                                                                      5.0),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color:
                                                                        kPrimaryColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0)),
                                                          child: Text(
                                                            ticketPaidString,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    kPrimaryColor),
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
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  cancelBookingBottomSheet(
                                                      context);
                                                },
                                                child: Container(
                                                  width: 0.2.sh,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 10.0),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: kPrimaryColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  child: Text(
                                                    ticketCancelBookingHeadingString,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kPrimaryColor),
                                                  ),
                                                ),
                                              ),
                                              10.horizontalSpace,
                                              Container(
                                                width: 0.2.sh,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.0,
                                                    vertical: 10.0),
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: Text(
                                                  ticketViewTicketButtonString,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
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
                    isSearch && ticketList.isEmpty
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
                        : !isSearch && ticketList.isEmpty
                            ? Expanded(
                                child: ListView(
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
                                          color: Colors.black),
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      ticketEmptyTicketSubString,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
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
                                ),
                              )
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: ticketList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              customCardImage(
                                                  eventImage, 110.h, 100.h),
                                              8.horizontalSpace,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FittedBox(
                                                    child: Text(
                                                      ticketList[index]['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  8.verticalSpace,
                                                  FittedBox(
                                                    child: Text(
                                                      ticketList[index]['date'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                        Text(
                                                          ticketList[index]
                                                              ['location'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff616161)),
                                                        ),
                                                        5.horizontalSpace,
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.0,
                                                                  vertical:
                                                                      5.0),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xff07BD74),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0)),
                                                          child: Text(
                                                            ticketCompletedString,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff07BD74)),
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
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 0.2.sh,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.0,
                                                    vertical: 10.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kPrimaryColor,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: Text(
                                                  ticketReviewButtonString,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kPrimaryColor),
                                                ),
                                              ),
                                              10.horizontalSpace,
                                              Container(
                                                width: 0.2.sh,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.0,
                                                    vertical: 10.0),
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: Text(
                                                  ticketViewTicketButtonString,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
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
                    isSearch && ticketList.isEmpty
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
                        : !isSearch && ticketList.isEmpty
                            ? Expanded(
                                child: ListView(
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
                                          color: Colors.black),
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      ticketEmptyTicketSubString,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
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
                                ),
                              )
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: ticketList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: Colors.white),
                                      child: Row(
                                        // mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          customCardImage(
                                              eventImage, 110.h, 100.h),
                                          8.horizontalSpace,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  ticketList[index]['name'],
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              8.verticalSpace,
                                              FittedBox(
                                                child: Text(
                                                  ticketList[index]['date'],
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                    Text(
                                                      ticketList[index]
                                                          ['location'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                              0xff616161)),
                                                    ),
                                                    5.horizontalSpace,
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0,
                                                              vertical: 5.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Color(
                                                                0xffF75555),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0)),
                                                      child: Text(
                                                        ticketCancelledString,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xffF75555)),
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
                                  );
                                },
                              ),
                  ],
                ))
              ],
            ),
          ),
        )),
      ),
    );
  }

  cancelBookingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                        color: Colors.black),
                  ),
                  Divider(),
                  10.verticalSpace,
                  Text(
                    ticketCancelBookingSubString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  20.verticalSpace,
                  Text(
                    ticketCancelBookingRefundString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
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
                      InkWell(
                        onTap: () {
                          Get.back();
                          Get.to(() => CancelBookingScreen(),
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

  searchTicket(String query) {
    ticketList = allTicketList;
    final suggestion = ticketList.where((element) {
      final eventName = element['name']!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    setState(() {
      ticketList = suggestion;
    });
  }

  List ticketList = [
    {
      "id": "1",
      "name": "International Concert",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "status": "upcoming",
    },
    {
      "id": "2",
      "name": "Jazz Music Festival",
      "date": "Tue, Dec 19 • 19.00 - 22.00...",
      "location": "New Avenue, Wa...",
      "status": "cancelled",
    },
    {
      "id": "3",
      "name": "DJ Music Competition",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "Central Park, Ne...",
      "status": "upcoming",
    },
    {
      "id": "4",
      "name": "National Music Fest",
      "date": "Sun, Dec 16 • 11.00 - 13.00...",
      "location": "New Avenue, Wa...",
      "status": "completed",
    },
    {
      "id": "5",
      "name": "Art Workshops",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "status": "completed",
    },
    {
      "id": "6",
      "name": "Tech Seminar",
      "date": "Sat, Dec 22 • 10.00 - 12.00...",
      "location": "New Avenue, Wa...",
      "status": "completed",
    },
    {
      "id": "7",
      "name": "Mural Painting",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "status": "cancelled",
    },
    {
      "id": "8",
      "name": "Tech Seminar",
      "date": "Sat, Dec 22 • 10.00 - 12.00...",
      "location": "New Avenue, Wa...",
      "status": "upcoming",
    },
    {
      "id": "9",
      "name": "Mural Painting",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "status": "completed",
    },
  ];

  List allTicketList = [
    {
      "id": "1",
      "name": "International Concert",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "status": "upcoming",
    },
    {
      "id": "2",
      "name": "Jazz Music Festival",
      "date": "Tue, Dec 19 • 19.00 - 22.00...",
      "location": "New Avenue, Wa...",
      "status": "cancelled",
    },
    {
      "id": "3",
      "name": "DJ Music Competition",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "Central Park, Ne...",
      "status": "upcoming",
    },
    {
      "id": "4",
      "name": "National Music Fest",
      "date": "Sun, Dec 16 • 11.00 - 13.00...",
      "location": "New Avenue, Wa...",
      "status": "completed",
    },
    {
      "id": "5",
      "name": "Art Workshops",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "status": "completed",
    },
    {
      "id": "6",
      "name": "Tech Seminar",
      "date": "Sat, Dec 22 • 10.00 - 12.00...",
      "location": "New Avenue, Wa...",
      "status": "completed",
    },
    {
      "id": "7",
      "name": "Mural Painting",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "status": "cancelled",
    },
    {
      "id": "8",
      "name": "Tech Seminar",
      "date": "Sat, Dec 22 • 10.00 - 12.00...",
      "location": "New Avenue, Wa...",
      "status": "upcoming",
    },
    {
      "id": "9",
      "name": "Mural Painting",
      "date": "Fri, Dec 20 • 13.00 - 15.00...",
      "location": "New Avenue, Wa...",
      "status": "completed",
    },
  ];
}
