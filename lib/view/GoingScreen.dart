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

class GoingScreen extends StatefulWidget {
  const GoingScreen({super.key});

  @override
  State<GoingScreen> createState() => _GoingScreenState();
}

class _GoingScreenState extends State<GoingScreen> {
  bool isSearch = false;
  final _searchController = TextEditingController();
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final _searchFocusNode = FocusNode();

  List goingList = [
    {"image": goingUserImage1, "name": "Leatrice Handler", "isFollowed": false},
    {"image": goingUserImage2, "name": "Tanner Stafford", "isFollowed": false},
    {
      "image": goingUserImage3,
      "name": "Chantal Shelburne",
      "isFollowed": false
    },
    {"image": goingUserImage4, "name": "Maryland Winkles", "isFollowed": false},
    {
      "image": goingUserImage5,
      "name": "Sanjuanita Ordonez",
      "isFollowed": false
    },
    {"image": goingUserImage6, "name": "Marci Senter", "isFollowed": false},
    {"image": goingUserImage7, "name": "Elanor Pera", "isFollowed": false},
    {
      "image": goingUserImage8,
      "name": "Marielle Wigington",
      "isFollowed": false
    },
    {"image": goingUserImage9, "name": "Rodolfo Goode", "isFollowed": false},
  ];

  List allGoingList = [
    {"image": goingUserImage1, "name": "Leatrice Handler", "isFollowed": false},
    {"image": goingUserImage2, "name": "Tanner Stafford", "isFollowed": false},
    {
      "image": goingUserImage3,
      "name": "Chantal Shelburne",
      "isFollowed": false
    },
    {"image": goingUserImage4, "name": "Maryland Winkles", "isFollowed": false},
    {
      "image": goingUserImage5,
      "name": "Sanjuanita Ordonez",
      "isFollowed": false
    },
    {"image": goingUserImage6, "name": "Marci Senter", "isFollowed": false},
    {"image": goingUserImage7, "name": "Elanor Pera", "isFollowed": false},
    {
      "image": goingUserImage8,
      "name": "Marielle Wigington",
      "isFollowed": false
    },
    {"image": goingUserImage9, "name": "Rodolfo Goode", "isFollowed": false},
  ];

  @override
  void initState() {
    super.initState();
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              20.verticalSpace,
              isSearch
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back)),
                        Expanded(
                          child: TextFormField(
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
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                fillColor: filledColorSearch,
                                filled: true,
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            onChanged: searchList,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(textRegExp),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isSearch = false;
                                _searchController.clear();
                                goingList = allGoingList;
                              });
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
                              "20,000+ Going",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isSearch = true;
                              });
                            },
                            icon: Icon(Icons.search))
                      ],
                    ),
              20.verticalSpace,
              goingList.isEmpty
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
                                color: Colors.black),
                          ),
                          10.verticalSpace,
                          Text(
                            seeAllEventNotFoundSubString,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: goingList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ListTile(
                              leading: customProfileImage(
                                  goingList[index]['image'].toString(), 60, 60),
                              title: Text(
                                goingList[index]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: goingList[index]['isFollowed'] == true
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          goingList[index]['isFollowed'] =
                                              !goingList[index]['isFollowed'];
                                        });
                                      },
                                      child: Container(
                                        // width: 0.2.sh,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            border: Border.all(
                                                color: kPrimaryColor,
                                                width: 2)),
                                        child: Text(
                                          following,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: kPrimaryColor),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          // if (goingList[index]['isFollowed'] ==
                                          //     true) {
                                          //   goingList[index]['isFollowed'] = false;
                                          // } else {
                                          //   goingList[index]['isFollowed'] = true;
                                          // }
                                          goingList[index]['isFollowed'] =
                                              !goingList[index]['isFollowed'];
                                        });
                                      },
                                      child: Container(
                                        // width: 0.2.sh,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Text(
                                          follow,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      )),
    );
  }

  void searchList(String query) {
    goingList = allGoingList;
    final suggestion = goingList.where((element) {
      final eventName = element['name']!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    setState(() {
      goingList = suggestion;
      // searchDoc = true;
    });
  }
}
