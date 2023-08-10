import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiqarte/controller/otpVerificationController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/view/NewPasswordScreen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final otpVerificationController = Get.put(OtpVerificationController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //  backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          //    backgroundColor: kSecondBackgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            'otpCodeVerification'.tr,
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
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'codeHasBeenSendTo'.tr + "andrew_ainsley@yourdomain.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                50.verticalSpace,
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  textStyle: const TextStyle(color: Colors.black),

                  cursorColor: kPrimaryColor,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,

                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderWidth: 1,
                      borderRadius: BorderRadius.circular(15),
                      fieldHeight: 55,
                      fieldWidth: 70,
                      activeFillColor: kOtpFieldDisableColor,
                      activeColor: kOtpFieldDisableColor,
                      disabledColor: kDisabledColor,
                      selectedFillColor: kPrimaryColor.withOpacity(0.2),
                      inactiveColor: kDisabledColor.withOpacity(0.3),
                      selectedColor: kPrimaryColor,
                      inactiveFillColor: kOtpFieldDisableColor,
                      errorBorderColor: Colors.transparent),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  //   errorAnimationController: errorController,
                  //  controller: _pinController,
                  onCompleted: (v) {},
                  onChanged: (value) {
                    // setState(() {
                    // });
                  },
                  beforeTextPaste: (text) {
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                30.verticalSpace,
                Obx(
                  () => otpVerificationController.time.value == '01'
                      ? GestureDetector(
                          onTap: () {
                            otpVerificationController.startTimer(59);
                          },
                          child: Text(
                            'resend'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        )
                      : RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'resendCodeIn'.tr,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background)),
                            TextSpan(
                                text: otpVerificationController.time.value
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: kPrimaryColor)),
                            TextSpan(
                                text: ' s',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background))
                          ]),
                        ),
                ),
                50.verticalSpace,
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.to(() => NewPasswordScreen(),
                transition: Transition.rightToLeft);
          },
          child: customButton('verify'.tr, kPrimaryColor),
        ),
      ),
    );
  }
}
