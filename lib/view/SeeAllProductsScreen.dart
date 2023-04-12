import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/ViewProductScreen.dart';

class SeeAllProductsScreen extends StatefulWidget {
  const SeeAllProductsScreen({
    super.key,
  });

  @override
  State<SeeAllProductsScreen> createState() => _SeeAllProductsScreenState();
}

class _SeeAllProductsScreenState extends State<SeeAllProductsScreen> {
  bool isSearch = false;
  final _searchController = TextEditingController();
  Color filledColorSearch = kDisabledColor.withOpacity(0.4);
  Color iconColorSearch = kDisabledColor;
  final _searchFocusNode = FocusNode();

  List eventsCatergoryList = [
    {"name": homeAllString, "icon": allIcon, "isSelected": true},
    {"name": homeMusicString, "icon": musicIcon, "isSelected": false},
    {"name": homeArtString, "icon": artIcon, "isSelected": false},
    {"name": homeWorkshopsString, "icon": workshopIcon, "isSelected": false}
  ];

  List shopList = [
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
  ];

  List allShopList = [
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
    {
      "image": tshirtImage,
      "name": "R.Madrid T-Shirt",
      "price": "70,00€",
    },
  ];

  bool isListSelected = true;

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
                                  suffixIcon: InkWell(
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
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
                                  disabledBorder: customOutlineBorder,
                                  //  fillColor: filledColorSearch,
                                  filled: true,
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                      color: Color(0xff9E9E9E), fontSize: 14)),
                              onChanged: searchEvent,
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
                                  shopList = allShopList;
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
                              Text(
                                shop,
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
                                setState(() {
                                  isSearch = true;
                                });
                              },
                              icon: Icon(Icons.search))
                        ],
                      ),
                20.verticalSpace,
                Container(
                  height: 45,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: eventsCatergoryList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            eventsCatergoryList.forEach((element) {
                              element['isSelected'] = false;
                            });
                            eventsCatergoryList[index]['isSelected'] = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: eventsCatergoryList[index]['isSelected']
                                ? kPrimaryColor
                                : Colors.transparent,
                            border: Border.all(width: 2, color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Image.asset(eventsCatergoryList[index]['icon']),
                                5.horizontalSpace,
                                Text(
                                  eventsCatergoryList[index]['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: eventsCatergoryList[index]
                                              ['isSelected']
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
                      shopList.length.toString() + " " + seeAllEventFoundString,
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
                              setState(() {
                                isListSelected = true;
                              });
                            },
                            icon: Icon(
                              Icons.list_alt,
                              color: isListSelected
                                  ? kPrimaryColor
                                  : kDisabledColor,
                              size: 25,
                            )),
                        5.horizontalSpace,
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isListSelected = false;
                              });
                            },
                            icon: Icon(
                              Icons.grid_view,
                              color: isListSelected
                                  ? kDisabledColor
                                  : kPrimaryColor,
                              size: 25,
                            ))
                      ],
                    ),
                  ],
                ),
                5.verticalSpace,
                shopList.isEmpty
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
                        child: ListView(
                          children: [
                            !isListSelected
                                ? Container(
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 20,
                                              mainAxisExtent: 255),
                                      itemCount: shopList.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(() => ViewProductScreen());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                // mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  customCardImage(
                                                      shopList[index]['image'],
                                                      140.h,
                                                      120.h),
                                                  8.verticalSpace,
                                                  SizedBox(
                                                    width: 0.5.sw,
                                                    child: Text(
                                                      shopList[index]['name'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                    forMen,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                      shopList[index]['price'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                  )
                                : ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: shopList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => ViewProductScreen());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor),
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                customCardImage(
                                                    shopList[index]['image'],
                                                    110.h,
                                                    100.h),
                                                8.horizontalSpace,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 0.5.sw,
                                                      child: Text(
                                                        shopList[index]['name'],
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    8.verticalSpace,
                                                    Text(
                                                      forMen,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    8.verticalSpace,
                                                    FittedBox(
                                                      child: Text(
                                                        "Starting from " +
                                                            shopList[index]
                                                                ['price'],
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
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
            ),
          ),
        ),
      ),
    );
  }

  void searchEvent(String query) {
    shopList = allShopList;
    final suggestion = shopList.where((element) {
      final eventName = element['name']!.toLowerCase();
      final input = query.toLowerCase();
      return eventName.contains(input);
    }).toList();
    setState(() {
      shopList = suggestion;
      // searchDoc = true;
    });
  }
}
