import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/AddCardScreen.dart';
import 'package:tiqarte/view/ReviewSummaryScreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedValue = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: kSecondBackgroundColor,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back)),
                        10.horizontalSpace,
                        Text(
                          payments,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      scanIcon,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ],
                ),
                20.verticalSpace,
                SingleChildScrollView(
                  child: Column(
                    children: [
                      FittedBox(
                        child: Text(
                          selectThePaymentMethod,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      40.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: customRadioButton(1, paypalIcon, payPal),
                      ),
                      20.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: customRadioButton(2, googleIcon, googlePay),
                      ),
                      20.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: customRadioButton(3, appleIcon, applePay),
                      ),
                      20.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: customRadioButton(
                            4, cardLogo, "•••• •••• •••• •••• 4679"),
                      ),
                      20.verticalSpace,
                      InkWell(
                        onTap: () {
                          Get.to(() => AddCardScreen(),
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          width: 0.9.sw,
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.0)),
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: Text(addNewCard,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
              child: InkWell(
                  onTap: () {
                    Get.to(() => ReviewSummaryScreen(),
                        transition: Transition.rightToLeft);
                  },
                  child: customButton(continueButton, kPrimaryColor))),
        ));
  }

  customRadioButton(int value, String img, String name) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      dense: true,
      contentPadding: EdgeInsets.zero,
      activeColor: kPrimaryColor,
      title: Row(
        children: [
          Image.asset(img),
          15.horizontalSpace,
          Text(
            name,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
