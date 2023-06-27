import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;
  String? phoneNumber;

  final _fullNameController = TextEditingController();
  final _nickNameController = TextEditingController(text: "Andrew");
  final _emailController = TextEditingController();
  final _dobController = TextEditingController(text: "12/27/1995");

  final _fullNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _nickNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  // Color _filledColorEmail = kDisabledColor.withOpacity(0.4);
  // Color _filledColorFullName = kDisabledColor.withOpacity(0.4);
  // Color _filledColorNickName = kDisabledColor.withOpacity(0.4);
  // Color _filledColorPhone = kDisabledColor.withOpacity(0.4);

  Color _iconColorEmail = Colors.grey;

  List<String> genderList = [male, female, other];

  List<String> locationList = ["United States", "United Kingdom", "Spain"];

  String? selectedGender = "Male";
  String? selectedLocation = "United States";

  @override
  void initState() {
    super.initState();

    _fullNameController.text = userName;
    _emailController.text = userEmail;
    // _fullNameFocusNode.addListener(() {
    //   if (_fullNameFocusNode.hasFocus) {
    //     setState(() {
    //       _filledColorFullName = kPrimaryColor.withOpacity(0.2);
    //     });
    //   } else {
    //     setState(() {
    //       _filledColorFullName = kDisabledColor.withOpacity(0.4);
    //     });
    //   }
    // });

    // _nickNameFocusNode.addListener(() {
    //   if (_nickNameFocusNode.hasFocus) {
    //     setState(() {
    //       _filledColorNickName = kPrimaryColor.withOpacity(0.2);
    //     });
    //   } else {
    //     setState(() {
    //       _filledColorNickName = kDisabledColor.withOpacity(0.4);
    //     });
    //   }
    // });
    // _emailFocusNode.addListener(() {
    //   if (_emailFocusNode.hasFocus) {
    //     setState(() {
    //       _filledColorEmail = kPrimaryColor.withOpacity(0.2);
    //       _iconColorEmail = kPrimaryColor;
    //     });
    //   } else {
    //     setState(() {
    //       _filledColorEmail = kDisabledColor.withOpacity(0.4);
    //       _iconColorEmail = Colors.grey;
    //     });
    //   }
    // });

    // _phoneFocusNode.addListener(() {
    //   if (_phoneFocusNode.hasFocus) {
    //     setState(() {
    //       _filledColorPhone = kPrimaryColor.withOpacity(0.2);
    //     });
    //   } else {
    //     setState(() {
    //       _filledColorPhone = kDisabledColor.withOpacity(0.4);
    //     });
    //   }
    // });
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
            //backgroundColor: kSecondBackgroundColor,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
              height: 1.sh,
              width: 1.sw,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(children: [
                    20.verticalSpace,
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back)),
                        20.horizontalSpace,
                        Text(
                          profile,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        imageFile == null
                            ? customProfileImage(userImage, 110.h, 110.h)
                            //  Container(
                            //     width: 110.h,
                            //     height: 110.h,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(200.0),
                            //         border: Border.all(
                            //           color: kDisabledColor,
                            //           style: BorderStyle.solid,
                            //         ),
                            //         color: kDisabledColor.withOpacity(0.2)),
                            //     child: Icon(
                            //       Icons.person,
                            //       color: kDisabledColor,
                            //       size: 100,
                            //     ),
                            //   )
                            : Container(
                                width: 110.h,
                                height: 110.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200.0),
                                    border: Border.all(
                                      color: kDisabledColor,
                                      style: BorderStyle.solid,
                                    ),
                                    color: kDisabledColor.withOpacity(0.2),
                                    image: DecorationImage(
                                        image: FileImage(imageFile!),
                                        fit: BoxFit.cover)),
                              ),
                        // PopupMenuButton(
                        //     color: Theme.of(context).colorScheme.secondary,
                        //     offset: Offset(50, -5),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         color: kPrimaryColor,
                        //         borderRadius: BorderRadius.circular(12.0),
                        //       ),
                        //       child: Padding(
                        //         padding: EdgeInsets.all(4.0),
                        //         child: Icon(
                        //           Icons.edit,
                        //           color: Colors.white,
                        //           size: 25,
                        //         ),
                        //       ),
                        //     ),
                        //     itemBuilder: (_) => <PopupMenuItem<String>>[
                        //           PopupMenuItem<String>(
                        //             child: Text("Camera"),
                        //             value: 'Camera',
                        //             onTap: () =>
                        //                 checkCameraPermissionAndOpenCamera(),
                        //           ),
                        //           PopupMenuItem<String>(
                        //               child: Text("Gallery"),
                        //               value: 'Gallery',
                        //               onTap: () =>
                        //                   //  checkGalleryPermissionAndPickImage(),
                        //                   _getFromGallery())
                        //         ])
                      ],
                    ),
                    20.verticalSpace,
                    Expanded(
                      child: Form(
                          //     key: _formKey,
                          child: ListView(
                        children: [
                          TextFormField(
                            enabled: false,

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
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
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
                          // 20.verticalSpace,
                          // TextFormField(
                          //   cursorColor: kPrimaryColor,
                          //   controller: _nickNameController,
                          //   keyboardType: TextInputType.text,
                          //   focusNode: _nickNameFocusNode,
                          //   // validator: (value) {
                          //   //   if (value!.isEmpty) {
                          //   //     return 'Please enter your username';
                          //   //   }
                          //   //   return null;
                          //   // },
                          //   decoration: InputDecoration(
                          //       errorBorder: customOutlineBorder,
                          //       enabledBorder: customOutlineBorder,
                          //       focusedBorder: OutlineInputBorder(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(12.0)),
                          //           borderSide:
                          //               BorderSide(color: kPrimaryColor)),
                          //       disabledBorder: customOutlineBorder,
                          //       // fillColor: _filledColorNickName,
                          //       filled: true,
                          //       hintText: nickName,
                          //       hintStyle: TextStyle(
                          //           color: Color(0xff9E9E9E), fontSize: 14)),
                          //   inputFormatters: [
                          //     FilteringTextInputFormatter.allow(textRegExp),
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
                          //     cursorColor: kPrimaryColor,
                          //     decoration: InputDecoration(
                          //       hintText: "Date of Birth",
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
                          //       // fillColor: kDisabledColor.withOpacity(0.4),
                          //       filled: true,
                          //     ),
                          //   ),
                          // ),
                          20.verticalSpace,
                          TextFormField(
                            enabled: false,
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
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
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
                          // IntlPhoneField(
                          //   initialValue: "1467378399",
                          //   focusNode: _phoneFocusNode,
                          //   // controller: _phoneController,
                          //   flagsButtonPadding:
                          //       const EdgeInsets.symmetric(horizontal: 20),
                          //   //cursorColor: Colors.black,
                          //   showDropdownIcon: false,
                          //   showCountryFlag: true, //showFlag
                          //   inputFormatters: [
                          //     FilteringTextInputFormatter.allow(
                          //         RegExp('[0-9]')),
                          //   ],
                          //   style: const TextStyle(letterSpacing: 3),
                          //   keyboardType: TextInputType.number,
                          //   autovalidateMode: AutovalidateMode.disabled,
                          //   dropdownTextStyle: const TextStyle(
                          //       fontWeight: FontWeight.w400, fontSize: 15),
                          //   decoration: InputDecoration(
                          //       hintText: '000 000 000',
                          //       hintStyle: TextStyle(color: Colors.grey),
                          //       // fillColor: _filledColorPhone,
                          //       filled: true,
                          //       focusedBorder: OutlineInputBorder(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(12.0)),
                          //           borderSide:
                          //               BorderSide(color: kPrimaryColor)),
                          //       disabledBorder: customOutlineBorder,
                          //       errorBorder: customOutlineBorder,
                          //       border: customOutlineBorder),
                          //   initialCountryCode: 'US',
                          //   onChanged: (phone) {
                          //     phoneNumber = phone.countryCode + phone.number;
                          //   },
                          // ),
                          // 20.verticalSpace,
                          // Container(
                          //   height: 48.h,
                          //   decoration: BoxDecoration(
                          //     color: Theme.of(context).colorScheme.onSecondary,
                          //     borderRadius: BorderRadius.circular(12.0),
                          //   ),
                          //   child: DropdownButtonFormField(
                          //     dropdownColor:
                          //         Theme.of(context).colorScheme.secondary,
                          //     borderRadius: BorderRadius.circular(12.0),
                          //     decoration: InputDecoration(
                          //         constraints: BoxConstraints(),
                          //         isDense: true,
                          //         border: OutlineInputBorder(
                          //             borderSide: BorderSide.none)),
                          //     alignment: AlignmentDirectional.centerStart,
                          //     icon: Icon(
                          //       Icons.arrow_drop_down,
                          //       size: 25,
                          //     ),
                          //     iconEnabledColor: Colors.grey,
                          //     hint: Text(
                          //       gender,
                          //       style: TextStyle(
                          //           color: Colors.grey, fontSize: 15.sp),
                          //     ),
                          //     value: selectedGender,
                          //     onChanged: (value) {
                          //       selectedGender = value;
                          //     },
                          //     items: genderList //items
                          //         .map(
                          //           (item) => DropdownMenuItem<String>(
                          //             value: item,
                          //             child: Text(
                          //               item.toString(),
                          //               style: TextStyle(
                          //                   fontSize: 15,
                          //                   fontWeight: FontWeight.w300),
                          //             ),
                          //           ),
                          //         )
                          //         .toList(),
                          //   ),
                          // ),
                          // 20.verticalSpace,
                          // Container(
                          //   height: 48.h,
                          //   decoration: BoxDecoration(
                          //     color: Theme.of(context).colorScheme.onSecondary,
                          //     borderRadius: BorderRadius.circular(12.0),
                          //   ),
                          //   child: DropdownButtonFormField(
                          //     dropdownColor:
                          //         Theme.of(context).colorScheme.secondary,
                          //     borderRadius: BorderRadius.circular(12.0),
                          //     decoration: InputDecoration(
                          //         constraints: BoxConstraints(),
                          //         isDense: true,
                          //         border: OutlineInputBorder(
                          //             borderSide: BorderSide.none)),
                          //     alignment: AlignmentDirectional.centerStart,
                          //     icon: Icon(
                          //       Icons.arrow_drop_down,
                          //       size: 25,
                          //     ),
                          //     iconEnabledColor: Colors.grey,
                          //     hint: Text(
                          //       location,
                          //       style: TextStyle(
                          //           color: Colors.grey, fontSize: 15.sp),
                          //     ),
                          //     value: selectedLocation,
                          //     onChanged: (value) {
                          //       selectedLocation = value;
                          //     },
                          //     items: locationList //items
                          //         .map(
                          //           (item) => DropdownMenuItem<String>(
                          //             value: item,
                          //             child: Text(
                          //               item.toString(),
                          //               style: TextStyle(
                          //                   fontSize: 15,
                          //                   fontWeight: FontWeight.w300),
                          //             ),
                          //           ),
                          //         )
                          //         .toList(),
                          //   ),
                          // ),
                          // 20.verticalSpace,
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.back();
                          //   },
                          //   child: customButton(continueButton, kPrimaryColor),
                          // ),
                          20.verticalSpace,
                        ],
                      )),
                    ),
                  ])))),
    );
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 2500,
      maxHeight: 2500,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 2500,
      maxHeight: 2500,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  checkCameraPermissionAndOpenCamera() async {
    var cameraStatus = await Permission.camera.status;

    if (cameraStatus.isDenied) {
      cameraStatus = await Permission.camera.request();
      if (cameraStatus.isDenied) {
        cameraStatus = await Permission.camera.request();
      } else if (cameraStatus.isPermanentlyDenied) {
        customAlertDialogForPermission(
            context,
            backgroundLogo,
            Icons.camera_alt,
            cameraDialogHeadingString,
            cameraDialogSubString,
            cameraDialogButtonEnableString,
            cameraDialogButtonCancelString, () {
          openAppSettings().then((value) {
            checkCameraPermissionAndOpenCamera();
          });
          Get.back();
        });
      } else if (cameraStatus.isGranted) {
        _getFromCamera();
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      customAlertDialogForPermission(
          context,
          backgroundLogo,
          Icons.camera_alt,
          cameraDialogHeadingString,
          cameraDialogSubString,
          cameraDialogButtonEnableString,
          cameraDialogButtonCancelString, () {
        openAppSettings().then((value) {
          checkCameraPermissionAndOpenCamera();
        });
        Get.back();
      });
    } else if (cameraStatus.isGranted) {
      _getFromCamera();
    }
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
