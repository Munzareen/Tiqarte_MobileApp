import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiqarte/helper/colors.dart';

class MyTheme {
  ThemeData darkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
            brightness: Brightness.dark,
            primary: kPrimaryColor,
            onPrimary: Colors.white,
            secondary: Color(0xff1F222A), //for drop down Menu
            onSecondary: Color(0xff1F222A), //for drop down field
            error: Colors.red,
            onError: Colors.red,
            background: Colors
                .white, //for swap (if dark then white if light then black)
            onBackground: Color(0xff1F222A),
            surface: Color(0xff1F222A),
            onSurface: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xff1F222A),
        ),
        appBarTheme: AppBarTheme(
            color: Colors.black,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: Color(0xff1F222A))),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: GoogleFonts.urbanistTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
        indicatorColor: Colors.white,
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        secondaryHeaderColor: Color(0xff1F222A),
        scaffoldBackgroundColor: Colors.black);
  }

  ThemeData lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
            brightness: Brightness.light,
            primary: kPrimaryColor,
            onPrimary: Colors.white,
            secondary: kDisabledColor, //for drop down Menu
            onSecondary: kDisabledColor.withOpacity(0.4), //for drop down field
            error: Colors.red,
            onError: Colors.red,
            background: Colors
                .black, //for swap (if dark then white if light then black)
            onBackground: Colors.white,
            surface: kPrimaryColor,
            onSurface: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: kDisabledColor.withOpacity(0.3),
        ),
        appBarTheme: AppBarTheme(
            color: kSecondBackgroundColor,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarColor: kBackgroundColor)),
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: GoogleFonts.urbanistTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.black)),
        indicatorColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        secondaryHeaderColor: Colors.white,
        scaffoldBackgroundColor: kSecondBackgroundColor);
  }
}
