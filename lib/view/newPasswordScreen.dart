import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/LoginScreen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  const NewPasswordScreen({super.key, required this.email});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool visiblePass = true;
  bool visibleConfirmPass = true;

  bool isRemeber = false;
  // Color _filledColorPass = kDisabledColor.withOpacity(0.4);
  // Color _filledColorConfirmPassword = kDisabledColor.withOpacity(0.4);
  Color _iconColorPass = kDisabledColor;
  Color _iconColorConfirmPassword = kDisabledColor;

  @override
  void initState() {
    super.initState();
    _confirmPasswordFocusNode.addListener(() {
      if (_confirmPasswordFocusNode.hasFocus) {
        setState(() {
          //     _filledColorConfirmPassword = kPrimaryColor.withOpacity(0.2);
          _iconColorConfirmPassword = kPrimaryColor;
        });
      } else {
        setState(() {
          //    _filledColorConfirmPassword = kDisabledColor.withOpacity(0.4);
          _iconColorConfirmPassword = kDisabledColor;
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() {
          //   _filledColorPass = kPrimaryColor.withOpacity(0.2);

          _iconColorPass = kPrimaryColor;
        });
      } else {
        setState(() {
          //    _filledColorPass = kDisabledColor.withOpacity(0.4);
          _iconColorPass = kDisabledColor;
        });
      }
    });
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordFocusNode.dispose();
    _passwordFocusNode.dispose();
    _formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //  backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          //   backgroundColor: kSecondBackgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            'createNewPassword'.tr,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  40.verticalSpace,
                  Image.asset(
                    newPasswordLogo,
                    height: 200,
                  ),
                  40.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'createYourNewPassword'.tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: visiblePass,
                            focusNode: _passwordFocusNode,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'enterNewPassword'.tr;
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
                                // fillColor: _filledColorPass,
                                filled: true,
                                hintText: 'enterNewPassword'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [],
                          ),
                          20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.text,
                            obscureText: visibleConfirmPass,
                            focusNode: _confirmPasswordFocusNode,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'confirmPassword'.tr;
                              } else if (_passwordController.text.trim() !=
                                  _confirmPasswordController.text.trim()) {
                                return "passwordsDoNotMatch".tr;
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: 20,
                                  color: _iconColorConfirmPassword,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visibleConfirmPass =
                                            !visibleConfirmPass;
                                      });
                                    },
                                    color: _iconColorConfirmPassword,
                                    icon: visibleConfirmPass
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: _iconColorConfirmPassword,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: _iconColorConfirmPassword,
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
                                // fillColor: _filledColorConfirmPassword,
                                filled: true,
                                hintText: 'confirmPassword'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [],
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
                          prefs?.setString("rememberMeEmail", widget.email);
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
                          "email": widget.email,
                          "password": _passwordController.text.trim()
                        };

                        ApiService().changePassword(context, data);
                      }
                    },
                    child: customButton('continueButton'.tr, kPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
