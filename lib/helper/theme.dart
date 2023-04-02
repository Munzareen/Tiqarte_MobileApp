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
            onPrimary: kPrimaryColor,
            secondary: kPrimaryColor,
            onSecondary: kPrimaryColor,
            error: Colors.red,
            onError: Colors.red,
            background: Color(0xff1F222A),
            onBackground: Color(0xff1F222A),
            surface: Colors.white,
            onSurface: Colors.white),

        //--for text field--

        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xff1F222A),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.white,
          //     width: 2.0,
          //   ),
          // ),
        ),
        // colorScheme: ColorScheme.dark(primaryContainer: Colors.white),
        appBarTheme: AppBarTheme(
            color: Colors.black, // Color(0xff1F222A),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: Color(0xff1F222A))),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: GoogleFonts.urbanistTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        secondaryHeaderColor: Color(0xff1F222A),
        scaffoldBackgroundColor: Colors.black); //Color(0xff1F222A));
  }

  ThemeData lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
            brightness: Brightness.light,
            primary: kPrimaryColor,
            onPrimary: kPrimaryColor,
            secondary: kPrimaryColor,
            onSecondary: kPrimaryColor,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.white,
            onBackground: Colors.white,
            surface: Color(0xff1F222A),
            onSurface: Color(0xff1F222A)),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: kDisabledColor.withOpacity(0.3),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.white,
          //     width: 2.0,
          //   ),
          // ),
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
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        secondaryHeaderColor: Colors.white,
        scaffoldBackgroundColor: kSecondBackgroundColor);
  }
}
