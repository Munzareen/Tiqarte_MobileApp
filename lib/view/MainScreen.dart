import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/controller/NavigationBarController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/ExploreScreen.dart';
import 'package:tiqarte/view/FavoriteScreen.dart';
import 'package:tiqarte/view/HomeScreen.dart';
import 'package:tiqarte/view/ProfileScreen.dart';
import 'package:tiqarte/view/TicketScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bt = Get.put(NavigationBarController());

  var screens = [
    HomeScreen(),
    ExploreScreen(),
    FavoriteScreen(),
    TicketScreen(),
    ProfileScreen()
  ];

  void _onItemTaapped(int index) {
    bt.navBarChange(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NavigationBarController>(
        builder: (_) => screens[bt.navigationBarIndexValue],
      ),
      extendBody: true,
      bottomNavigationBar: GetBuilder<NavigationBarController>(
        builder: (_) => BottomAppBar(
          elevation: 0,
          clipBehavior: Clip.none,
          color: Colors.transparent,
          child: Container(
            height: 50.h,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  clipBehavior: Clip.none,
                  //  height: 50.h,
                  width: 1.sw,
                  decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor

                      // border: Border(
                      //     top: BorderSide(color: kDisabledColor, width: 0.3))
                      ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () => _onItemTaapped(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bt.navigationBarIndexValue == 0
                                  ? Image.asset(
                                      homeIconSelected,
                                    )
                                  : Image.asset(
                                      homeIcon,
                                    ),
                              2.verticalSpace,
                              Text(
                                bottomNavBarHomeString,
                                style: TextStyle(
                                  color: bt.navigationBarIndexValue == 0
                                      ? kPrimaryColor
                                      : Colors.grey,
                                  fontSize: 10,
                                  fontWeight: bt.navigationBarIndexValue == 0
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => _onItemTaapped(1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bt.navigationBarIndexValue == 1
                                  ? Image.asset(
                                      exploreIconSelected,
                                    )
                                  : Image.asset(
                                      exploreIcon,
                                    ),
                              2.verticalSpace,
                              Text(
                                bottomNavBarExploreString,
                                style: TextStyle(
                                  color: bt.navigationBarIndexValue == 1
                                      ? kPrimaryColor
                                      : Colors.grey,
                                  fontSize: 10,
                                  fontWeight: bt.navigationBarIndexValue == 1
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => _onItemTaapped(2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bt.navigationBarIndexValue == 2
                                  ? Image.asset(
                                      favoriteIconSelected,
                                    )
                                  : Image.asset(
                                      favoriteIcon,
                                    ),
                              2.verticalSpace,
                              Text(
                                bottomNavBarFavoritestring,
                                style: TextStyle(
                                  color: bt.navigationBarIndexValue == 2
                                      ? kPrimaryColor
                                      : Colors.grey,
                                  fontSize: 10,
                                  fontWeight: bt.navigationBarIndexValue == 2
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => _onItemTaapped(3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bt.navigationBarIndexValue == 3
                                  ? Image.asset(
                                      ticketIconSelected,
                                    )
                                  : Image.asset(
                                      ticketIcon,
                                    ),
                              2.verticalSpace,
                              Text(
                                bottomNavBarTicketsString,
                                style: TextStyle(
                                  color: bt.navigationBarIndexValue == 3
                                      ? kPrimaryColor
                                      : Colors.grey,
                                  fontSize: 10,
                                  fontWeight: bt.navigationBarIndexValue == 3
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => _onItemTaapped(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bt.navigationBarIndexValue == 4
                                  ? Image.asset(
                                      profileIconSelected,
                                    )
                                  : Image.asset(
                                      profileIcon,
                                    ),
                              2.verticalSpace,
                              Text(
                                bottomNavBarProfileString,
                                style: TextStyle(
                                  color: bt.navigationBarIndexValue == 4
                                      ? kPrimaryColor
                                      : Colors.grey,
                                  fontSize: 10,
                                  fontWeight: bt.navigationBarIndexValue == 4
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
