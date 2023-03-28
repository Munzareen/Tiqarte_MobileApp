import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/strings.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: kSecondBackgroundColor,
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
                            language,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
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
                                suggested,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              18.verticalSpace,
                              customRadioButton(1, "English (US)"),
                              18.verticalSpace,
                              customRadioButton(2, "English (UK)"),
                              10.verticalSpace,
                              Divider(),
                              10.verticalSpace,
                              Text(
                                language,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              18.verticalSpace,
                              customRadioButton(3, "Mandarin"),
                              18.verticalSpace,
                              customRadioButton(4, "Hindi"),
                              18.verticalSpace,
                              customRadioButton(5, "Spanish"),
                              18.verticalSpace,
                              customRadioButton(6, "French"),
                              18.verticalSpace,
                              customRadioButton(7, "Arabic"),
                              18.verticalSpace,
                              customRadioButton(8, "Bengali"),
                              18.verticalSpace,
                              customRadioButton(9, "Russian"),
                              18.verticalSpace,
                              customRadioButton(10, "Indonesia"),
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
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      value: value,
      groupValue: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value!;
        });
      },
    );
  }
}
