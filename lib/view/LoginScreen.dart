import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/CreateAccountScreen.dart';
import 'package:tiqarte/view/ForgotPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool visiblePass = true;
  bool isRemeber = false;
  // Color _filledColorPass = kDisabledColor.withOpacity(0.4);
  // Color _filledColorEmail = kDisabledColor.withOpacity(0.4);
  Color _iconColorPass = Colors.grey;
  Color _iconColorEmail = Colors.grey;

  @override
  void initState() {
    super.initState();

    getPrefs();
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() {
          //_filledColorEmail = kPrimaryColor.withOpacity(0.2);
          _iconColorEmail = kPrimaryColor;
        });
      } else {
        setState(() {
          //_filledColorEmail = kDisabledColor.withOpacity(0.4);
          _iconColorEmail = Colors.grey;
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() {
          // _filledColorPass = kPrimaryColor.withOpacity(0.2);

          _iconColorPass = kPrimaryColor;
        });
      } else {
        setState(() {
          //_filledColorPass = kDisabledColor.withOpacity(0.4);
          _iconColorPass = Colors.grey;
        });
      }
    });
  }

  getPrefs() async {
    if (prefs == null) {
      await initializePrefs();
    }

    _emailController.text = prefs?.getString("rememberMeEmail") ?? '';
    _passwordController.text = prefs?.getString("rememberMePassword") ?? '';
    if (_emailController.text.trim().isNotEmpty) isRemeber = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    prefs;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //   backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          //   backgroundColor: kSecondBackgroundColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
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
                    'logIntoYourAccount'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  40.verticalSpace,
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _emailController,
                            keyboardType: TextInputType.text,
                            focusNode: _emailFocusNode,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'pleaseEnterEmail'.tr;
                              } else if (!value.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                return 'pleaseEnterValidEmail'.tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                  emailIcon,
                                  color: _iconColorEmail,
                                ),
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                //  fillColor: _filledColorEmail,
                                filled: true,
                                hintText: 'email'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                          ),
                          20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: visiblePass,
                            focusNode: _passwordFocusNode,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'pleaseEnterPassword'.tr;
                              }
                              return null;
                            },
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
                                focusedErrorBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                //  fillColor: _filledColorPass,
                                filled: true,
                                hintText: 'password'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
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
                        'rememberMe'.tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Colors.white,
                      dense: false,
                      value: isRemeber,
                      onChanged: (value) {
                        setState(() {
                          isRemeber = value!;
                        });
                      },
                    ),
                  ),
                  10.verticalSpace,
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (isRemeber) {
                          prefs == null ? await initializePrefs() : null;
                          prefs?.setString(
                              "rememberMeEmail", _emailController.text.trim());
                          prefs?.setString("rememberMePassword",
                              _passwordController.text.trim());
                        } else {
                          if (!isRemeber) {
                            prefs == null ? await initializePrefs() : null;
                            prefs?.setString("rememberMeEmail", '');
                            prefs?.setString("rememberMePassword", '');
                          }
                        }
                        var data = {
                          "email": _emailController.text.trim(),
                          "password": _passwordController.text.trim()
                        };
                        ApiService().login(context, data);
                      }
                    },
                    child: customButton('signIn'.tr, kPrimaryColor),
                  ),
                  10.verticalSpace,
                  TextButton(
                    child: Text('forgotThePassword'.tr,
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
                        Expanded(
                            child: Divider(
                          color: kDisabledColor,
                        )),
                        10.horizontalSpace,
                        Text(
                          'orContinueWith'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff616161)),
                        ),
                        10.horizontalSpace,
                        Expanded(
                            child: Divider(
                          color: kDisabledColor,
                        )),
                      ])),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'dontHaveAccount'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                      10.horizontalSpace,
                      TextButton(
                        child: Text('signUp'.tr,
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
