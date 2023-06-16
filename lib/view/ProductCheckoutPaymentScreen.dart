import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/AddCardScreen.dart';
import 'package:tiqarte/view/MainScreen.dart';
import 'package:tiqarte/view/SeeAllProductsScreen.dart';

class ProductCheckoutPaymentScreen extends StatefulWidget {
  const ProductCheckoutPaymentScreen({super.key});

  @override
  State<ProductCheckoutPaymentScreen> createState() =>
      _ProductCheckoutPaymentScreenState();
}

class _ProductCheckoutPaymentScreenState
    extends State<ProductCheckoutPaymentScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back)),
                    10.horizontalSpace,
                    Text(
                      checkout,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              Container(
                padding: EdgeInsets.all(16.0),
                color: kDisabledColor.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customCardImage(tshirtImage, 90.h, 120.h),
                      8.horizontalSpace,
                      SizedBox(
                        width: 0.35.sw,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "White Last Team Standing .......",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              "Classic pullover t-shirt",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              size + ": XL",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "€20.00",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        20.verticalSpace,
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
                        GestureDetector(
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
                        100.verticalSpace
                      ],
                    ),
                  ),
                ),
              )
            ],
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
                        congratulations,
                        placeOrderSuccess,
                        shopMore,
                        cancel, () {
                      Get.back();
                      Get.off(() => SeeAllProductsScreen(),
                          transition: Transition.cupertinoDialog);
                    }, () {
                      Get.back();
                      Get.offAll(() => MainScreen(),
                          transition: Transition.cupertinoDialog);
                    });
                  },
                  child: customButton(done, kPrimaryColor))),
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
