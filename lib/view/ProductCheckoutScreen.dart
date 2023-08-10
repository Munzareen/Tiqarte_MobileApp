import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tiqarte/controller/myBasketController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';

class ProductCheckoutScreen extends StatefulWidget {
  const ProductCheckoutScreen({super.key});

  @override
  State<ProductCheckoutScreen> createState() => _ProductCheckoutScreenState();
}

class _ProductCheckoutScreenState extends State<ProductCheckoutScreen> {
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();

  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String? phoneNumber;
  final _emailFocusNode = FocusNode();

  MyBasketController _myBasketController = Get.find();
  final _formKey = GlobalKey<FormState>();

  // Color _filledColorEmail = kDisabledColor.withOpacity(0.4);
  // Color _filledColorFullName = kDisabledColor.withOpacity(0.4);

  Color _iconColorEmail = Colors.grey;

  @override
  void initState() {
    _fullNameController.text = userName;
    _emailController.text = userEmail;
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() {
          // _filledColorEmail = kPrimaryColor.withOpacity(0.2);
          _iconColorEmail = kPrimaryColor;
        });
      } else {
        setState(() {
          //_filledColorEmail = kDisabledColor.withOpacity(0.4);
          _iconColorEmail = Colors.grey;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            height: 1.sh,
            width: 1.sw,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              20.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back)),
                    10.horizontalSpace,
                    Text(
                      'checkout'.tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              15.verticalSpace,
              Container(
                  width: 1.sw,
                  padding: EdgeInsets.all(16.0),
                  color: kDisabledColor.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${'totalItem'.tr} : ${_myBasketController.myBasketProductsModel!.length.toString()}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${'totalAmount'.tr} : ${_myBasketController.subTotalPrice.toString()}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
              // Container(
              //   padding: EdgeInsets.all(16.0),
              //   color: kDisabledColor.withOpacity(0.4),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //     child: Row(
              //       // mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         customCardImage(tshirtImage, 90.h, 120.h),
              //         8.horizontalSpace,
              //         SizedBox(
              //           width: 0.35.sw,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "White Last Team Standing .......",
              //                 textAlign: TextAlign.start,
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 2,
              //                 style: TextStyle(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               8.verticalSpace,
              //               Text(
              //                 "Classic pullover t-shirt",
              //                 textAlign: TextAlign.start,
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1,
              //                 style: TextStyle(
              //                   color: Colors.grey,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //               8.verticalSpace,
              //               Text(
              //                 size + ": XL",
              //                 textAlign: TextAlign.start,
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1,
              //                 style: TextStyle(
              //                   color: Colors.grey,
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         Text(
              //           "€20.00",
              //           textAlign: TextAlign.start,
              //           style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //               color: kPrimaryColor),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              15.verticalSpace,
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'contactDetail'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              15.verticalSpace,
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _fullNameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter full name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,
                                // fillColor: _filledColorFullName,
                                filled: true,
                                hintText: 'fullName'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(textRegExp),
                            ],
                          ),
                          20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _emailController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email address';
                              }
                              return null;
                            },
                            focusNode: _emailFocusNode,
                            decoration: InputDecoration(
                                suffixIcon: Image.asset(
                                  emailIcon,
                                  color: _iconColorEmail,
                                ),
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,

                                // fillColor: _filledColorEmail,
                                filled: true,
                                hintText: 'email'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(textRegExp),
                            ],
                          ),
                          20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _countryController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter country';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,

                                // fillColor: _filledColorFullName,
                                filled: true,
                                hintText: 'country'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(textRegExp),
                            ],
                          ),
                          20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _stateController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter state';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,

                                // fillColor: _filledColorFullName,
                                filled: true,
                                hintText: 'state'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(textRegExp),
                            ],
                          ),
                          20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _postalCodeController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter postal code';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,

                                // fillColor: _filledColorFullName,
                                filled: true,
                                hintText: 'postalCode'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(numberRegExp),
                            ],
                          ),
                          20.verticalSpace,
                          IntlPhoneField(
                            flagsButtonPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            showDropdownIcon: false,
                            showCountryFlag: true, //showFlag
                            validator: (value) {
                              if (value!.number.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            style: const TextStyle(letterSpacing: 3),
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.disabled,
                            dropdownTextStyle: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                            decoration: InputDecoration(
                                hintText: '000 000 000',
                                hintStyle: TextStyle(color: Colors.grey),
                                // fillColor: _filledColorPhone,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,
                                errorBorder: customOutlineBorder,
                                border: customOutlineBorder),
                            initialCountryCode: 'US',
                            onChanged: (phone) {
                              phoneNumber = phone.countryCode + phone.number;
                            },
                          ),
                          20.verticalSpace,
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                customSnackBar(
                                    'alert'.tr, "Its under development");
                                // Get.to(() => ProductCheckoutPaymentScreen());
                              }
                            },
                            child: customButton(
                                'continuetoPayment'.tr, kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              20.verticalSpace,
            ])),
      ),
    );
  }
}
