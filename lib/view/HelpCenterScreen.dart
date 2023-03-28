import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
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
  final _searchController = TextEditingController();
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final _searchFocusNode = FocusNode();
  List faqList = [
    {"name": general, "isSelected": true},
    {"name": account, "isSelected": false},
    {"name": service, "isSelected": false},
    {"name": payment, "isSelected": false}
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        setState(() {
          filledColorSearch = kPrimaryColor.withOpacity(0.2);
          iconColorSearch = kPrimaryColor;
        });
      } else {
        setState(() {
          filledColorSearch = kDisabledColor.withOpacity(0.4);
          iconColorSearch = kDisabledColor;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();

    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            height: 1.sh,
            width: 1.sw,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(children: [
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
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Icon(
                          Icons.more_horiz_sharp,
                          color: Colors.black,
                          size: 25,
                        ),
                      )
                    ],
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
                        child: Text(fAQ,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                      FittedBox(
                        child: Text(contactUs,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Expanded(
                      child: TabBarView(controller: tabController, children: [
                    //FAQ

                    Column(
                      children: [
                        20.verticalSpace,
                        Container(
                          height: 45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: faqList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    faqList.forEach((element) {
                                      element['isSelected'] = false;
                                    });
                                    faqList[index]['isSelected'] = true;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  decoration: BoxDecoration(
                                    color: faqList[index]['isSelected']
                                        ? kPrimaryColor
                                        : Colors.transparent,
                                    border: Border.all(
                                        width: 2, color: kPrimaryColor),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      faqList[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: faqList[index]['isSelected']
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
                        TextFormField(
                          focusNode: _searchFocusNode,
                          cursorColor: kPrimaryColor,
                          controller: _searchController,
                          style: const TextStyle(color: Colors.black),
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
                                color: iconColorSearch,
                              ),
                              errorBorder: customOutlineBorder,
                              enabledBorder: customOutlineBorder,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              disabledBorder: customOutlineBorder,
                              fillColor: filledColorSearch,
                              filled: true,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: Color(0xff9E9E9E), fontSize: 14)),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(textRegExp),
                          ],
                        ),
                      ],
                    ),

                    //Contact US

                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            children: [
                              Image.asset(
                                customerSupportIcon,
                                color: kPrimaryColor,
                              ),
                              10.horizontalSpace,
                              Text("Customer",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    )
                  ]))
                ]))));
  }
}
