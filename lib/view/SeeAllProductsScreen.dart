import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/seeAllProductController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/ViewProductScreen.dart';

class SeeAllProductsScreen extends StatefulWidget {
  const SeeAllProductsScreen({
    super.key,
  });

  @override
  State<SeeAllProductsScreen> createState() => _SeeAllProductsScreenState();
}

class _SeeAllProductsScreenState extends State<SeeAllProductsScreen> {
  final _seeAllProductController = Get.put(SeeAllProductController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getAllProductList();
    if (res != null && res is List) {
      _seeAllProductController.addSeeAllProductData(res);
    } else if (res != null && res is String) {
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GetBuilder<SeeAllProductController>(builder: (_spc) {
              return _spc.seeAllProductModel == null
                  ? Center(
                      child: spinkit,
                    )
                  : Column(
                      children: [
                        20.verticalSpace,
                        _spc.isSearch
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () => Get.back(),
                                      icon: Icon(Icons.arrow_back)),
                                  Expanded(
                                    child: TextFormField(
                                      focusNode: _spc.searchFocusNode,
                                      cursorColor: kPrimaryColor,
                                      controller: _spc.searchController,
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
                                            color: _spc.iconColorSearch,
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
                                          hintText: "search".tr,
                                          hintStyle: TextStyle(
                                              color: Color(0xff9E9E9E),
                                              fontSize: 14)),
                                      onChanged: _spc.searchProduct,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            textRegExp),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _spc.onSearchClose(
                                            _spc.searchController);
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
                                        'shop'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _spc.isSearchOrNot(true);
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
                            itemCount: _spc.seeAllProductCategoryList?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _spc.selectSeeAllCategory(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  decoration: BoxDecoration(
                                    color:
                                        _spc.seeAllProductCategoryList![index]
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
                                        customCategoryImage(_spc
                                            .seeAllProductCategoryList![index]
                                            .imageURL
                                            .toString()),
                                        5.horizontalSpace,
                                        Text(
                                          _spc.seeAllProductCategoryList![index]
                                              .catagoryName
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: _spc
                                                          .seeAllProductCategoryList![
                                                              index]
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
                              _spc.seeAllProductModel!.length.toString() +
                                  " " +
                                  'found'.tr,
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
                                      _spc.isListSelectedOrNot(true);
                                    },
                                    icon: Icon(
                                      Icons.list_alt,
                                      color: _spc.isListSelected
                                          ? kPrimaryColor
                                          : kDisabledColor,
                                      size: 25,
                                    )),
                                5.horizontalSpace,
                                IconButton(
                                    onPressed: () {
                                      _spc.isListSelectedOrNot(false);
                                    },
                                    icon: Icon(
                                      Icons.grid_view,
                                      color: _spc.isListSelected
                                          ? kDisabledColor
                                          : kPrimaryColor,
                                      size: 25,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        5.verticalSpace,
                        _spc.seeAllProductModel!.isEmpty
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
                                      'notFound'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    10.verticalSpace,
                                    Text(
                                      'foundSubString'.tr,
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
                                    !_spc.isListSelected
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
                                                      mainAxisExtent: 255),
                                              itemCount: _spc
                                                  .seeAllProductModel?.length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                        () => ViewProductScreen(
                                                              productId: _spc
                                                                  .seeAllProductModel![
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              categoryId: _spc
                                                                  .seeAllProductModel![
                                                                      index]
                                                                  .catagoryId
                                                                  .toString(),
                                                            ));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        color: Theme.of(context)
                                                            .secondaryHeaderColor),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        // mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          customCardImage(
                                                              _spc
                                                                  .seeAllProductModel![
                                                                      index]
                                                                  .imageUrl
                                                                  .toString(),
                                                              140.h,
                                                              120.h),
                                                          8.verticalSpace,
                                                          SizedBox(
                                                            width: 0.5.sw,
                                                            child: Text(
                                                              _spc
                                                                  .seeAllProductModel![
                                                                      index]
                                                                  .productName
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          5.verticalSpace,
                                                          Text(
                                                            'forMen'.tr,
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          5.verticalSpace,
                                                          FittedBox(
                                                            child: Text(
                                                              _spc
                                                                  .seeAllProductModel![
                                                                      index]
                                                                  .price
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
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
                                          )
                                        : ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                _spc.seeAllProductModel?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                        () => ViewProductScreen(
                                                              productId: _spc
                                                                  .seeAllProductModel![
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              categoryId: _spc
                                                                  .seeAllProductModel![
                                                                      index]
                                                                  .catagoryId
                                                                  .toString(),
                                                            ));
                                                  },
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
                                                            _spc
                                                                .seeAllProductModel![
                                                                    index]
                                                                .imageUrl
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
                                                                _spc
                                                                    .seeAllProductModel![
                                                                        index]
                                                                    .productName
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
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
                                                            Text(
                                                              'forMen'.tr,
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
                                                            FittedBox(
                                                              child: Text(
                                                                "Starting from " +
                                                                    _spc
                                                                        .seeAllProductModel![
                                                                            index]
                                                                        .price
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kPrimaryColor),
                                                              ),
                                                            ),
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
                    );
            }),
          ),
        ),
      ),
    );
  }
}
