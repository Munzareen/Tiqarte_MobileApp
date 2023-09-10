import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _selectedValue = 1;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    if (prefs == null) {
      await initializePrefs();
    }
    _selectedValue = prefs?.getInt("languageValue") ?? 1;
    language = prefs?.getString("language") ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //    backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          //    backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            height: 1.sh,
            width: 1.sw,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      18.verticalSpace,
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back)),
                          18.horizontalSpace,
                          Text(
                            'language'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      30.verticalSpace,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'suggested'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              18.verticalSpace,
                              customRadioButton(1, "English (US)"),
                              18.verticalSpace,
                              customRadioButton(2, "Spanish"),
                              10.verticalSpace,
                              Divider(),
                              10.verticalSpace,
                              Text(
                                'language'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              18.verticalSpace,
                              customRadioButton(3, "German"),
                              18.verticalSpace,
                              customRadioButton(4, "French"),
                              18.verticalSpace,
                              customRadioButton(5, "Italian"),
                              18.verticalSpace,
                              customRadioButton(6, "Catalan"),
                              18.verticalSpace,
                              customRadioButton(7, "Basque"),
                              18.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ]))));
  }

  customRadioButton(int value, String name) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      dense: true,
      contentPadding: EdgeInsets.zero,
      activeColor: kPrimaryColor,
      title: Text(
        name,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      value: value,
      groupValue: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value!;
        });
        if (_selectedValue == 1) {
          var locale = Locale('en', 'US');
          Get.updateLocale(locale);
          language = 'en';
          prefs?.setString("language", "en");
          prefs?.setInt("languageValue", _selectedValue);
        } else if (_selectedValue == 2) {
          var locale = Locale('es');
          Get.updateLocale(locale);
          language = 'es';
          prefs?.setString("language", "es");
          prefs?.setInt("languageValue", _selectedValue);
        } else if (_selectedValue == 3) {
          var locale = Locale('de');
          Get.updateLocale(locale);
          language = 'de';
          prefs?.setString("language", "de");
          prefs?.setInt("languageValue", _selectedValue);
        } else if (_selectedValue == 4) {
          var locale = Locale('fr');
          Get.updateLocale(locale);
          language = 'fr';
          prefs?.setString("language", "fr");
          prefs?.setInt("languageValue", _selectedValue);
        } else if (_selectedValue == 5) {
          var locale = Locale('it');
          Get.updateLocale(locale);
          language = 'it';
          prefs?.setString("language", "it");
          prefs?.setInt("languageValue", _selectedValue);
        } else if (_selectedValue == 6) {
          var locale = Locale('ca');
          Get.updateLocale(locale);
          language = 'ca';
          prefs?.setString("language", "ca");
          prefs?.setInt("languageValue", _selectedValue);
        } else if (_selectedValue == 7) {
          var locale = Locale('eu');
          Get.updateLocale(locale);
          language = 'eu';
          prefs?.setString("language", "eu");
          prefs?.setInt("languageValue", _selectedValue);
        }
      },
    );
  }
}
