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
