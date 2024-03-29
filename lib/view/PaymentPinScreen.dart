import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/MainScreen.dart';
import 'package:tiqarte/view/ViewETicketScreen.dart';

class PaymentPinScreen extends StatefulWidget {
  const PaymentPinScreen({super.key});

  @override
  State<PaymentPinScreen> createState() => _PaymentPinScreenState();
}

class _PaymentPinScreenState extends State<PaymentPinScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //  backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          //  backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back)),
                    10.horizontalSpace,
                    Text(
                      'enterYourPin'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.2.sh,
                ),
                Text(
                  'enterYourPinToConfirm'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                50.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    textStyle: const TextStyle(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    length: 4,
                    obscureText: true,
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
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            width: 1.sw,
            color: Theme.of(context).secondaryHeaderColor,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: GestureDetector(
                  onTap: () {
                    customAlertDialogWithTwoButtons(
                        context,
                        backgroundLogo,
                        Icons.verified_user_sharp,
                        'congratulations'.tr,
                        'successPlaceOrderEvent'.tr,
                        'viewETicket'.tr,
                        'cancel'.tr, () {
                      Get.back();
                      Get.to(() => ViewETicketScreen(ticketUniqueNumber: ''),
                          transition: Transition.cupertinoDialog);
                    }, () {
                      Get.back();
                      Get.offAll(() => MainScreen(),
                          transition: Transition.cupertinoDialog);
                    });
                  },
                  child: customButton('continueButton'.tr, kPrimaryColor),
                ))),
      ),
    );
  }
}
