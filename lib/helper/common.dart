import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/images.dart';

RxBool isDarkTheme = false.obs;
String accessToken = '';
String userId = '';
String userName = '';
String userImage = '';
String userEmail = '';
String language = 'en';
String promotorId = "1";
String userNickname = '';
String userDob = '';
String userState = '';
String userCity = '';
String userZipcode = '';
String userCountrycode = '';
String userNumber = '';
String userGender = '';

SharedPreferences? prefs;
String savedDir = '';

SpinKitCircle spinkit = SpinKitCircle(
  color: kPrimaryColor,
  size: 50.0,
);

const OutlineInputBorder customOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide.none,
);

final textRegExp = RegExp('[a-zA-Z\\s]*');
final alphanumeric = RegExp('[a-zA-Z0-9\\s]*');
final numberRegExp = RegExp('[0-9]*');

customButton(String text, Color color) {
  return Container(
    height: 50,
    width: 0.9.sw,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(50.0)),
    child: Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

customAlertDialogWithSpinkit(
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
              backgroundColor: Theme.of(context).secondaryHeaderColor,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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

customAlertDialogWithOneButton(BuildContext context, String logo, IconData icon,
    String title, String contentMsg, String butonText, Function() onPressed) {
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
              backgroundColor: Theme.of(context).secondaryHeaderColor,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Container(
                      height: 50,
                      width: 0.6.sw,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Center(
                        child: Text(butonText,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
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
    VoidCallback yesPressed) {
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
              backgroundColor: Theme.of(context).secondaryHeaderColor,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
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
                      GestureDetector(
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

customAlertDialogWithTwoButtons(
  BuildContext context,
  String logo,
  IconData icon,
  String title,
  String contentMsg,
  String yesBtnText,
  String noBtntext,
  Function() yesPressed,
  Function() noPressed,
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
              backgroundColor: Theme.of(context).secondaryHeaderColor,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
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
                      GestureDetector(
                        onTap: noPressed,
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

customAlertDialogWithoutLogo(
    BuildContext context,
    String title,
    String contentMsg,
    String yesBtnText,
    String noBtntext,
    VoidCallback yesPressed) {
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
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              actionsPadding: EdgeInsets.symmetric(vertical: 0),
              actionsAlignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              actions: [
                10.verticalSpace,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
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
                      GestureDetector(
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
  return url != "" && url != "null"
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
                      image: AssetImage(placeholder), fit: BoxFit.cover))),
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
                      image: AssetImage(placeholder), fit: BoxFit.cover))),
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
                  image: AssetImage(placeholder),
                  fit: BoxFit.cover))); //AssetImage(placeholder)
}

customCardImage(String url, double width, double height) {
  return url != "" && url != "null"
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
                      image: AssetImage(eventPlaceholder), fit: BoxFit.cover))),
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
                      image: AssetImage(eventPlaceholder), fit: BoxFit.cover))),
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
                  image: AssetImage(eventPlaceholder), fit: BoxFit.cover)));
}

customCategoryImage(String url) {
  return url != "" && url != "null"
      ? CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) {
            return Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)));
          },
          placeholder: (context, url) => Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: AssetImage(categoryPlaceholder),
                      fit: BoxFit.cover))),
          errorWidget: (context, url, error) => Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: AssetImage(categoryPlaceholder),
                      fit: BoxFit.cover))),
        )
      : Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage(categoryPlaceholder),
                fit: BoxFit.cover,
              )));
}

customSnackBar(String title, String message) {
  return Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: kPrimaryColor,
      colorText: Colors.white);
}

