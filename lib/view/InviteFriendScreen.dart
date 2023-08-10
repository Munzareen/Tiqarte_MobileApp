import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  List inviteList = [
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
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: kSecondBackgroundColor,
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
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back)),
                  10.horizontalSpace,
                  Text(
                    'inviteFriends'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: inviteList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        leading: customProfileImage(
                            inviteList[index]['image'].toString(), 60, 60),
                        title: Text(
                          inviteList[index]['name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: inviteList[index]['isFollowed'] == true
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    inviteList[index]['isFollowed'] =
                                        !inviteList[index]['isFollowed'];
                                  });
                                },
                                child: Container(
                                  // width: 0.2.sh,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: kPrimaryColor, width: 2)),
                                  child: Text(
                                    'invited'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kPrimaryColor),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // if (inviteList[index]['isFollowed'] ==
                                    //     true) {
                                    //   inviteList[index]['isFollowed'] = false;
                                    // } else {
                                    //   inviteList[index]['isFollowed'] = true;
                                    // }
                                    inviteList[index]['isFollowed'] =
                                        !inviteList[index]['isFollowed'];
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
                                    'invite'.tr,
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
      ),
    );
  }
}
