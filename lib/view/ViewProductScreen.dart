import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/viewProductController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/model/ViewProductModel.dart';
import 'package:tiqarte/view/MyBasketScreen.dart';
import 'package:tiqarte/view/SeeAllProductsScreen.dart';

class ViewProductScreen extends StatefulWidget {
  final String productId;
  final String categoryId;

  const ViewProductScreen(
      {super.key, required this.productId, required this.categoryId});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final _viewProductController = Get.put(ViewProductController());
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getSingleProductDetail(widget.productId);
    if (res != null && res is Map) {
      _viewProductController.addViewProductData(res);
      var res_more = await ApiService().getMoreLikeProducts(widget.categoryId);
      if (res_more != null && res_more is List)
        _viewProductController.addMoreLikeProductsData(
            res_more, widget.productId);
    } else if (res != null && res is String) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
    }
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
        child: GetBuilder<ViewProductController>(builder: (_vpc) {
          return _vpc.viewProductModel.productName == null
              ? Center(
                  child: spinkit,
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          customProductImage(
                              _vpc.viewProductModel.productImageUrLs!.isNotEmpty
                                  ? _vpc
                                      .viewProductModel
                                      .productImageUrLs![_vpc.customIndex]
                                      .imageUrl
                                      .toString()
                                  : "null",
                              1.sw,
                              270.h),
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
                                  itemCount: _vpc.viewProductModel
                                      .productImageUrLs?.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        _vpc.selectProductImage(index);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10.0),
                                        width: 80.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          border: _vpc
                                                      .viewProductModel
                                                      .productImageUrLs![index]
                                                      .isSelected ==
                                                  true
                                              ? Border.all(
                                                  color: kPrimaryColor,
                                                  width: 2)
                                              : Border.all(
                                                  color: Colors.grey, width: 2),
                                        ),
                                        child: customCardImage(
                                            _vpc
                                                .viewProductModel
                                                .productImageUrLs![index]
                                                .imageUrl
                                                .toString(),
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
                              _vpc.viewProductModel.productName.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            15.verticalSpace,
                            Text(
                              _vpc.viewProductModel.price.toString(),
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                                  "Select " + color,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                value: _vpc.selectedColor,
                                onChanged: (value) {
                                  _vpc.selectedColor = value;
                                },
                                items: _vpc.colorList //items
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item.variationName.toString(),
                                        child: Text(
                                          item.variationName.toString(),
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                                  "Select " + size,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                value: _vpc.selectedSize,
                                onChanged: (value) {
                                  _vpc.selectedSize = value;
                                },
                                items: _vpc.sizeList //items
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item.variationName.toString(),
                                        child: Text(
                                          item.variationName.toString(),
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
                            Text(
                              quantity,
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                                  "Select " + quantity,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                value: _vpc.selectedQuantity,
                                onChanged: (value) {
                                  _vpc.selectedQuantity = value;
                                },
                                items: _vpc.quantityList //items
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item.toString(),
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
                                  child: Text(description,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                                FittedBox(
                                  child: Text(deliveryDetails,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Container(
                              height: 80.h,
                              child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    //description
                                    SingleChildScrollView(
                                      child: Text(
                                          _vpc.viewProductModel.description
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    //delivery details
                                    SingleChildScrollView(
                                      child: Text(
                                          _vpc.viewProductModel.deliveryDetails
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ]),
                            ),
                            20.verticalSpace,
                            _viewProductController.moreLikeProducts.isEmpty
                                ? SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            moreLikeThis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          _viewProductController
                                                      .moreLikeProducts
                                                      .length >=
                                                  12
                                              ? GestureDetector(
                                                  onTap: () => Get.to(
                                                      () =>
                                                          SeeAllProductsScreen(),
                                                      transition: Transition
                                                          .rightToLeft),
                                                  child: Text(
                                                    seeAll,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kPrimaryColor),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                      20.verticalSpace,
                                      Container(
                                        height: 220.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: _viewProductController
                                              .moreLikeProducts.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                //  Get.to(() => ViewProductScreen());
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    right: 10.0),
                                                padding: EdgeInsets.all(12.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    color: Theme.of(context)
                                                        .secondaryHeaderColor),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    // mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      customCardImage(
                                                          _viewProductController
                                                              .moreLikeProducts[
                                                                  index]
                                                              .imageUrl
                                                              .toString(),
                                                          150.h,
                                                          120.h),
                                                      8.verticalSpace,
                                                      SizedBox(
                                                        width: 0.4.sw,
                                                        child: Text(
                                                          _viewProductController
                                                              .moreLikeProducts[
                                                                  index]
                                                              .productName
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      5.verticalSpace,
                                                      Text(
                                                        _viewProductController
                                                            .moreLikeProducts[
                                                                index]
                                                            .productFor
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      5.verticalSpace,
                                                      FittedBox(
                                                        child: Text(
                                                          _viewProductController
                                                              .moreLikeProducts[
                                                                  index]
                                                              .price
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  kPrimaryColor),
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
                                    ],
                                  ),
                            _vpc.quantityList.isEmpty
                                ? customButton(outOfStock, Colors.red)
                                : GestureDetector(
                                    onTap: () {
                                      if (_vpc.selectedColor == null ||
                                          _vpc.selectedSize == null ||
                                          _vpc.selectedQuantity == null) {
                                        customSnackBar(
                                            alert, "Please select all details");
                                      } else {
                                        Attribute colorAttribute = _vpc
                                            .viewProductModel.attributes!
                                            .firstWhere((element) => element
                                                .attributeName!
                                                .toUpperCase()
                                                .contains("COLOR"));
                                        Variation colorVariation =
                                            colorAttribute.variations!
                                                .firstWhere((element) => element
                                                    .variationName!
                                                    .toUpperCase()
                                                    .contains(_vpc
                                                        .selectedColor!
                                                        .toUpperCase()));

                                        Attribute sizeAttribute = _vpc
                                            .viewProductModel.attributes!
                                            .firstWhere((element) => element
                                                .attributeName!
                                                .toUpperCase()
                                                .contains("SIZE"));
                                        Variation sizeVariation = sizeAttribute
                                            .variations!
                                            .firstWhere((element) => element
                                                .variationName!
                                                .toUpperCase()
                                                .contains(_vpc.selectedSize!
                                                    .toUpperCase()));
                                        var data = {
                                          "ProductId": int.parse(_vpc
                                              .viewProductModel.id
                                              .toString()),
                                          "Quantity": int.parse(
                                              _vpc.selectedQuantity.toString()),
                                          "Attributes": [
                                            {
                                              "AttributeId":
                                                  colorAttribute.id?.toInt(),
                                              "VariationId":
                                                  colorVariation.id?.toInt()
                                            },
                                            {
                                              "AttributeId":
                                                  sizeAttribute.id?.toInt(),
                                              "VariationId":
                                                  sizeVariation.id?.toInt()
                                            }
                                          ],
                                        };
                                        ApiService().addToCart(context, data);
                                      }
                                    },
                                    child: customButton(
                                        addtoBasket, kPrimaryColor),
                                  ),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }

  customProductImage(String url, double width, double height) {
    return url != "" && url != "null"
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
