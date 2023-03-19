import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/images.dart';

SpinKitCircle spinkit = SpinKitCircle(
  color: kPrimaryColor,
  size: 50.0,
);

const OutlineInputBorder customOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide.none,
);

final textRegExp = RegExp('[a-zA-Z]*');

customButton(String text, Color color) {
  return Container(
    height: 50,
    width: 0.9.sw,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(50.0)),
    child: Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white)),
    ),
  );
}

customAlertDialog(
  BuildContext context,
  String logo,
  IconData icon,
  String title,
  String contentMsg,
) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            height: 0.4.sh,
            width: 0.8.sw,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              backgroundColor: kBackgroundColor,
              actionsPadding: EdgeInsets.symmetric(vertical: 0),
              actionsAlignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              actions: [
                10.verticalSpace,
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(logo))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                    child: Text(
                  title,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      contentMsg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                20.verticalSpace,
                spinkit,
                25.verticalSpace,
              ],
            ),
          ),
        );
      });
}

customAlertDialogForPermission(
    BuildContext context,
    String logo,
    IconData icon,
    String title,
    String contentMsg,
    String yesBtnText,
    String noBtntext,
    Function() yesPressed) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            height: 0.4.sh,
            width: 0.8.sw,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              backgroundColor: kBackgroundColor,
              actionsPadding: EdgeInsets.symmetric(vertical: 0),
              actionsAlignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              actions: [
                10.verticalSpace,
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(logo))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                    child: Text(
                  title,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      contentMsg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: yesPressed,
                        child: Container(
                          height: 50,
                          width: 0.5.sw,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(yesBtnText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 0.5.sw,
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text(noBtntext,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: kPrimaryColor)),
                          ),
                        ),
                      ),

                      // OutlinedButton(
                      //   child: Text(
                      //     yesBtnText,
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   onPressed: yesPressed,
                      //   style: ButtonStyle(
                      //     padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      //     shape: MaterialStatePropertyAll(
                      //         RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12.0))),
                      //     backgroundColor:
                      //         MaterialStatePropertyAll(kPrimaryColor),
                      //   ),
                      // ),
                      // OutlinedButton(
                      //   child: Text(
                      //     noBtntext,
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //   },
                      //   style: ButtonStyle(
                      //     padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      //     shape: MaterialStatePropertyAll(
                      //         RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12.0))),
                      //     backgroundColor:
                      //         MaterialStatePropertyAll(kPrimaryColor),
                      //   ),
                      // )
                    ],
                  ),
                ),
                25.verticalSpace,
              ],
            ),
          ),
        );
      });
}

customProfileImage(String url, double width, double height) {
  return url != "" || url != "null"
      ? CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) {
            return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    // border: Border.all(
                    //   color: kPrimaryColor,
                    //   style: BorderStyle.solid,
                    // ),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)));
          },
          placeholder: (context, url) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.0),
                  // border: Border.all(
                  //   color: kPrimaryColor,
                  //   style: BorderStyle.solid,
                  // ),
                  image: DecorationImage(
                      image: AssetImage(profileImage), fit: BoxFit.cover))),
          errorWidget: (context, url, error) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.0),
                  // border: Border.all(
                  //   color: kPrimaryColor,
                  //   style: BorderStyle.solid,
                  // ),
                  image: DecorationImage(
                      image: AssetImage(profileImage), fit: BoxFit.cover))),
        )
      : Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.0),
              // border: Border.all(
              //   color: kPrimaryColor,
              //   style: BorderStyle.solid,
              // ),
              image: DecorationImage(
                  image: AssetImage(profileImage),
                  fit: BoxFit.cover))); //AssetImage(placeholder)
}

customCardImage(String url, double width, double height) {
  return url == "" && url == "null"
      ? CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) {
            return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // border: Border.all(
                    //   color: kPrimaryColor,
                    //   style: BorderStyle.solid,
                    // ),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)));
          },
          placeholder: (context, url) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  // border: Border.all(
                  //   color: kPrimaryColor,
                  //   style: BorderStyle.solid,
                  // ),
                  image: DecorationImage(
                      image: AssetImage(eventImage), fit: BoxFit.cover))),
          errorWidget: (context, url, error) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  // border: Border.all(
                  //   color: kPrimaryColor,
                  //   style: BorderStyle.solid,
                  // ),
                  image: DecorationImage(
                      image: AssetImage(eventImage), fit: BoxFit.cover))),
        )
      : Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              // border: Border.all(
              //   color: kPrimaryColor,
              //   style: BorderStyle.solid,
              // ),
              image: DecorationImage(
                  image: AssetImage(eventImage),
                  fit: BoxFit.cover))); //AssetImage(placeholder)
}

exitUser() {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}
