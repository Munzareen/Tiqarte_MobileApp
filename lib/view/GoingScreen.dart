import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/controller/goingController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/model/EventDetailModel.dart';

class GoingScreen extends StatefulWidget {
  final List<Customer> customerList;
  const GoingScreen({super.key, required this.customerList});

  @override
  State<GoingScreen> createState() => _GoingScreenState();
}

class _GoingScreenState extends State<GoingScreen> {
  final _searchController = TextEditingController();

  final _goingController = Get.put(GoingController());

  @override
  void initState() {
    super.initState();
    _goingController.addCustomers(widget.customerList);
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    backgroundColor: kSecondBackgroundColor,
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
          child: GetBuilder<GoingController>(builder: (_gc) {
            return _gc.customerList == null
                ? Center(
                    child: spinkit,
                  )
                : Column(
                    children: [
                      20.verticalSpace,
                      _gc.isSearch
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => Get.back(),
                                    icon: Icon(Icons.arrow_back)),
                                Expanded(
                                  child: TextFormField(
                                    focusNode: _gc.searchFocusNode,
                                    cursorColor: kPrimaryColor,
                                    controller: _searchController,
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
                                          color: _gc.iconColorSearch,
                                        ),
                                        errorBorder: customOutlineBorder,
                                        enabledBorder: customOutlineBorder,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: kPrimaryColor)),
                                        disabledBorder: customOutlineBorder,
                                        filled: true,
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                            color: Color(0xff9E9E9E),
                                            fontSize: 14)),
                                    onChanged: _gc.searchList,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          textRegExp),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      _gc.customerList = _gc.customerListAll;
                                      _gc.onnSearch(false);
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () => Get.back(),
                                        icon: Icon(Icons.arrow_back)),
                                    10.horizontalSpace,
                                    Text(
                                      _gc.customerList!.length.toString() +
                                          " Going",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      _gc.onnSearch(true);
                                    },
                                    icon: Icon(Icons.search))
                              ],
                            ),
                      20.verticalSpace,
                      _gc.customerList!.isEmpty
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
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _gc.customerList?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: ListTile(
                                      leading: customProfileImage(
                                          _gc.customerList![index].imageUrl
                                              .toString(),
                                          60,
                                          60),
                                      title: Text(
                                        _gc.customerList![index].name
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // trailing: goingList[index]
                                      //             ['isFollowed'] ==
                                      //         true
                                      //     ? InkWell(
                                      //         onTap: () {
                                      //           setState(() {
                                      //             goingList[index]
                                      //                     ['isFollowed'] =
                                      //                 !goingList[index]
                                      //                     ['isFollowed'];
                                      //           });
                                      //         },
                                      //         child: Container(
                                      //           // width: 0.2.sh,
                                      //           padding: EdgeInsets.symmetric(
                                      //               horizontal: 20.0,
                                      //               vertical: 10.0),
                                      //           decoration: BoxDecoration(
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       20.0),
                                      //               border: Border.all(
                                      //                   color: kPrimaryColor,
                                      //                   width: 2)),
                                      //           child: Text(
                                      //             following,
                                      //             textAlign: TextAlign.center,
                                      //             style: TextStyle(
                                      //                 fontSize: 14,
                                      //                 fontWeight:
                                      //                     FontWeight.w500,
                                      //                 color: kPrimaryColor),
                                      //           ),
                                      //         ),
                                      //       )
                                      //     : InkWell(
                                      //         onTap: () {
                                      //           setState(() {
                                      //             // if (goingList[index]['isFollowed'] ==
                                      //             //     true) {
                                      //             //   goingList[index]['isFollowed'] = false;
                                      //             // } else {
                                      //             //   goingList[index]['isFollowed'] = true;
                                      //             // }
                                      //             goingList[index]
                                      //                     ['isFollowed'] =
                                      //                 !goingList[index]
                                      //                     ['isFollowed'];
                                      //           });
                                      //         },
                                      //         child: Container(
                                      //           // width: 0.2.sh,
                                      //           padding: EdgeInsets.symmetric(
                                      //               horizontal: 20.0,
                                      //               vertical: 10.0),
                                      //           decoration: BoxDecoration(
                                      //               color: kPrimaryColor,
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       20.0)),
                                      //           child: Text(
                                      //             follow,
                                      //             textAlign: TextAlign.center,
                                      //             style: TextStyle(
                                      //                 fontSize: 14,
                                      //                 fontWeight:
                                      //                     FontWeight.w500,
                                      //                 color: Colors.white),
                                      //           ),
                                      //         ),
                                      //       ),
                                    ),
                                  );
                                },
                              ),
                            )
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
