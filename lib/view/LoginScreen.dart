import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/CreateAccountScreen.dart';
import 'package:tiqarte/view/ForgotPasswordScreen.dart';
import 'package:tiqarte/view/ForgotPasswordScreenOld.dart';
import 'package:tiqarte/view/MainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool visiblePass = true;
  bool rememberMe = false;
  Color _filledColorPass = kDisabledColor.withOpacity(0.4);
  Color _filledColorEmail = kDisabledColor.withOpacity(0.4);
  Color _iconColorPass = Colors.grey;
  Color _iconColorEmail = Colors.grey;

  @override
  void initState() {
    super.initState();
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

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() {
          _filledColorPass = kPrimaryColor.withOpacity(0.2);

          _iconColorPass = kPrimaryColor;
        });
      } else {
        setState(() {
          _filledColorPass = kDisabledColor.withOpacity(0.4);
          _iconColorPass = Colors.grey;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

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
          width: 1.sw,
          height: 1.sh,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  40.verticalSpace,
                  Image.asset(
                    appLogo,
                    height: 60.h,
                  ),
                  40.verticalSpace,
                  Text(
                    LoginHeadingString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  40.verticalSpace,
                  Form(
                      //     key: _formKey,
                      child: Column(
                    children: [
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            disabledBorder: customOutlineBorder,
                            fillColor: _filledColorEmail,
                            filled: true,
                            hintText: LoginEmailString,
                            hintStyle: TextStyle(
                                color: Color(0xff9E9E9E), fontSize: 14)),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(textRegExp),
                        ],
                      ),
                      20.verticalSpace,
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: _passwordController,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        obscureText: visiblePass,
                        focusNode: _passwordFocusNode,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please enter your username';
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 20,
                              color: _iconColorPass,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visiblePass = !visiblePass;
                                  });
                                },
                                color: _iconColorPass,
                                icon: visiblePass
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: _iconColorPass,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: _iconColorPass,
                                      )),
                            errorBorder: customOutlineBorder,
                            enabledBorder: customOutlineBorder,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            disabledBorder: customOutlineBorder,
                            fillColor: _filledColorPass,
                            filled: true,
                            hintText: LoginPasswordString,
                            hintStyle: TextStyle(
                                color: Color(0xff9E9E9E), fontSize: 14)),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(textRegExp),
                        ],
                      ),
                    ],
                  )),
                  10.verticalSpace,
                  Container(
                    width: 200,
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: kPrimaryColor,
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      side: BorderSide(color: kPrimaryColor, width: 2.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        LoginRememberMeString,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Colors.white,
                      dense: false,
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                  ),
                  10.verticalSpace,
                  InkWell(
                    onTap: () {
                      Get.to(() => MainScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: customButton(LoginSignInString, kPrimaryColor),
                  ),
                  10.verticalSpace,
                  TextButton(
                    child: Text(LoginForgotPasswordString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor)),
                    onPressed: () {
                      Get.to(() => ForgotPasswordScreen(),
                          transition: Transition.rightToLeft);
                    },
                  ),
                  10.verticalSpace,
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(children: <Widget>[
                        Expanded(child: Divider()),
                        10.horizontalSpace,
                        Text(
                          LoginOrContinueWithString,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff616161)),
                        ),
                        10.horizontalSpace,
                        Expanded(child: Divider()),
                      ])),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LoginDontHaveAccountString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: kDisabledColor),
                      ),
                      10.horizontalSpace,
                      TextButton(
                        child: Text(LoginSignUpString,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor)),
                        onPressed: () {
                          Get.to(() => CreateAccountScreen(),
                              transition: Transition.rightToLeft);
                        },
                      ),
                    ],
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  customTextField(String hintText, TextEditingController controller,
      Pattern regExpPattern) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            size: 20,
          ),
          suffixIcon: Icon(Icons.visibility),
          errorBorder: customOutlineBorder,
          enabledBorder: customOutlineBorder,
          focusedBorder: customOutlineBorder,
          disabledBorder: customOutlineBorder,
          fillColor: kDisabledColor.withOpacity(0.4),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 14)),
      inputFormatters: [
        FilteringTextInputFormatter.allow(regExpPattern),
      ],
    );
  }
}
