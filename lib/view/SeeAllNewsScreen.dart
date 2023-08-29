import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/seeAllEventController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/model/NewsModel.dart';
import 'package:tiqarte/view/EventDetailScreen.dart';

class SeeAllNewsScreen extends StatefulWidget {
  final List<NewsModel> newsList;

  const SeeAllNewsScreen({
    super.key,
    required this.newsList,
  });

  @override
  State<SeeAllNewsScreen> createState() => _SeeAllNewsScreenState();
}

class _SeeAllNewsScreenState extends State<SeeAllNewsScreen> {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back)),
                    10.horizontalSpace,
                    Text(
                      'allNews'.tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.newsList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        // onTap: () {
                        //   Get.to(
                        //       () => EventDetailScreen(
                        //           eventId: _sc
                        //               .seeAllEventModel![
                        //                   index]
                        //               .eventId
                        //               .toString()),
                        //       transition: Transition
                        //           .rightToLeft);
                        // },
                        child: Padding(
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
                                    widget.newsList[index].imageUrl == null ||
                                            widget.newsList[index].imageUrl!
                                                .trim()
                                                .isEmpty
                                        ? "null"
                                        : widget.newsList[index].imageUrl
                                            .toString(),
                                    110.h,
                                    100.h),
                                8.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 0.5.sw,
                                      child: Text(
                                        widget.newsList[index].title.toString(),
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
                                        splitDateTimeWithoutYear(widget
                                            .newsList[index].scheduled
                                            .toString()),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                    8.verticalSpace,
                                    Row(
                                      children: [
                                        Text(
                                          'learnMore'.tr,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: kPrimaryColor),
                                        ),
                                        10.horizontalSpace,
                                        Icon(
                                          Icons.arrow_outward,
                                          size: 20,
                                          color: kPrimaryColor,
                                        )
                                      ],
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
                ),
              ],
            ),
          ),
        ));
  }
}
