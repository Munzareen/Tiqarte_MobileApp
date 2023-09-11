import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tiqarte/api/ApiService.dart';
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
  String? countryCode;
  final _fullNameController = TextEditingController();
  final _nickNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _provinceController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  final _fullNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _nickNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _zipCodeFocusNode = FocusNode();

  Color _filledColorEmail = kDisabledColor.withOpacity(0.4);
  Color _filledColorFullName = kDisabledColor.withOpacity(0.4);
  Color _filledColorNickName = kDisabledColor.withOpacity(0.4);
  Color _filledColorPhone = kDisabledColor.withOpacity(0.4);

  Color _filledColorState = kDisabledColor.withOpacity(0.4);
  Color _filledColorCity = kDisabledColor.withOpacity(0.4);
  Color _filledColorZipCode = kDisabledColor.withOpacity(0.4);
  Color _iconColorEmail = Colors.grey;

  MyBasketController _myBasketController = Get.find();
  final _formKey = GlobalKey<FormState>();

  // Color _filledColorEmail = kDisabledColor.withOpacity(0.4);
  // Color _filledColorFullName = kDisabledColor.withOpacity(0.4);

  List<String> genderList = ['male'.tr, 'female'.tr, 'other'.tr];
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _fullNameController.text = userName;
    _nickNameController.text = userNickname;

    _dobController.text = userDob;
    _provinceController.text = userState;
    _cityController.text = userCity;
    _postalCodeController.text = userZipcode;

    _emailController.text = userEmail;
    _phoneController.text = userNumber;
    if (userGender.toLowerCase().trim().isNotEmpty)
      selectedGender = userGender.toLowerCase().tr;

    if (userCountrycode.trim().isNotEmpty) {
      countryCode = userCountrycode;
      dynamic codeData = countriesWithCode.firstWhereOrNull(
          ((element) => element['dial_code'] == userCountrycode));
      if (codeData != null) {
        countryCode = codeData['code'];
      }
    }

    // checkLocationPermission();
    _fullNameFocusNode.addListener(() {
      if (_fullNameFocusNode.hasFocus) {
        setState(() {
          _filledColorFullName = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorFullName = kDisabledColor.withOpacity(0.4);
        });
      }
    });

    _nickNameFocusNode.addListener(() {
      if (_nickNameFocusNode.hasFocus) {
        setState(() {
          _filledColorNickName = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorNickName = kDisabledColor.withOpacity(0.4);
        });
      }
    });
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

    _phoneFocusNode.addListener(() {
      if (_phoneFocusNode.hasFocus) {
        setState(() {
          _filledColorPhone = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorPhone = kDisabledColor.withOpacity(0.4);
        });
      }
    });

    ///
    _stateFocusNode.addListener(() {
      if (_stateFocusNode.hasFocus) {
        setState(() {
          _filledColorState = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorState = kDisabledColor.withOpacity(0.4);
        });
      }
    });
    _cityFocusNode.addListener(() {
      if (_cityFocusNode.hasFocus) {
        setState(() {
          _filledColorCity = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorCity = kDisabledColor.withOpacity(0.4);
        });
      }
    });
    _zipCodeFocusNode.addListener(() {
      if (_zipCodeFocusNode.hasFocus) {
        setState(() {
          _filledColorZipCode = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorZipCode = kDisabledColor.withOpacity(0.4);
        });
      }
    });
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
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            focusNode: _fullNameFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your full name';
                              } else if (!value.trim().contains(' ')) {
                                return 'Please enter full name';
                              } else
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
                                fillColor: _filledColorFullName,
                                filled: true,
                                hintText: 'fullName'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(textRegExp),
                            ],
                          ),
                          20.verticalSpace,
                          // TextFormField(
                          //   cursorColor: kPrimaryColor,
                          //   controller: _nickNameController,
                          //   style: const TextStyle(color: Colors.black),
                          //   keyboardType: TextInputType.text,
                          //   focusNode: _nickNameFocusNode,
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter your nickname';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: InputDecoration(
                          //       errorBorder: customOutlineBorder,
                          //       enabledBorder: customOutlineBorder,
                          //       focusedErrorBorder: customOutlineBorder,
                          //       focusedBorder: OutlineInputBorder(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(12.0)),
                          //           borderSide:
                          //               BorderSide(color: kPrimaryColor)),
                          //       disabledBorder: customOutlineBorder,
                          //       fillColor: _filledColorNickName,
                          //       filled: true,
                          //       hintText: 'nickName'.tr,
                          //       hintStyle: TextStyle(
                          //           color: Color(0xff9E9E9E), fontSize: 14)),
                          //   inputFormatters: [
                          //     FilteringTextInputFormatter.allow(alphanumeric),
                          //   ],
                          // ),
                          // 20.verticalSpace,
                          // GestureDetector(
                          //   onTap: () {
                          //     _selectDate(context);
                          //   },
                          //   child: TextFormField(
                          //     controller: _dobController,
                          //     enabled: false,
                          //     style: const TextStyle(
                          //       color: Colors.black,
                          //     ),
                          //     cursorColor: kPrimaryColor,
                          //     decoration: InputDecoration(
                          //       hintText: "dateOfBirth".tr,
                          //       hintStyle: TextStyle(
                          //         color: Colors.grey,
                          //       ),
                          //       suffixIcon: Image.asset(
                          //         calendarIcon,
                          //         color: Colors.grey,
                          //       ),
                          //       errorBorder: customOutlineBorder,
                          //       enabledBorder: customOutlineBorder,
                          //       focusedBorder: customOutlineBorder,
                          //       disabledBorder: customOutlineBorder,
                          //       focusedErrorBorder: customOutlineBorder,
                          //       fillColor: kDisabledColor.withOpacity(0.4),
                          //       filled: true,
                          //     ),
                          //   ),
                          // ),
                          //20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _emailController,
                            enabled: false,
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            focusNode: _emailFocusNode,
                            decoration: InputDecoration(
                                suffixIcon: Image.asset(
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
                                fillColor: _filledColorEmail,
                                filled: true,
                                hintText: 'email'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(textRegExp),
                            ],
                          ),
                          ////
                          20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _provinceController,
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            focusNode: _stateFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your province';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                fillColor: _filledColorState,
                                filled: true,
                                hintText: 'province'.tr,
                                hintStyle: TextStyle(
                                    color: Color(0xff9E9E9E), fontSize: 14)),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(textRegExp),
                            ],
                          ),
                          20.verticalSpace,
                          TextFormField(
                            cursorColor: kPrimaryColor,
                            controller: _cityController,
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            focusNode: _cityFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                fillColor: _filledColorCity,
                                filled: true,
                                hintText: 'city'.tr,
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
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            focusNode: _zipCodeFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your postal code';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorBorder: customOutlineBorder,
                                enabledBorder: customOutlineBorder,
                                focusedErrorBorder: customOutlineBorder,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                disabledBorder: customOutlineBorder,
                                fillColor: _filledColorZipCode,
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
                            focusNode: _phoneFocusNode,
                            controller: _phoneController,
                            flagsButtonPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            cursorColor: Colors.black,
                            showDropdownIcon: false,
                            showCountryFlag: true, //showFlag
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            style: const TextStyle(
                                color: Colors.black, letterSpacing: 3),
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.disabled,
                            dropdownTextStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            decoration: InputDecoration(
                                counterStyle: TextStyle(color: Colors.black),
                                hintText: '000 000 000',
                                hintStyle: TextStyle(color: Colors.grey),
                                fillColor: _filledColorPhone,
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
                            initialCountryCode:
                                countryCode == null || countryCode == "null"
                                    ? 'US'
                                    : countryCode,
                            onChanged: (phone) {
                              countryCode = phone.countryCode;
                              // phoneNumber = phone.number;
                            },
                            onCountryChanged: (country) {
                              countryCode = "+${country.dialCode}";
                            },
                          ),
                          20.verticalSpace,
                          Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: kDisabledColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: DropdownButtonFormField(
                              dropdownColor: kDisabledColor,
                              borderRadius: BorderRadius.circular(12.0),
                              decoration: InputDecoration(
                                  constraints: BoxConstraints(),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                              alignment: AlignmentDirectional.centerStart,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                size: 25,
                              ),
                              iconEnabledColor: kDisabledColor,
                              hint: Text(
                                'gender'.tr,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15.sp),
                              ),
                              value: selectedGender,
                              onChanged: (value) {
                                selectedGender = value;
                              },
                              items: genderList //items
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          20.verticalSpace,
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                var data = {
                                  "AddToCartIds": _myBasketController.cartIds,
                                  "CustomerName":
                                      _fullNameController.text.trim(),
                                  "CustomerEmail": _emailController.text.trim(),
                                  "State": _provinceController.text.trim(),
                                  "City": _cityController.text.trim(),
                                  "PostalCode":
                                      _postalCodeController.text.trim(),
                                  "MobileNumber":
                                      "$countryCode${_phoneController.text}",
                                  "PurchaseDate": DateTime.now().toString()
                                };

                                ApiService().shopProduct(context, data);

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

  DateTime selectedDate = DateTime.now();
  var myFormat = DateFormat('MM/dd/yyyy');
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: kPrimaryColor,
                ),
              ),
            ),
            child: child!,
          );
        },
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _dobController.text = myFormat.format(picked).toString();

        FocusManager.instance.primaryFocus?.unfocus();
      });
    }
  }
}
