import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/organizerDetailController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';
import 'package:tiqarte/view/ImagePreviewDialog.dart';

class OrganizerDetailScreen extends StatefulWidget {
  final String orgnizerId;
  const OrganizerDetailScreen({super.key, required this.orgnizerId});

  @override
  State<OrganizerDetailScreen> createState() => _OrganizerDetailScreenState();
}

class _OrganizerDetailScreenState extends State<OrganizerDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final _organizerDetailController = Get.put(OrganizerDetailController());

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getOrganizerDetail(widget.orgnizerId);
    if (res != null && res is Map) {
      _organizerDetailController.addOrganizerDetail(res);
    } else if (res != null && res is String) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  @override
  void dispose() {
    tabController?.dispose();
    _organizerDetailController.organizerDetailModel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accessToken;
    return Scaffold(
      //  backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        //toolbarHeight: 0,
        //  backgroundColor: kSecondBackgroundColor,
        title: Text(
          'organizer'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
            )),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Container(
        //       height: 30,
        //       width: 30,
        //       decoration: BoxDecoration(
        //         border: Border.all(
        //             width: 1, color: Theme.of(context).colorScheme.background),
        //         borderRadius: BorderRadius.circular(50.0),
        //       ),
        //       child: Icon(
        //         Icons.more_horiz_sharp,
        //         size: 25,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GetBuilder<OrganizerDetailController>(builder: (_oc) {
              return _oc.organizerDetailModel?.events == null
                  ? Center(
                      child: spinkit,
                    )
                  : Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        20.verticalSpace,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         IconButton(
                        //             onPressed: () => Get.back(),
                        //             icon: Icon(Icons.arrow_back)),
                        //         10.horizontalSpace,
                        //         Text(
                        //           organizer,
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //               fontSize: 24,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black),
                        //         ),
                        //       ],
                        //     ),
                        //     Container(
                        //       height: 30,
                        //       width: 30,
                        //       decoration: BoxDecoration(
                        //         border: Border.all(color: Colors.black, width: 1),
                        //         borderRadius: BorderRadius.circular(50.0),
                        //       ),
                        //       child: Icon(
                        //         Icons.more_horiz_sharp,
                        //         color: Colors.black,
                        //         size: 25,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // 30.verticalSpace,
                        customProfileImage(organizerImage, 90.h, 90.h),
                        20.verticalSpace,
                        Text(
                          _oc.organizerDetailModel!.organizer!.name.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        20.verticalSpace,
                        Divider(
                          color: kDisabledColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50.h,
                                width: 0.5.w,
                                color: kDisabledColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      _oc.organizerDetailModel!.events!.length
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      _oc.organizerDetailModel!.events!.length >
                                              1
                                          ? 'events'.tr
                                          : 'event'.tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff616161)),
                                    ),
                                  ],
                                ),
                              ),

                              // Column(
                              //   children: [
                              //     Text(
                              //       "7,389",
                              //       textAlign: TextAlign.start,
                              //       style: TextStyle(
                              //           fontSize: 32,
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.black),
                              //     ),
                              //     5.verticalSpace,
                              //     Text(
                              //       followers,
                              //       textAlign: TextAlign.start,
                              //       style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.bold,
                              //           color: Color(0xff616161)),
                              //     ),
                              //   ],
                              // ),
                              Container(
                                height: 50.h,
                                width: 0.5.w,
                                color: kDisabledColor,
                              ),
                              // Column(
                              //   children: [
                              //     Text(
                              //       "125",
                              //       textAlign: TextAlign.start,
                              //       style: TextStyle(
                              //           fontSize: 32,
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.black),
                              //     ),
                              //     5.verticalSpace,
                              //     Text(
                              //       following,
                              //       textAlign: TextAlign.start,
                              //       style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.bold,
                              //           color: Color(0xff616161)),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        Divider(
                          color: kDisabledColor,
                        ),
                        20.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  String data = '';
                                  if (_oc.organizerDetailModel?.isFollow ==
                                      true) {
                                    data =
                                        "?organizerID=${_oc.organizerDetailModel?.organizer?.id?.toInt()}&customerID=$userId&follow=false";
                                  } else {
                                    data =
                                        "?organizerID=${_oc.organizerDetailModel?.organizer?.id?.toInt()}&customerID=$userId&follow=true";
                                  }

                                  var res = await ApiService()
                                      .setOrganizerFollow(data);
                                  if (res != null && res is String) {
                                    if (res.toUpperCase().contains("ADDED")) {
                                      _oc.organizerDetailModel?.isFollow = true;
                                      _oc.update();
                                      customSnackBar('alert'.tr,
                                          "You are now following ${_oc.organizerDetailModel!.organizer?.name.toString()}");
                                    } else if (res
                                        .toUpperCase()
                                        .contains("REMOVE")) {
                                      _oc.organizerDetailModel?.isFollow =
                                          false;
                                      _oc.update();
                                      customSnackBar('alert'.tr,
                                          "You unfollowed ${_oc.organizerDetailModel!.organizer?.name.toString()}");
                                    }
                                  }
                                },
                                child: Container(
                                  width: 0.4.sw,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        followIcon,
                                        color: Colors.white,
                                        height: 20.h,
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        _oc.organizerDetailModel?.isFollow ==
                                                true
                                            ? 'following'.tr
                                            : 'follow'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: 0.4.sw,
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: 15.0, vertical: 10.0),
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20.0),
                              //       border: Border.all(
                              //           width: 2.0, color: kPrimaryColor)),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Image.asset(
                              //         chatIcon,
                              //         color: kPrimaryColor,
                              //         height: 20.h,
                              //       ),
                              //       10.horizontalSpace,
                              //       Text(
                              //         'message'.tr,
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //             fontSize: 18,
                              //             fontWeight: FontWeight.bold,
                              //             color: kPrimaryColor),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
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
                              width: 3.0,
                            ),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          // indicator: BoxDecoration(
                          //     color: Color(0xff3E5164),
                          //     borderRadius: BorderRadius.circular(8)),
                          indicatorColor: kPrimaryColor,
                          indicatorWeight: 3.0,
                          tabs: [
                            FittedBox(
                              child: Text('events'.tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            FittedBox(
                              child: Text('collections'.tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            FittedBox(
                              child: Text('about'.tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        Expanded(
                            child: TabBarView(
                                controller: tabController,
                                children: [
                              //Events
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    _oc.organizerDetailModel!.events?.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => EventDetailScreen(
                                              eventId: _oc.organizerDetailModel!
                                                  .events![index].eventId
                                                  .toString()),
                                          transition: Transition.rightToLeft);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
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
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                customCardImage(
                                                    _oc
                                                            .organizerDetailModel!
                                                            .events![index]
                                                            .postEventImages!
                                                            .isNotEmpty
                                                        ? _oc
                                                            .organizerDetailModel!
                                                            .events![index]
                                                            .postEventImages![0]
                                                            .toString()
                                                        : "null",
                                                    110.h,
                                                    100.h),
                                                // eventList[index]['isFree']
                                                //     ? Positioned(
                                                //         right: 10,
                                                //         top: 10,
                                                //         child: Container(
                                                //           // width: 0.2.sh,
                                                //           padding: EdgeInsets.symmetric(
                                                //               horizontal: 15.0,
                                                //               vertical: 8.0),
                                                //           decoration: BoxDecoration(
                                                //               color: kPrimaryColor,
                                                //               borderRadius:
                                                //                   BorderRadius.circular(8.0)),
                                                //           child: Text(
                                                //             free,
                                                //             textAlign: TextAlign.center,
                                                //             style: TextStyle(
                                                //                 fontSize: 10,
                                                //                 fontWeight: FontWeight.w500,
                                                //                 color: Colors.white),
                                                //           ),
                                                //         ),
                                                //       )
                                                //     : SizedBox()
                                              ],
                                            ),
                                            8.horizontalSpace,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 0.5.sw,
                                                  child: Text(
                                                    _oc.organizerDetailModel!
                                                        .events![index].name
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    splitDateTimeWithoutYear(_oc
                                                        .organizerDetailModel!
                                                        .events![index]
                                                        .eventDate
                                                        .toString()),
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
                                                          _oc
                                                              .organizerDetailModel!
                                                              .events![index]
                                                              .city
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      5.horizontalSpace,
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Image.asset(
                                                          _oc
                                                                      .organizerDetailModel!
                                                                      .events![
                                                                          index]
                                                                      .isFav ==
                                                                  true
                                                              ? favoriteIconSelected
                                                              : favoriteIcon,
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
                              ),

                              //Collections
                              _oc.organizerDetailModel!.collections!.isEmpty
                                  ? Column(
                                      children: [
                                        30.verticalSpace,
                                        Image.asset(
                                          noNotificationImage,
                                          height: 150,
                                        ),
                                      ],
                                    )
                                  : GridView.builder(
                                      //  physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 20,
                                      ),
                                      itemCount: _oc.organizerDetailModel!
                                          .collections?.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  ImagePreviewDialog(
                                                      imagePath: _oc
                                                          .organizerDetailModel!
                                                          .collections![index]
                                                          .imageUrl
                                                          .toString()),
                                            );
                                          },
                                          child: customCardImage(
                                              _oc.organizerDetailModel!
                                                  .collections![index].imageUrl
                                                  .toString(),
                                              110.h,
                                              110.h),
                                        );
                                      },
                                    ),

                              //About
                              ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                      child: Text(
                                          _oc.organizerDetailModel!.organizer!
                                                      .about !=
                                                  null
                                              ? _oc.organizerDetailModel!
                                                  .organizer!.about
                                                  .toString()
                                              : '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ]))
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