String splitDateTimeWithoutYear(String date) {
  if (date.isNotEmpty && date != "null") {
    try {
      DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
      var inputDate = DateTime.parse(parserDate.toString());
      var outPutFormate = DateFormat('E d • h:mm a');
      var OutPutDate = outPutFormate.format(inputDate);
      return OutPutDate;
    } on Exception catch (_) {
      try {
        DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('E d • h:mm a');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      } on Exception catch (_) {
        try {
          DateTime parserDate =
              DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(date);
          var inputDate = DateTime.parse(parserDate.toString());
          var outPutFormate = DateFormat('E d • h:mm a');
          var OutPutDate = outPutFormate.format(inputDate);
          return OutPutDate;
        } on Exception catch (_) {
          try {
            DateTime parserDate = DateFormat("dd/MM/yyyy").parse(date);
            var inputDate = DateTime.parse(parserDate.toString());
            var outPutFormate = DateFormat('E d • h:mm a');
            var OutPutDate = outPutFormate.format(inputDate);
            return OutPutDate;
          } catch (_) {
            DateTime parserDate =
                DateFormat("dd/MM/yyyy HH:mm:ss a").parse(date);
            var inputDate = DateTime.parse(parserDate.toString());
            var outPutFormate = DateFormat('E d • h:mm a');
            var OutPutDate = outPutFormate.format(inputDate);
            return OutPutDate;
          }
        }
      }
    }
  } else {
    return "";
  }
}

String splitDateOnly(String date) {
  if (date.isNotEmpty && date != "null") {
    try {
      DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
      var inputDate = DateTime.parse(parserDate.toString());
      var outPutFormate = DateFormat('EEEE d, yyyy');
      var OutPutDate = outPutFormate.format(inputDate);
      return OutPutDate;
    } on Exception catch (_) {
      try {
        DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('EEEE d, yyyy');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      } catch (_) {
        DateTime parserDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('EEEE d, yyyy');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      }
    }
  } else {
    return "";
  }
}

String splitTimeOnly(String date) {
  if (date.isNotEmpty && date != "null") {
    try {
      DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
      var inputDate = DateTime.parse(parserDate.toString());
      var outPutFormate = DateFormat('h:mm a');
      var OutPutDate = outPutFormate.format(inputDate);
      return OutPutDate;
    } on Exception catch (_) {
      try {
        DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('h:mm a');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      } catch (_) {
        DateTime parserDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('h:mm a');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      }
    }
  } else {
    return "";
  }
}

String EventDateForETicket(String date) {
  if (date.isNotEmpty && date != "null") {
    try {
      DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
      var inputDate = DateTime.parse(parserDate.toString());
      var outPutFormate = DateFormat('EEEE, MMM d • h:mm a');
      var OutPutDate = outPutFormate.format(inputDate);
      return OutPutDate;
    } on Exception catch (_) {
      try {
        DateTime parserDate = DateFormat("dd/MM/yyyy HH:mm:ss a").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('EEEE, MMM d • h:mm a');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      } catch (_) {
        DateTime parserDate = DateFormat("dd/MM/yyyy").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('EEEE, MMM d • h:mm a');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      }
    }
  } else {
    return "";
  }
}

String EventDateForETicketForPDF(String date) {
  if (date.isNotEmpty && date != "null") {
    try {
      DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
      var inputDate = DateTime.parse(parserDate.toString());
      var outPutFormate = DateFormat('EEEE, MMM d , h:mm a');
      var OutPutDate = outPutFormate.format(inputDate);
      return OutPutDate;
    } on Exception catch (_) {
      try {
        DateTime parserDate = DateFormat("dd/MM/yyyy HH:mm:ss a").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('EEEE, MMM d , h:mm a');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      } catch (_) {
        DateTime parserDate = DateFormat("dd/MM/yyyy").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('EEEE, MMM d , h:mm a');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      }
    }
  } else {
    return "";
  }
}

