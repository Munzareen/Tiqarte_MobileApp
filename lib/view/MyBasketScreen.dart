import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/myBasketController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/ProductCheckoutScreen.dart';

class MyBasketScreen extends StatefulWidget {
  const MyBasketScreen({super.key});

  @override
  State<MyBasketScreen> createState() => _MyBasketScreenState();
}

class _MyBasketScreenState extends State<MyBasketScreen> {
  MyBasketController _myBasketController = Get.find();

  @override
  void initState() {
    super.initState();
    _myBasketController.myBasketProductsModel = null;

    getData();
  }

  getData() async {
    var res = await ApiService().getAddToCartByUser();

    if (res != null && res is List) {
      _myBasketController.addMyBasketData(res);
    }
  }

  @override
  void dispose() {
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
            child: GetBuilder<MyBasketController>(builder: (_mbc) {
              return _mbc.myBasketProductsModel == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(Icons.arrow_back)),
                          15.verticalSpace,
                          Text(
                            'myBasket'.tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          30.verticalSpace,
                          Expanded(
                            child: Center(child: spinkit),
                          )
                        ],
                      ),
                    )
                  : _mbc.myBasketProductsModel!.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () => Get.back(),
                                  icon: Icon(Icons.arrow_back)),
                              15.verticalSpace,
                              Text(
                                'myBasket'.tr,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              30.verticalSpace,
                              Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () => Get.back(),
                                    icon: Icon(Icons.arrow_back)),
                                15.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'myBasket'.tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${_mbc.myBasketProductsModel!.length.toString()} " +
                                          'item'.tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                20.verticalSpace,
                                Expanded(
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        _mbc.myBasketProductsModel?.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //       borderRadius: BorderRadius.circular(22.0),
                                                //       border:
                                                //           Border.all(color: Colors.grey, width: 2)),
                                                //   child: customCardImage(tshirtImage, 110.h, 120.h),
                                                // ),
                                                customCardImage(
                                                    _mbc
                                                        .myBasketProductsModel![
                                                            index]
                                                        .productURLs
                                                        .toString(),
                                                    90.h,
                                                    120.h),
                                                8.horizontalSpace,
                                                SizedBox(
                                                  width: 0.4.sw,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 0.5.sw,
                                                        child: Text(
                                                          _mbc
                                                              .myBasketProductsModel![
                                                                  index]
                                                              .productName
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      8.verticalSpace,
                                                      Text(
                                                        _mbc
                                                            .myBasketProductsModel![
                                                                index]
                                                            .description
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      8.verticalSpace,
                                                      _mbc
                                                                      .myBasketProductsModel![
                                                                          index]
                                                                      .attributes![
                                                                          0]
                                                                      .attributeName
                                                                      .toString()
                                                                      .trim() ==
                                                                  "null" ||
                                                              _mbc
                                                                      .myBasketProductsModel![
                                                                          index]
                                                                      .attributes![
                                                                          0]
                                                                      .attributeName
                                                                      .toString()
                                                                      .trim() ==
                                                                  ""
                                                          ? SizedBox()
                                                          : Text(
                                                              "${_mbc.myBasketProductsModel![index].attributes![0].attributeName.toString()}: ${_mbc.myBasketProductsModel![index].attributes![0].variationName.toString()}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                      8.verticalSpace,
                                                      _mbc
                                                                      .myBasketProductsModel![
                                                                          index]
                                                                      .attributes![
                                                                          1]
                                                                      .attributeName
                                                                      .toString()
                                                                      .trim() ==
                                                                  "null" ||
                                                              _mbc
                                                                      .myBasketProductsModel![
                                                                          index]
                                                                      .attributes![
                                                                          1]
                                                                      .attributeName
                                                                      .toString()
                                                                      .trim() ==
                                                                  ""
                                                          ? SizedBox()
                                                          : Text(
                                                              "${_mbc.myBasketProductsModel![index].attributes![1].attributeName.toString()}: ${_mbc.myBasketProductsModel![index].attributes![1].variationName.toString()}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                      8.verticalSpace,
                                                      Text(
                                                        "${'quantity'.tr}: ${_mbc.myBasketProductsModel![index].quantity.toString()}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      8.verticalSpace,
                                                      GestureDetector(
                                                        onTap: () {
                                                          customAlertDialogWithoutLogo(
                                                              context,
                                                              'alert'.tr,
                                                              "Are you sure you want to remove ${_mbc.myBasketProductsModel![index].productName.toString()}?",
                                                              "Yes",
                                                              "No", () async {
                                                            Get.back();
                                                            var res = await ApiService().addToCartDelete(
                                                                context,
                                                                int.parse(_mbc
                                                                        .myBasketProductsModel![
                                                                            index]
                                                                        .id
                                                                        .toString())
                                                                    .toString());
                                                            if (res != null) {
                                                              getData();
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          'remove'.tr,
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  _mbc
                                                      .myBasketProductsModel![
                                                          index]
                                                      .price
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kPrimaryColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                20.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'subtotal'.tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _mbc.subTotalPrice.toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                                20.verticalSpace,
                                Text(
                                  'shippingTaxesAtCheckout'.tr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                20.verticalSpace,
                                GestureDetector(
                                  onTap: () =>
                                      Get.to(() => ProductCheckoutScreen()),
                                  child: customButton(
                                      'checkout'.tr, kPrimaryColor),
                                ),
                                20.verticalSpace
                              ]),
                        );
            })));
  }
}
