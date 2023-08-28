import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/OtpVerificationScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  Color _filledColorEmail = kDisabledColor.withOpacity(0.4);
  Color _iconColorEmail = Colors.grey;

  @override
  void initState() {
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() {
          _filledColorEmail = kPrimaryColor.withOpacity(0.2);
          _iconColorEmail = kPrimaryColor;
        });
      } else {
        setState(() {
          _filledColorEmail = kDisabledColor.withOpacity(0.4);
          _iconColorEmail = Colors.grey;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kSecondBackgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            'forgotPassword'.tr,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.25.sh,
                ),
                Text(
                  "Enter Your Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                30.verticalSpace,
                TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.text,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        emailIcon,
                        color: _iconColorEmail,
                      ),
                      errorBorder: customOutlineBorder,
                      enabledBorder: customOutlineBorder,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: kPrimaryColor)),
                      disabledBorder: customOutlineBorder,
                      fillColor: _filledColorEmail,
                      filled: true,
                      hintText: 'email'.tr,
                      hintStyle:
                          TextStyle(color: Color(0xff9E9E9E), fontSize: 14)),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(textRegExp),
                  ],
                ),
                50.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Get.to(
                        () => OtpVerificationScreen(
                            email: _emailController.text.trim()),
                        transition: Transition.rightToLeft);
                  },
                  child: customButton('continueButton'.tr, kPrimaryColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