String splitDateForNews(String date) {
  if (date.isNotEmpty && date != "null") {
    try {
      DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
      var inputDate = DateTime.parse(parserDate.toString());
      var outPutFormate = DateFormat('d MMM yyyy');
      var OutPutDate = outPutFormate.format(inputDate);
      return OutPutDate;
    } on Exception catch (_) {
      try {
        DateTime parserDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
        var inputDate = DateTime.parse(parserDate.toString());
        var outPutFormate = DateFormat('d MMM yyyy');
        var OutPutDate = outPutFormate.format(inputDate);
        return OutPutDate;
      } on Exception catch (_) {
        try {
          DateTime parserDate =
              DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(date);
          var inputDate = DateTime.parse(parserDate.toString());
          var outPutFormate = DateFormat('d MMM yyyy');
          var OutPutDate = outPutFormate.format(inputDate);
          return OutPutDate;
        } on Exception catch (_) {
          try {
            DateTime parserDate = DateFormat("dd/MM/yyyy").parse(date);
            var inputDate = DateTime.parse(parserDate.toString());
            var outPutFormate = DateFormat('d MMM yyyy');
            var OutPutDate = outPutFormate.format(inputDate);
            return OutPutDate;
          } catch (_) {
            DateTime parserDate =
                DateFormat("dd/MM/yyyy HH:mm:ss a").parse(date);
            var inputDate = DateTime.parse(parserDate.toString());
            var outPutFormate = DateFormat('d MMM yyyy');
            var OutPutDate = outPutFormate.format(inputDate);
            return OutPutDate;
          }
        }
      }
    }
  } else {
    return "";
  }
}

exitUser() {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}

//for filter

RangeValues currentRangeValues = RangeValues(1, 50);
String? selectedLocation;

List eventsCatergoryList = [
  {"name": 'home'.tr, "icon": allIcon, "isSelected": true},
  {"name": 'music'.tr, "icon": musicIcon, "isSelected": false},
  {"name": 'art'.tr, "icon": artIcon, "isSelected": false},
  {"name": 'workshops'.tr, "icon": workshopIcon, "isSelected": false}
];

List locationList = [
  'New York, United States',
  'Times Square NYC, Manhattan',
  'NYC'
];

