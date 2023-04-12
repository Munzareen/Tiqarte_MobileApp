import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/MyBasketScreen.dart';
import 'package:tiqarte/view/SeeAllProductsScreen.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({super.key});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen>
    with SingleTickerProviderStateMixin {
  List productImageList = [
    {"image": tshirtImage, "isSelected": true},
    {"image": tshirtImage2, "isSelected": false}
  ];
  String? selectedColor;
  String? selectedSize;

  List colorList = [
    'Black',
    'White',
    'Orange',
    'Blue',
    'Red',
  ];
  List sizeList = ['XXL', 'XL', 'L', 'M', 'S', 'XS'];

  int customIndex = 0;

  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  customProductImage(
                      productImageList[customIndex]['image'], 1.sw, 270.h),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back)),
                  Positioned(
                    bottom: -40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        height: 80.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: productImageList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  productImageList.forEach((element) {
                                    element['isSelected'] = false;
                                  });
                                  productImageList[index]['isSelected'] = true;
                                });
                                customIndex = index;
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: productImageList[index]
                                              ['isSelected'] ==
                                          true
                                      ? Border.all(
                                          color: kPrimaryColor, width: 2)
                                      : Border.all(
                                          color: Colors.grey, width: 2),
                                ),
                                child: customCardImage(
                                    productImageList[index]['image'],
                                    80.w,
                                    70.h),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              50.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "White Last Team Standing t-shirt for men's",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    15.verticalSpace,
                    Text(
                      "€20.00",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    15.verticalSpace,
                    Text(
                      color,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
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
                        dropdownColor: Theme.of(context).colorScheme.secondary,
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
                          "Select " + color,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        value: selectedColor,
                        onChanged: (value) {
                          selectedColor = value;
                        },
                        items: colorList //items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
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
                    15.verticalSpace,
                    Text(
                      size,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
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
                        dropdownColor: Theme.of(context).colorScheme.secondary,
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
                          "Select " + size,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        value: selectedSize,
                        onChanged: (value) {
                          selectedSize = value;
                        },
                        items: sizeList //items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
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
                          child: Text(description,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                        FittedBox(
                          child: Text(deliveryDetails,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Container(
                      height: 80.h,
                      child: TabBarView(controller: tabController, children: [
                        //description
                        SingleChildScrollView(
                          child: Text(
                              "This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                        //delivery details
                        SingleChildScrollView(
                          child: Text(
                              "This is a detail text place.This is a detail text place.This is a detail text place.This is a detail text place.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                      ]),
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          moreLikeThis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(() => SeeAllProductsScreen(),
                              transition: Transition.rightToLeft),
                          child: Text(
                            seeAll,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Container(
                      height: 220.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => ViewProductScreen());
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10.0),
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                              child: SingleChildScrollView(
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customCardImage(tshirtImage, 150.h, 120.h),
                                    8.verticalSpace,
                                    SizedBox(
                                      width: 0.4.sw,
                                      child: Text(
                                        "R.Madrid T-Shirtk",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      forMen,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    5.verticalSpace,
                                    FittedBox(
                                      child: Text(
                                        "Starting from 70,00€",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: kPrimaryColor),
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
                    20.verticalSpace,
                    InkWell(
                      onTap: () => Get.to(() => MyBasketScreen()),
                      child: customButton(addtoBasket, kPrimaryColor),
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  customProductImage(String url, double width, double height) {
    return url == "" && url == "null"
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) {
              return Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)));
            },
            placeholder: (context, url) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(tshirtImage), fit: BoxFit.cover))),
            errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(tshirtImage), fit: BoxFit.cover))),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(url),
                    fit: BoxFit.cover))); //AssetImage(placeholder)
  }
}
