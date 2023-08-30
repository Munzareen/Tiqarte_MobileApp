import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/merchandiseOrderHistoryController.dart';
import 'package:tiqarte/helper/images.dart';

class MerchandiseOrderHistoryScreen extends StatefulWidget {
  const MerchandiseOrderHistoryScreen({
    super.key,
  });

  @override
  State<MerchandiseOrderHistoryScreen> createState() =>
      _MerchandiseOrderHistoryScreenState();
}

class _MerchandiseOrderHistoryScreenState
    extends State<MerchandiseOrderHistoryScreen> {
  final _merchandiseOrderHistoryController =
      Get.put(MerchandiseOrderHistoryController());

  @override
  void initState() {
    super.initState();
  }

  getData() async {
    var res = await ApiService().getAllProductListByUser();

    if (res != null && res is List) {
      _merchandiseOrderHistoryController.addData(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: kSecondBackgroundColor,
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back)),
                    10.horizontalSpace,
                    SizedBox(
                      width: 0.7.sw,
                      child: Text(
                        'merchandiseOrderHistory'.tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                Expanded(
                  child: GetBuilder<MerchandiseOrderHistoryController>(
                      builder: (_mhc) {
                    return _mhc.merchandiseOrderHistoryList.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _mhc.merchandiseOrderHistoryList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return SizedBox();
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.to(() => NewsDetailScreen(
                              //           newsModel: widget.newsList[index],
                              //         ));
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(vertical: 10.0),
                              //     child: Container(
                              //       padding: EdgeInsets.all(16.0),
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(30.0),
                              //           color: Theme.of(context).secondaryHeaderColor),
                              //       child: Row(
                              //         // mainAxisSize: MainAxisSize.min,
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         mainAxisAlignment: MainAxisAlignment.start,
                              //         children: [
                              //           customCardImage(
                              //               widget.newsList[index].imageUrl == null ||
                              //                       widget.newsList[index].imageUrl!
                              //                           .trim()
                              //                           .isEmpty
                              //                   ? "null"
                              //                   : widget.newsList[index].imageUrl
                              //                       .toString(),
                              //               100.h,
                              //               100.h),
                              //           8.horizontalSpace,
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               SizedBox(
                              //                 width: 0.5.sw,
                              //                 child: Text(
                              //                   widget.newsList[index].title.toString(),
                              //                   textAlign: TextAlign.start,
                              //                   maxLines: 2,
                              //                   overflow: TextOverflow.ellipsis,
                              //                   style: TextStyle(
                              //                     fontSize: 18,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 ),
                              //               ),
                              //               8.verticalSpace,
                              //               FittedBox(
                              //                 child: Text(
                              //                   splitDateForNews(widget
                              //                       .newsList[index].scheduled
                              //                       .toString()),
                              //                   textAlign: TextAlign.start,
                              //                   style: TextStyle(
                              //                       fontSize: 12,
                              //                       fontWeight: FontWeight.w400,
                              //                       color: Colors.grey),
                              //                 ),
                              //               ),
                              //               8.verticalSpace,
                              //               Row(
                              //                 children: [
                              //                   Text(
                              //                     'learnMore'.tr,
                              //                     textAlign: TextAlign.start,
                              //                     style: TextStyle(
                              //                         fontSize: 16,
                              //                         fontWeight: FontWeight.w500,
                              //                         color: kPrimaryColor),
                              //                   ),
                              //                   10.horizontalSpace,
                              //                   Icon(
                              //                     Icons.arrow_outward,
                              //                     size: 16,
                              //                     color: kPrimaryColor,
                              //                   )
                              //                 ],
                              //               )
                              //             ],
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // );
                            },
                          );
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
