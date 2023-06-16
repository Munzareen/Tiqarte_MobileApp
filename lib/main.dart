import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/theme.dart';
import 'package:tiqarte/view/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await inititializeFlutterDownloader();

  await initializePrefs();
  isDarkTheme.value = prefs?.getBool("themeMode") ?? false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme().lightTheme(context),
        darkTheme: MyTheme().darkTheme(context),
        themeMode: isDarkTheme.value == true ? ThemeMode.dark : ThemeMode.light,
        home: SplashScreen(),
      );
    });
  }
}
