import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/controller/bookEventController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/view/BookEventContactInfoScreen.dart';

class BookEventScreen extends StatefulWidget {
  const BookEventScreen({super.key});

  @override
  State<BookEventScreen> createState() => _BookEventScreenState();
}

class _BookEventScreenState extends State<BookEventScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  BookEventController _bookEventController = Get.find();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _bookEventController.economySeatCount = 0;
    _bookEventController.vipSeatCount = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        //  backgroundColor: kSecondBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: GetBuilder<BookEventController>(builder: (_bec) {
            return Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back)),
                    10.horizontalSpace,
                    Text(
                      'bookEvent'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                TabBar(
                  onTap: (value) {
                    //  setState(() {});
                  },
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
                      child: Text('economy'.tr,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    FittedBox(
                      child: Text('vip'.tr,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                20.verticalSpace,
                Expanded(
                    child: TabBarView(controller: tabController, children: [
                  //economy
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'chooseNumberOfSeats'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            minWidth: 50.h,
                            height: 50.h,
                            elevation: 0,
                            splashColor: kPrimaryColor,
                            highlightColor: kPrimaryColor,
                            onPressed: () {
                              _bec.subtractEconomy();
                            },
                            // color: Colors.transparent,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color: Colors.grey)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              _bec.economySeatCount.toString(),
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          MaterialButton(
                            minWidth: 50.h,
                            height: 50.h,
                            elevation: 0,
                            splashColor: kPrimaryColor,
                            highlightColor: kPrimaryColor,
                            onPressed: () {
                              _bec.addEconomy();
                            },
                            // color: Colors.transparent,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //VIP
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'chooseNumberOfSeats'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            minWidth: 50.h,
                            height: 50.h,
                            elevation: 0,
                            splashColor: kPrimaryColor,
                            highlightColor: kPrimaryColor,
                            onPressed: () {
                              _bec.subtractVip();
                            },
                            // color: Colors.transparent,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color: Colors.grey)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              _bec.vipSeatCount.toString(),
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          MaterialButton(
                            minWidth: 50.h,
                            height: 50.h,
                            elevation: 0,
                            splashColor: kPrimaryColor,
                            highlightColor: kPrimaryColor,
                            onPressed: () {
                              _bec.addVip();
                            },
                            // color: Colors.transparent,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ],
                  )
                ])),
                Container(
                  width: 1.sw,
                  color: Theme.of(context).secondaryHeaderColor,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: GestureDetector(
                          onTap: () {
                            if (_bookEventController.economyPrice! +
                                    _bookEventController.vipPrice! >
                                0) {
                              Get.to(() => BookEventContactInfoScreen(),
                                  transition: Transition.rightToLeft);
                            } else {
                              customSnackBar('alert'.tr, 'Please add seats');
                            }
                          },
                          child: customButton(
                              'continueButton'.tr +
                                  " - ${_bookEventController.economyPrice! + _bookEventController.vipPrice!} \$",
                              kPrimaryColor))),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
