import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/PaymentScreen.dart';

class BookEventContactInfoScreen extends StatefulWidget {
  const BookEventContactInfoScreen({super.key});

  @override
  State<BookEventContactInfoScreen> createState() =>
      _BookEventContactInfoScreenState();
}

class _BookEventContactInfoScreenState
    extends State<BookEventContactInfoScreen> {
  String? phoneNumber;
  bool privacyCheck = false;

  final _fullNameController = TextEditingController(text: "Andrew Ainsley");
  final _nickNameController = TextEditingController(text: "Andrew");
  final _emailController =
      TextEditingController(text: "andrew_ainsley@yourdomain.com");
  final _dobController = TextEditingController(text: "12/27/1995");

  final _fullNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _nickNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  Color _filledColorEmail = kDisabledColor.withOpacity(0.4);
  Color _filledColorFullName = kDisabledColor.withOpacity(0.4);
  Color _filledColorNickName = kDisabledColor.withOpacity(0.4);
  Color _filledColorPhone = kDisabledColor.withOpacity(0.4);

  Color _iconColorEmail = Colors.grey;

  List<String> genderList = [male, female, other];

  List<String> locationList = ["United States", "United Kingdom", "Spain"];

  String? selectedGender = "Male";
  String? selectedLocation = "United States";

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _emailFocusNode.dispose();
    _nickNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //  backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          //    backgroundColor: kSecondBackgroundColor,
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
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back)),
                    10.horizontalSpace,
                    Text(
                      bookEvent,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                Text(
                  contactInformation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                20.verticalSpace,
                Expanded(
                  child: Form(
                      //     key: _formKey,
                      child: ListView(
                    children: [
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: _fullNameController,
                        keyboardType: TextInputType.text,
                        focusNode: _fullNameFocusNode,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please enter your username';
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                            errorBorder: customOutlineBorder,
                            enabledBorder: customOutlineBorder,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            disabledBorder: customOutlineBorder,
                            // fillColor: _filledColorFullName,
                            filled: true,
                            hintText: fullName,
                            hintStyle: TextStyle(
                                color: Color(0xff9E9E9E), fontSize: 14)),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(textRegExp),
                        ],
                      ),
                      20.verticalSpace,
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: _nickNameController,
                        keyboardType: TextInputType.text,
                        focusNode: _nickNameFocusNode,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please enter your username';
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                            errorBorder: customOutlineBorder,
                            enabledBorder: customOutlineBorder,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            disabledBorder: customOutlineBorder,
                            // fillColor: _filledColorNickName,
                            filled: true,
                            hintText: nickName,
                            hintStyle: TextStyle(
                                color: Color(0xff9E9E9E), fontSize: 14)),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(textRegExp),
                        ],
                      ),
                      20.verticalSpace,
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: TextFormField(
                          controller: _dobController,
                          enabled: false,
                          style: const TextStyle(),
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            hintText: "Date of Birth",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            suffixIcon: Image.asset(
                              calendarIcon,
                              color: Colors.grey,
                            ),
                            errorBorder: customOutlineBorder,
                            enabledBorder: customOutlineBorder,
                            focusedBorder: customOutlineBorder,
                            disabledBorder: customOutlineBorder,
                            // fillColor: kDisabledColor.withOpacity(0.4),
                            filled: true,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: _emailController,
                        keyboardType: TextInputType.text,
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
                                borderSide: BorderSide(color: kPrimaryColor)),
                            disabledBorder: customOutlineBorder,
                            // fillColor: _filledColorEmail,
                            filled: true,
                            hintText: email,
                            hintStyle: TextStyle(
                                color: Color(0xff9E9E9E), fontSize: 14)),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(textRegExp),
                        ],
                      ),
                      20.verticalSpace,
                      IntlPhoneField(
                        initialValue: "1467378399",
                        focusNode: _phoneFocusNode,
                        // controller: _phoneController,
                        flagsButtonPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        showDropdownIcon: false,
                        showCountryFlag: true, //showFlag
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
                                borderSide: BorderSide(color: kPrimaryColor)),
                            disabledBorder: customOutlineBorder,
                            errorBorder: customOutlineBorder,
                            border: customOutlineBorder),
                        initialCountryCode: 'US',
                        onChanged: (phone) {
                          phoneNumber = phone.countryCode + phone.number;
                        },
                      ),
                      20.verticalSpace,
                      Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: DropdownButtonFormField(
                          dropdownColor:
                              Theme.of(context).colorScheme.secondary,
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
                          iconEnabledColor: Colors.grey,
                          hint: Text(
                            gender,
                            style: TextStyle(fontSize: 15.sp),
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
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: DropdownButtonFormField(
                          dropdownColor:
                              Theme.of(context).colorScheme.secondary,
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
                          iconEnabledColor: Colors.grey,
                          hint: Text(
                            location,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 15.sp),
                          ),
                          value: selectedLocation,
                          onChanged: (value) {
                            selectedLocation = value;
                          },
                          items: locationList //items
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      20.verticalSpace,
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
                          title: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: iAcceptTheEveno + " ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background)),
                              TextSpan(
                                  text: termsOfService,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor)),
                              TextSpan(
                                  text: ", ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background)),
                              TextSpan(
                                  text: communityGuidelines,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor)),
                              TextSpan(
                                  text: ", $and ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background)),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor)),
                              TextSpan(
                                  text: " " + require,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background))
                            ]),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.white,
                          dense: false,
                          value: privacyCheck,
                          onChanged: (value) {
                            setState(() {
                              privacyCheck = value!;
                            });
                          },
                        ),
                      ),
                      20.verticalSpace,
                      InkWell(
                        onTap: () {
                          Get.to(() => PaymentScreen(),
                              transition: Transition.rightToLeft);
                        },
                        child: customButton(continueButton, kPrimaryColor),
                      ),
                      20.verticalSpace,
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
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
