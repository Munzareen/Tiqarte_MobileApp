import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/helpCenterController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final _helpCenterController = Get.put(HelpCenterController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    getData();
  }

  getData() async {
    var res = await ApiService().getAllFAQTypes();
    if (res != null && res is List) {
      res.insert(0, "All");
      _helpCenterController.addFAQTypes(res);
    }
    var res_data = await ApiService().getAllFAQs();
    if (res_data != null && res_data is List) {
      _helpCenterController.addFAQData(res_data);
    }
  }

  @override
  void dispose() {
    _helpCenterController.searchFocusNode.dispose();
    _helpCenterController.searchController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            //   backgroundColor: kSecondBackgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
              height: 1.sh,
              width: 1.sw,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GetBuilder<HelpCenterController>(builder: (_hcc) {
                    return _hcc.faqModelList != null &&
                            _hcc.faqModelListAll!.isNotEmpty
                        ? Column(children: [
                            20.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () => Get.back(),
                                        icon: Icon(Icons.arrow_back)),
                                    Text(
                                      helpCenter,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Icon(
                                    Icons.more_horiz_sharp,
                                    size: 25,
                                  ),
                                )
                              ],
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
                                  child: Text(fAQ,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                                FittedBox(
                                  child: Text(contactUs,
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
                                  //FAQ

                                  Column(
                                    children: [
                                      20.verticalSpace,
                                      Container(
                                        width: 1.sw,
                                        height: 45,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _hcc.fAQTypeList?.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                _hcc.selectFAQType(index);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5.0),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                decoration: BoxDecoration(
                                                  color: _hcc
                                                          .fAQTypeList![index]
                                                          .isSelected!
                                                      ? kPrimaryColor
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                      width: 2,
                                                      color: kPrimaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    _hcc.fAQTypeList![index]
                                                        .name
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: _hcc
                                                                .fAQTypeList![
                                                                    index]
                                                                .isSelected!
                                                            ? Colors.white
                                                            : kPrimaryColor),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      20.verticalSpace,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: TextFormField(
                                          focusNode: _hcc.searchFocusNode,
                                          cursorColor: kPrimaryColor,
                                          controller: _hcc.searchController,
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
                                                color: _hcc.iconColorSearch,
                                              ),
                                              errorBorder: customOutlineBorder,
                                              enabledBorder:
                                                  customOutlineBorder,
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.0)),
                                                  borderSide: BorderSide(
                                                      color: kPrimaryColor)),
                                              disabledBorder:
                                                  customOutlineBorder,
                                              //  fillColor: filledColorSearch,
                                              filled: true,
                                              hintText: search,
                                              hintStyle: TextStyle(
                                                  color: Color(0xff9E9E9E),
                                                  fontSize: 14)),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                textRegExp),
                                          ],
                                          onChanged: _hcc.searchFAQ,
                                        ),
                                      ),
                                      20.verticalSpace,
                                      _hcc.faqModelList!.isEmpty
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
                                                  notFound,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ))
                                          : Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    _hcc.faqModelList?.length,
                                                itemBuilder: (context, index) {
                                                  return customExpandableCard(
                                                      index, _hcc);
                                                },
                                              ),
                                            )
                                    ],
                                  ),

                                  //Contact US

                                  Column(
                                    children: [
                                      20.verticalSpace,
                                      customContainer(
                                          customerService, customerSupportIcon),
                                      20.verticalSpace,
                                      customContainer(whatsApp, whatsappIcon),
                                      20.verticalSpace,
                                      customContainer(website, websiteIcon),
                                      20.verticalSpace,
                                      customContainer(facebook,
                                          facebookIconWithPrimaryColor),
                                      20.verticalSpace,
                                      customContainer(twitter, twitterIcon),
                                      20.verticalSpace,
                                      customContainer(instagram, instagramIcon),
                                    ],
                                  )
                                ]))
                          ])
                        : Center(
                            child: spinkit,
                          );
                  })))),
    );
  }

  customContainer(String name, String imgIcon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).secondaryHeaderColor),
      child: Row(
        children: [
          Image.asset(
            imgIcon,
            color: kPrimaryColor,
          ),
          10.horizontalSpace,
          Text(name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  customExpandableCard(int index, HelpCenterController _hcc) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Theme.of(context).secondaryHeaderColor,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), side: BorderSide.none),
          tilePadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          title: Text(
            _hcc.faqModelList![index].fAQQuestion.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          trailing: Icon(
            Icons.arrow_drop_down,
            color: kPrimaryColor,
            size: 25,
          ),
          children: [expandedCard(index, _hcc)],
        ),
      ),
    );
  }

  expandedCard(int index, HelpCenterController _hcc) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Text(
              _hcc.faqModelList![index].fAQAnswer.toString(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ],
        ));
  }
}