filterBottomSheet(
    BuildContext context,
    List eventsCatergoryList,
    List locationList,
    String? selectedLocation,
    RangeValues _currentRangeValues) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    5.verticalSpace,
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: kDisabledColor.withOpacity(0.6)),
                    ),
                    15.verticalSpace,
                    Text(
                      'filter'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: kDisabledColor,
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'eventCategory'.tr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'seeAll'.tr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Container(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                // childAspectRatio: 1,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 20,
                                mainAxisExtent: 45),
                        itemCount: eventsCatergoryList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                eventsCatergoryList.forEach((element) {
                                  element['isSelected'] = false;
                                });
                                eventsCatergoryList[index]['isSelected'] = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: eventsCatergoryList[index]['isSelected']
                                    ? kPrimaryColor
                                    : Colors.transparent,
                                border:
                                    Border.all(width: 2, color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        eventsCatergoryList[index]['icon']),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'location'.tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: DropdownButtonFormField(
                        dropdownColor: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12.0),
                        decoration: InputDecoration(
                            constraints: BoxConstraints(),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                        alignment: AlignmentDirectional.centerStart,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          // color: Colors.black,
                        ),
                        iconEnabledColor: kDisabledColor,
                        hint: Text(
                          "New York, United States",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        value: selectedLocation,
                        onChanged: (value) {
                          selectedLocation = value;
                        },
                        items: locationList //items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    20.verticalSpace,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'eventLocationRange'.tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: RangeSlider(
                            inactiveColor: kDisabledColor,
                            activeColor: kPrimaryColor,
                            values: _currentRangeValues,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            labels: RangeLabels(
                              '${_currentRangeValues.start.round()} km',
                              '${_currentRangeValues.end.round()} km',
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedLocation = null;
                            eventsCatergoryList.forEach((element) {
                              element['isSelected'] = false;
                            });
                            eventsCatergoryList[0]['isSelected'] = true;
                            currentRangeValues = RangeValues(1, 50);
                            Get.back();
                          },
                          child: Container(
                            height: 50,
                            width: 0.3.sw,
                            decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Center(
                              child: Text('reset'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ),
                        20.horizontalSpace,
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 50,
                            width: 0.3.sw,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Center(
                              child: Text('apply'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

String getUserIdFromJWT(String token) {
  String jwt = token;

// Split the JWT into its three parts: header, payload, and signature
  List<String> jwtParts = jwt.split('.');

// The payload is the second part
  String encodedPayload = jwtParts[1];

// Ensure the encoded payload length is a multiple of four
  while (encodedPayload.length % 4 != 0) {
    encodedPayload += '=';
  }

// Decode the payload using base64 decoding
  String decodedPayload = utf8.decode(base64Url.decode(encodedPayload));

// Parse the decoded payload as a JSON string
  Map<String, dynamic> payloadJson = json.decode(decodedPayload);

// Retrieve the user ID from the decoded payload
  return payloadJson['userid'];
}

initializePrefs() async {
  prefs = await SharedPreferences.getInstance();
}

List countriesWithCode = [
  {"name": "Afghanistan", "dial_code": "+93", "code": "AF"},
  {"name": "Aland Islands", "dial_code": "+358", "code": "AX"},
  {"name": "Albania", "dial_code": "+355", "code": "AL"},
  {"name": "Algeria", "dial_code": "+213", "code": "DZ"},
  {"name": "AmericanSamoa", "dial_code": "+1684", "code": "AS"},
  {"name": "Andorra", "dial_code": "+376", "code": "AD"},
  {"name": "Angola", "dial_code": "+244", "code": "AO"},
  {"name": "Anguilla", "dial_code": "+1264", "code": "AI"},
  {"name": "Antarctica", "dial_code": "+672", "code": "AQ"},
  {"name": "Antigua and Barbuda", "dial_code": "+1268", "code": "AG"},
  {"name": "Argentina", "dial_code": "+54", "code": "AR"},
  {"name": "Armenia", "dial_code": "+374", "code": "AM"},
  {"name": "Aruba", "dial_code": "+297", "code": "AW"},
  {"name": "Australia", "dial_code": "+61", "code": "AU"},
  {"name": "Austria", "dial_code": "+43", "code": "AT"},
  {"name": "Azerbaijan", "dial_code": "+994", "code": "AZ"},
  {"name": "Bahamas", "dial_code": "+1242", "code": "BS"},
  {"name": "Bahrain", "dial_code": "+973", "code": "BH"},
  {"name": "Bangladesh", "dial_code": "+880", "code": "BD"},
  {"name": "Barbados", "dial_code": "+1246", "code": "BB"},
  {"name": "Belarus", "dial_code": "+375", "code": "BY"},
  {"name": "Belgium", "dial_code": "+32", "code": "BE"},
  {"name": "Belize", "dial_code": "+501", "code": "BZ"},
  {"name": "Benin", "dial_code": "+229", "code": "BJ"},
  {"name": "Bermuda", "dial_code": "+1441", "code": "BM"},
  {"name": "Bhutan", "dial_code": "+975", "code": "BT"},
  {
    "name": "Bolivia, Plurinational State of",
    "dial_code": "+591",
    "code": "BO"
  },
  {"name": "Bosnia and Herzegovina", "dial_code": "+387", "code": "BA"},
  {"name": "Botswana", "dial_code": "+267", "code": "BW"},
  {"name": "Brazil", "dial_code": "+55", "code": "BR"},
  {"name": "British Indian Ocean Territory", "dial_code": "+246", "code": "IO"},
  {"name": "Brunei Darussalam", "dial_code": "+673", "code": "BN"},
  {"name": "Bulgaria", "dial_code": "+359", "code": "BG"},
  {"name": "Burkina Faso", "dial_code": "+226", "code": "BF"},
  {"name": "Burundi", "dial_code": "+257", "code": "BI"},
  {"name": "Cambodia", "dial_code": "+855", "code": "KH"},
  {"name": "Cameroon", "dial_code": "+237", "code": "CM"},
  // {"name": "Canada", "dial_code": "+1", "code": "CA"},
  {"name": "Cape Verde", "dial_code": "+238", "code": "CV"},
  {"name": "Cayman Islands", "dial_code": "+ 345", "code": "KY"},
  {"name": "Central African Republic", "dial_code": "+236", "code": "CF"},
  {"name": "Chad", "dial_code": "+235", "code": "TD"},
  {"name": "Chile", "dial_code": "+56", "code": "CL"},
  {"name": "China", "dial_code": "+86", "code": "CN"},
  {"name": "Christmas Island", "dial_code": "+61", "code": "CX"},
  {"name": "Cocos (Keeling) Islands", "dial_code": "+61", "code": "CC"},
  {"name": "Colombia", "dial_code": "+57", "code": "CO"},
  {"name": "Comoros", "dial_code": "+269", "code": "KM"},
  {"name": "Congo", "dial_code": "+242", "code": "CG"},
  {
    "name": "Congo, The Democratic Republic of the Congo",
    "dial_code": "+243",
    "code": "CD"
  },
  {"name": "Cook Islands", "dial_code": "+682", "code": "CK"},
  {"name": "Costa Rica", "dial_code": "+506", "code": "CR"},
  {"name": "Cote d'Ivoire", "dial_code": "+225", "code": "CI"},
  {"name": "Croatia", "dial_code": "+385", "code": "HR"},
  {"name": "Cuba", "dial_code": "+53", "code": "CU"},
  {"name": "Cyprus", "dial_code": "+357", "code": "CY"},
  {"name": "Czech Republic", "dial_code": "+420", "code": "CZ"},
  {"name": "Denmark", "dial_code": "+45", "code": "DK"},
  {"name": "Djibouti", "dial_code": "+253", "code": "DJ"},
  {"name": "Dominica", "dial_code": "+1767", "code": "DM"},
  {"name": "Dominican Republic", "dial_code": "+1849", "code": "DO"},
  {"name": "Ecuador", "dial_code": "+593", "code": "EC"},
  {"name": "Egypt", "dial_code": "+20", "code": "EG"},
  {"name": "El Salvador", "dial_code": "+503", "code": "SV"},
  {"name": "Equatorial Guinea", "dial_code": "+240", "code": "GQ"},
  {"name": "Eritrea", "dial_code": "+291", "code": "ER"},
  {"name": "Estonia", "dial_code": "+372", "code": "EE"},
  {"name": "Ethiopia", "dial_code": "+251", "code": "ET"},
  {"name": "Falkland Islands (Malvinas)", "dial_code": "+500", "code": "FK"},
  {"name": "Faroe Islands", "dial_code": "+298", "code": "FO"},
  {"name": "Fiji", "dial_code": "+679", "code": "FJ"},
  {"name": "Finland", "dial_code": "+358", "code": "FI"},
  {"name": "France", "dial_code": "+33", "code": "FR"},
  {"name": "French Guiana", "dial_code": "+594", "code": "GF"},
  {"name": "French Polynesia", "dial_code": "+689", "code": "PF"},
  {"name": "Gabon", "dial_code": "+241", "code": "GA"},
  {"name": "Gambia", "dial_code": "+220", "code": "GM"},
  {"name": "Georgia", "dial_code": "+995", "code": "GE"},
  {"name": "Germany", "dial_code": "+49", "code": "DE"},
  {"name": "Ghana", "dial_code": "+233", "code": "GH"},
  {"name": "Gibraltar", "dial_code": "+350", "code": "GI"},
  {"name": "Greece", "dial_code": "+30", "code": "GR"},
  {"name": "Greenland", "dial_code": "+299", "code": "GL"},
  {"name": "Grenada", "dial_code": "+1473", "code": "GD"},
  {"name": "Guadeloupe", "dial_code": "+590", "code": "GP"},
  {"name": "Guam", "dial_code": "+1671", "code": "GU"},
  {"name": "Guatemala", "dial_code": "+502", "code": "GT"},
  {"name": "Guernsey", "dial_code": "+44", "code": "GG"},
  {"name": "Guinea", "dial_code": "+224", "code": "GN"},
  {"name": "Guinea-Bissau", "dial_code": "+245", "code": "GW"},
  {"name": "Guyana", "dial_code": "+595", "code": "GY"},
  {"name": "Haiti", "dial_code": "+509", "code": "HT"},
  {"name": "Holy See (Vatican City State)", "dial_code": "+379", "code": "VA"},
  {"name": "Honduras", "dial_code": "+504", "code": "HN"},
  {"name": "Hong Kong", "dial_code": "+852", "code": "HK"},
  {"name": "Hungary", "dial_code": "+36", "code": "HU"},
  {"name": "Iceland", "dial_code": "+354", "code": "IS"},
  {"name": "India", "dial_code": "+91", "code": "IN"},
  {"name": "Indonesia", "dial_code": "+62", "code": "ID"},
  {
    "name": "Iran, Islamic Republic of Persian Gulf",
    "dial_code": "+98",
    "code": "IR"
  },
  {"name": "Iraq", "dial_code": "+964", "code": "IQ"},
  {"name": "Ireland", "dial_code": "+353", "code": "IE"},
  {"name": "Isle of Man", "dial_code": "+44", "code": "IM"},
  {"name": "Israel", "dial_code": "+972", "code": "IL"},
  {"name": "Italy", "dial_code": "+39", "code": "IT"},
  {"name": "Jamaica", "dial_code": "+1876", "code": "JM"},
  {"name": "Japan", "dial_code": "+81", "code": "JP"},
  {"name": "Jersey", "dial_code": "+44", "code": "JE"},
  {"name": "Jordan", "dial_code": "+962", "code": "JO"},
  {"name": "Kazakhstan", "dial_code": "+77", "code": "KZ"},
  {"name": "Kenya", "dial_code": "+254", "code": "KE"},
  {"name": "Kiribati", "dial_code": "+686", "code": "KI"},
  {
    "name": "Korea, Democratic People's Republic of Korea",
    "dial_code": "+850",
    "code": "KP"
  },
  {"name": "Korea, Republic of South Korea", "dial_code": "+82", "code": "KR"},
  {"name": "Kuwait", "dial_code": "+965", "code": "KW"},
  {"name": "Kyrgyzstan", "dial_code": "+996", "code": "KG"},
  {"name": "Laos", "dial_code": "+856", "code": "LA"},
  {"name": "Latvia", "dial_code": "+371", "code": "LV"},
  {"name": "Lebanon", "dial_code": "+961", "code": "LB"},
  {"name": "Lesotho", "dial_code": "+266", "code": "LS"},
  {"name": "Liberia", "dial_code": "+231", "code": "LR"},
  {"name": "Libyan Arab Jamahiriya", "dial_code": "+218", "code": "LY"},
  {"name": "Liechtenstein", "dial_code": "+423", "code": "LI"},
  {"name": "Lithuania", "dial_code": "+370", "code": "LT"},
  {"name": "Luxembourg", "dial_code": "+352", "code": "LU"},
  {"name": "Macao", "dial_code": "+853", "code": "MO"},
  {"name": "Macedonia", "dial_code": "+389", "code": "MK"},
  {"name": "Madagascar", "dial_code": "+261", "code": "MG"},
  {"name": "Malawi", "dial_code": "+265", "code": "MW"},
  {"name": "Malaysia", "dial_code": "+60", "code": "MY"},
  {"name": "Maldives", "dial_code": "+960", "code": "MV"},
  {"name": "Mali", "dial_code": "+223", "code": "ML"},
  {"name": "Malta", "dial_code": "+356", "code": "MT"},
  {"name": "Marshall Islands", "dial_code": "+692", "code": "MH"},
  {"name": "Martinique", "dial_code": "+596", "code": "MQ"},
  {"name": "Mauritania", "dial_code": "+222", "code": "MR"},
  {"name": "Mauritius", "dial_code": "+230", "code": "MU"},
  {"name": "Mayotte", "dial_code": "+262", "code": "YT"},
  {"name": "Mexico", "dial_code": "+52", "code": "MX"},
  {
    "name": "Micronesia, Federated States of Micronesia",
    "dial_code": "+691",
    "code": "FM"
  },
  {"name": "Moldova", "dial_code": "+373", "code": "MD"},
  {"name": "Monaco", "dial_code": "+377", "code": "MC"},
  {"name": "Mongolia", "dial_code": "+976", "code": "MN"},
  {"name": "Montenegro", "dial_code": "+382", "code": "ME"},
  {"name": "Montserrat", "dial_code": "+1664", "code": "MS"},
  {"name": "Morocco", "dial_code": "+212", "code": "MA"},
  {"name": "Mozambique", "dial_code": "+258", "code": "MZ"},
  {"name": "Myanmar", "dial_code": "+95", "code": "MM"},
  {"name": "Namibia", "dial_code": "+264", "code": "NA"},
  {"name": "Nauru", "dial_code": "+674", "code": "NR"},
  {"name": "Nepal", "dial_code": "+977", "code": "NP"},
  {"name": "Netherlands", "dial_code": "+31", "code": "NL"},
  {"name": "Netherlands Antilles", "dial_code": "+599", "code": "AN"},
  {"name": "New Caledonia", "dial_code": "+687", "code": "NC"},
  {"name": "New Zealand", "dial_code": "+64", "code": "NZ"},
  {"name": "Nicaragua", "dial_code": "+505", "code": "NI"},
  {"name": "Niger", "dial_code": "+227", "code": "NE"},
  {"name": "Nigeria", "dial_code": "+234", "code": "NG"},
  {"name": "Niue", "dial_code": "+683", "code": "NU"},
  {"name": "Norfolk Island", "dial_code": "+672", "code": "NF"},
  {"name": "Northern Mariana Islands", "dial_code": "+1670", "code": "MP"},
  {"name": "Norway", "dial_code": "+47", "code": "NO"},
  {"name": "Oman", "dial_code": "+968", "code": "OM"},
  {"name": "Pakistan", "dial_code": "+92", "code": "PK"},
  {"name": "Palau", "dial_code": "+680", "code": "PW"},
  {
    "name": "Palestinian Territory, Occupied",
    "dial_code": "+970",
    "code": "PS"
  },
  {"name": "Panama", "dial_code": "+507", "code": "PA"},
  {"name": "Papua New Guinea", "dial_code": "+675", "code": "PG"},
  {"name": "Paraguay", "dial_code": "+595", "code": "PY"},
  {"name": "Peru", "dial_code": "+51", "code": "PE"},
  {"name": "Philippines", "dial_code": "+63", "code": "PH"},
  {"name": "Pitcairn", "dial_code": "+872", "code": "PN"},
  {"name": "Poland", "dial_code": "+48", "code": "PL"},
  {"name": "Portugal", "dial_code": "+351", "code": "PT"},
  {"name": "Puerto Rico", "dial_code": "+1939", "code": "PR"},
  {"name": "Qatar", "dial_code": "+974", "code": "QA"},
  {"name": "Romania", "dial_code": "+40", "code": "RO"},
  {"name": "Russia", "dial_code": "+7", "code": "RU"},
  {"name": "Rwanda", "dial_code": "+250", "code": "RW"},
  {"name": "Reunion", "dial_code": "+262", "code": "RE"},
  {"name": "Saint Barthelemy", "dial_code": "+590", "code": "BL"},
  {
    "name": "Saint Helena, Ascension and Tristan Da Cunha",
    "dial_code": "+290",
    "code": "SH"
  },
  {"name": "Saint Kitts and Nevis", "dial_code": "+1869", "code": "KN"},
  {"name": "Saint Lucia", "dial_code": "+1758", "code": "LC"},
  {"name": "Saint Martin", "dial_code": "+590", "code": "MF"},
  {"name": "Saint Pierre and Miquelon", "dial_code": "+508", "code": "PM"},
  {
    "name": "Saint Vincent and the Grenadines",
    "dial_code": "+1784",
    "code": "VC"
  },
  {"name": "Samoa", "dial_code": "+685", "code": "WS"},
  {"name": "San Marino", "dial_code": "+378", "code": "SM"},
  {"name": "Sao Tome and Principe", "dial_code": "+239", "code": "ST"},
  {"name": "Saudi Arabia", "dial_code": "+966", "code": "SA"},
  {"name": "Senegal", "dial_code": "+221", "code": "SN"},
  {"name": "Serbia", "dial_code": "+381", "code": "RS"},
  {"name": "Seychelles", "dial_code": "+248", "code": "SC"},
  {"name": "Sierra Leone", "dial_code": "+232", "code": "SL"},
  {"name": "Singapore", "dial_code": "+65", "code": "SG"},
  {"name": "Slovakia", "dial_code": "+421", "code": "SK"},
  {"name": "Slovenia", "dial_code": "+386", "code": "SI"},
  {"name": "Solomon Islands", "dial_code": "+677", "code": "SB"},
  {"name": "Somalia", "dial_code": "+252", "code": "SO"},
  {"name": "South Africa", "dial_code": "+27", "code": "ZA"},
  {"name": "South Sudan", "dial_code": "+211", "code": "SS"},
  {
    "name": "South Georgia and the South Sandwich Islands",
    "dial_code": "+500",
    "code": "GS"
  },
  {"name": "Spain", "dial_code": "+34", "code": "ES"},
  {"name": "Sri Lanka", "dial_code": "+94", "code": "LK"},
  {"name": "Sudan", "dial_code": "+249", "code": "SD"},
  {"name": "Suriname", "dial_code": "+597", "code": "SR"},
  {"name": "Svalbard and Jan Mayen", "dial_code": "+47", "code": "SJ"},
  {"name": "Swaziland", "dial_code": "+268", "code": "SZ"},
  {"name": "Sweden", "dial_code": "+46", "code": "SE"},
  {"name": "Switzerland", "dial_code": "+41", "code": "CH"},
  {"name": "Syrian Arab Republic", "dial_code": "+963", "code": "SY"},
  {"name": "Taiwan", "dial_code": "+886", "code": "TW"},
  {"name": "Tajikistan", "dial_code": "+992", "code": "TJ"},
  {
    "name": "Tanzania, United Republic of Tanzania",
    "dial_code": "+255",
    "code": "TZ"
  },
  {"name": "Thailand", "dial_code": "+66", "code": "TH"},
  {"name": "Timor-Leste", "dial_code": "+670", "code": "TL"},
  {"name": "Togo", "dial_code": "+228", "code": "TG"},
  {"name": "Tokelau", "dial_code": "+690", "code": "TK"},
  {"name": "Tonga", "dial_code": "+676", "code": "TO"},
  {"name": "Trinidad and Tobago", "dial_code": "+1868", "code": "TT"},
  {"name": "Tunisia", "dial_code": "+216", "code": "TN"},
  {"name": "Turkey", "dial_code": "+90", "code": "TR"},
  {"name": "Turkmenistan", "dial_code": "+993", "code": "TM"},
  {"name": "Turks and Caicos Islands", "dial_code": "+1649", "code": "TC"},
  {"name": "Tuvalu", "dial_code": "+688", "code": "TV"},
  {"name": "Uganda", "dial_code": "+256", "code": "UG"},
  {"name": "Ukraine", "dial_code": "+380", "code": "UA"},
  {"name": "United Arab Emirates", "dial_code": "+971", "code": "AE"},
  {"name": "United Kingdom", "dial_code": "+44", "code": "GB"},
  {"name": "United States", "dial_code": "+1", "code": "US"},
  {"name": "Uruguay", "dial_code": "+598", "code": "UY"},
  {"name": "Uzbekistan", "dial_code": "+998", "code": "UZ"},
  {"name": "Vanuatu", "dial_code": "+678", "code": "VU"},
  {
    "name": "Venezuela, Bolivarian Republic of Venezuela",
    "dial_code": "+58",
    "code": "VE"
  },
  {"name": "Vietnam", "dial_code": "+84", "code": "VN"},
  {"name": "Virgin Islands, British", "dial_code": "+1284", "code": "VG"},
  {"name": "Virgin Islands, U.S.", "dial_code": "+1340", "code": "VI"},
  {"name": "Wallis and Futuna", "dial_code": "+681", "code": "WF"},
  {"name": "Yemen", "dial_code": "+967", "code": "YE"},
  {"name": "Zambia", "dial_code": "+260", "code": "ZM"},
  {"name": "Zimbabwe", "dial_code": "+263", "code": "ZW"}
];
