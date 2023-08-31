import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;
  String? latitude;
  String? longitude;
  Position? position;
  LocationPermission? permission;
  String? countryCode;
  final _fullNameController = TextEditingController();
  final _nickNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();
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

  List<String> genderList = ['male'.tr, 'female'.tr, 'other'.tr];

  List<String> locationList = ["United States", "United Kingdom", "Spain"];

  String? selectedGender;
  // String? selectedLocation = "United States";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _fullNameController.text = userName;
    _nickNameController.text = userNickname;

    _dobController.text = userDob;
    _stateController.text = userState;
    _cityController.text = userCity;
    _zipCodeController.text = userZipcode;

    _emailController.text = userEmail;
    _phoneController.text = userNumber;
    selectedGender = userGender.toLowerCase().tr;

    countryCode = userCountrycode;
    dynamic codeData = countriesWithCode.firstWhereOrNull(
        ((element) => element['dial_code'] == userCountrycode));
    if (codeData != null) {
      countryCode = codeData['code'];
    }

    checkLocationPermission();
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
                          'profile'.tr,
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
                        PopupMenuButton(
                            color: Theme.of(context).colorScheme.secondary,
                            offset: Offset(50, -5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                            itemBuilder: (_) => <PopupMenuItem<String>>[
                                  PopupMenuItem<String>(
                                    child: Text("Camera"),
                                    value: 'Camera',
                                    onTap: () =>
                                        checkCameraPermissionAndOpenCamera(),
                                  ),
                                  PopupMenuItem<String>(
                                      child: Text("Gallery"),
                                      value: 'Gallery',
                                      onTap: () =>
                                          //  checkGalleryPermissionAndPickImage(),
                                          _getFromGallery())
                                ])
                      ],
                    ),
                    20.verticalSpace,
                    Expanded(
                      child: Form(
                          key: _formKey,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      disabledBorder: customOutlineBorder,
                                      focusedErrorBorder: customOutlineBorder,
                                      fillColor: _filledColorFullName,
                                      filled: true,
                                      hintText: 'fullName'.tr,
                                      hintStyle: TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontSize: 14)),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        textRegExp),
                                  ],
                                ),
                                20.verticalSpace,
                                TextFormField(
                                  cursorColor: kPrimaryColor,
                                  controller: _nickNameController,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                  focusNode: _nickNameFocusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your nickname';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      errorBorder: customOutlineBorder,
                                      enabledBorder: customOutlineBorder,
                                      focusedErrorBorder: customOutlineBorder,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      disabledBorder: customOutlineBorder,
                                      fillColor: _filledColorNickName,
                                      filled: true,
                                      hintText: 'nickName'.tr,
                                      hintStyle: TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontSize: 14)),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        textRegExp),
                                  ],
                                ),
                                20.verticalSpace,
                                GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: TextFormField(
                                    controller: _dobController,
                                    enabled: false,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    cursorColor: kPrimaryColor,
                                    decoration: InputDecoration(
                                      hintText: "dateOfBirth".tr,
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
                                      focusedErrorBorder: customOutlineBorder,
                                      fillColor:
                                          kDisabledColor.withOpacity(0.4),
                                      filled: true,
                                    ),
                                  ),
                                ),
                                20.verticalSpace,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      disabledBorder: customOutlineBorder,
                                      fillColor: _filledColorEmail,
                                      filled: true,
                                      hintText: 'email'.tr,
                                      hintStyle: TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontSize: 14)),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        textRegExp),
                                  ],
                                ),
                                ////
                                20.verticalSpace,
                                TextFormField(
                                  cursorColor: kPrimaryColor,
                                  controller: _stateController,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                  focusNode: _stateFocusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your state';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      errorBorder: customOutlineBorder,
                                      enabledBorder: customOutlineBorder,
                                      focusedErrorBorder: customOutlineBorder,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      disabledBorder: customOutlineBorder,
                                      fillColor: _filledColorState,
                                      filled: true,
                                      hintText: 'state'.tr,
                                      hintStyle: TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontSize: 14)),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        textRegExp),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      disabledBorder: customOutlineBorder,
                                      fillColor: _filledColorCity,
                                      filled: true,
                                      hintText: 'city'.tr,
                                      hintStyle: TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontSize: 14)),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        textRegExp),
                                  ],
                                ),
                                20.verticalSpace,
                                TextFormField(
                                  cursorColor: kPrimaryColor,
                                  controller: _zipCodeController,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                  focusNode: _zipCodeFocusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your zip code';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      errorBorder: customOutlineBorder,
                                      enabledBorder: customOutlineBorder,
                                      focusedErrorBorder: customOutlineBorder,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      disabledBorder: customOutlineBorder,
                                      fillColor: _filledColorZipCode,
                                      filled: true,
                                      hintText: 'zipcode'.tr,
                                      hintStyle: TextStyle(
                                          color: Color(0xff9E9E9E),
                                          fontSize: 14)),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        numberRegExp),
                                  ],
                                ),
                                20.verticalSpace,
                                IntlPhoneField(
                                  focusNode: _phoneFocusNode,
                                  controller: _phoneController,
                                  flagsButtonPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 20),
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
                                      counterStyle:
                                          TextStyle(color: Colors.black),
                                      hintText: '000 000 000',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      fillColor: _filledColorPhone,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: kPrimaryColor)),
                                      disabledBorder: customOutlineBorder,
                                      focusedErrorBorder: customOutlineBorder,
                                      errorBorder: customOutlineBorder,
                                      border: customOutlineBorder),
                                  initialCountryCode: countryCode == null ||
                                          countryCode == "null"
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
                                    if (latitude != null) {
                                      if (_formKey.currentState!.validate()) {
                                        if (_dobController.text.isEmpty ||
                                            _phoneController.text == '' ||
                                            selectedGender == null) {
                                          customSnackBar("error".tr,
                                              "pleaseAddAllTheInformation".tr);
                                        } else {
                                          Map<String, String> data = {
                                            'Email':
                                                _emailController.text.trim(),
                                            'FirstName': _fullNameController
                                                .text
                                                .trim()
                                                .split(' ')
                                                .first,
                                            'LastName': _fullNameController.text
                                                .trim()
                                                .split(' ')
                                                .last,
                                            'Gender': selectedGender.toString(),
                                            'DOB': _dobController.text.trim(),
                                            'NickName':
                                                _nickNameController.text.trim(),
                                            'CountryCode':
                                                countryCode.toString(),
                                            'PhoneNumber':
                                                _phoneController.text,
                                            'Location': '$latitude,$longitude',
                                            'State':
                                                _stateController.text.trim(),
                                            'City': _cityController.text.trim(),
                                            'ZipCode':
                                                _zipCodeController.text.trim(),
                                          };
                                          primaryFocus?.unfocus();
                                          ApiService().updateProfile(
                                              context,
                                              data,
                                              imageFile == null
                                                  ? null
                                                  : imageFile!,
                                              'edit');
                                        }
                                      }
                                    } else {
                                      checkLocationPermission();
                                    }
                                  },
                                  child: customButton(
                                      'continueButton'.tr, kPrimaryColor),
                                ),
                                20.verticalSpace,
                              ],
                            ),
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

  checkLocationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        getLatLng();
      } else if (permission == LocationPermission.deniedForever) {
        customAlertDialogForPermission(
            context,
            backgroundLogo,
            Icons.location_on,
            'enableLocation'.tr,
            'locationDialogSubString'.tr,
            'enableLocation'.tr,
            'cancel'.tr, () {
          openAppSettings().then((value) {
            //checkLocationPermission();
          });
          Get.back();
        });
      }
    } else if (permission == LocationPermission.deniedForever) {
      customAlertDialogForPermission(
          context,
          backgroundLogo,
          Icons.location_on,
          'enableLocation'.tr,
          'locationDialogSubString'.tr,
          'enableLocation'.tr,
          'cancel'.tr, () {
        openAppSettings().then((value) {
          //checkLocationPermission();
        });
        Get.back();
      });
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      getLatLng();
    }
  }

  getLatLng() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (position != null) {
      latitude = position?.latitude.toString();
      longitude = position?.longitude.toString();
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
            'enableCamera'.tr,
            'enableCameraSubString'.tr,
            'enableCamera'.tr,
            'cancel'.tr, () {
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
          'enableCamera'.tr,
          'enableCameraSubString'.tr,
          'enableCamera'.tr,
          'cancel'.tr, () {
        openAppSettings().then((value) {
          checkCameraPermissionAndOpenCamera();
        });
        Get.back();
      });
    } else if (cameraStatus.isGranted) {
      _getFromCamera();
    }
  }

  checkGalleryPermissionAndPickImage() async {
    var photoStatus = await Permission.photos.status;

    if (photoStatus.isDenied) {
      photoStatus = await Permission.camera.request();
      if (photoStatus.isDenied) {
        photoStatus = await Permission.camera.request();
      } else if (photoStatus.isPermanentlyDenied) {
        customAlertDialogForPermission(
            context,
            backgroundLogo,
            Icons.photo,
            'enablePhoto'.tr,
            'enablePhotoSubString'.tr,
            'enablePhoto'.tr,
            'cancel'.tr, () {
          openAppSettings().then((value) {
            checkGalleryPermissionAndPickImage();
          });
          Get.back();
        });
      } else if (photoStatus.isGranted) {
        _getFromGallery();
      }
    } else if (photoStatus.isPermanentlyDenied) {
      customAlertDialogForPermission(
          context,
          backgroundLogo,
          Icons.photo,
          'enablePhoto'.tr,
          'enablePhotoSubString'.tr,
          'enablePhoto'.tr,
          'cancel'.tr, () {
        openAppSettings().then((value) {
          checkGalleryPermissionAndPickImage();
        });
        Get.back();
      });
    } else if (photoStatus.isGranted) {
      _getFromGallery();
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

  List countriesWithCode = [
    {"name": "Afghanistan", "dial_code": "+93", "code": "AF"},
    {"name": "Aland Islands", "dial_code": "+358", "code": "AX"},
    {"name": "Albania", "dial_code": "+355", "code": "AL"},
    {"name": "Algeria", "dial_code": "+213", "code": "DZ"},
    {"name": "AmericanSamoa", "dial_code": "+1684", "code": "AS"},
    {"name": "Andorra", "dial_code": "+376", "code": "AD"},
    {"name": "Angola", "dial_code": "+244", "code": "AO"},
    {"name": "Anguilla", "dial_code": "+1264", "code": "AI"},
    {"name": "Antarctica", "dial_code": "+672", "code": "AQ"},
    {"name": "Antigua and Barbuda", "dial_code": "+1268", "code": "AG"},
    {"name": "Argentina", "dial_code": "+54", "code": "AR"},
    {"name": "Armenia", "dial_code": "+374", "code": "AM"},
    {"name": "Aruba", "dial_code": "+297", "code": "AW"},
    {"name": "Australia", "dial_code": "+61", "code": "AU"},
    {"name": "Austria", "dial_code": "+43", "code": "AT"},
    {"name": "Azerbaijan", "dial_code": "+994", "code": "AZ"},
    {"name": "Bahamas", "dial_code": "+1242", "code": "BS"},
    {"name": "Bahrain", "dial_code": "+973", "code": "BH"},
    {"name": "Bangladesh", "dial_code": "+880", "code": "BD"},
    {"name": "Barbados", "dial_code": "+1246", "code": "BB"},
    {"name": "Belarus", "dial_code": "+375", "code": "BY"},
    {"name": "Belgium", "dial_code": "+32", "code": "BE"},
    {"name": "Belize", "dial_code": "+501", "code": "BZ"},
    {"name": "Benin", "dial_code": "+229", "code": "BJ"},
    {"name": "Bermuda", "dial_code": "+1441", "code": "BM"},
    {"name": "Bhutan", "dial_code": "+975", "code": "BT"},
    {
      "name": "Bolivia, Plurinational State of",
      "dial_code": "+591",
      "code": "BO"
    },
    {"name": "Bosnia and Herzegovina", "dial_code": "+387", "code": "BA"},
    {"name": "Botswana", "dial_code": "+267", "code": "BW"},
    {"name": "Brazil", "dial_code": "+55", "code": "BR"},
    {
      "name": "British Indian Ocean Territory",
      "dial_code": "+246",
      "code": "IO"
    },
    {"name": "Brunei Darussalam", "dial_code": "+673", "code": "BN"},
    {"name": "Bulgaria", "dial_code": "+359", "code": "BG"},
    {"name": "Burkina Faso", "dial_code": "+226", "code": "BF"},
    {"name": "Burundi", "dial_code": "+257", "code": "BI"},
    {"name": "Cambodia", "dial_code": "+855", "code": "KH"},
    {"name": "Cameroon", "dial_code": "+237", "code": "CM"},
    // {"name": "Canada", "dial_code": "+1", "code": "CA"},
    {"name": "Cape Verde", "dial_code": "+238", "code": "CV"},
    {"name": "Cayman Islands", "dial_code": "+ 345", "code": "KY"},
    {"name": "Central African Republic", "dial_code": "+236", "code": "CF"},
    {"name": "Chad", "dial_code": "+235", "code": "TD"},
    {"name": "Chile", "dial_code": "+56", "code": "CL"},
    {"name": "China", "dial_code": "+86", "code": "CN"},
    {"name": "Christmas Island", "dial_code": "+61", "code": "CX"},
    {"name": "Cocos (Keeling) Islands", "dial_code": "+61", "code": "CC"},
    {"name": "Colombia", "dial_code": "+57", "code": "CO"},
    {"name": "Comoros", "dial_code": "+269", "code": "KM"},
    {"name": "Congo", "dial_code": "+242", "code": "CG"},
    {
      "name": "Congo, The Democratic Republic of the Congo",
      "dial_code": "+243",
      "code": "CD"
    },
    {"name": "Cook Islands", "dial_code": "+682", "code": "CK"},
    {"name": "Costa Rica", "dial_code": "+506", "code": "CR"},
    {"name": "Cote d'Ivoire", "dial_code": "+225", "code": "CI"},
    {"name": "Croatia", "dial_code": "+385", "code": "HR"},
    {"name": "Cuba", "dial_code": "+53", "code": "CU"},
    {"name": "Cyprus", "dial_code": "+357", "code": "CY"},
    {"name": "Czech Republic", "dial_code": "+420", "code": "CZ"},
    {"name": "Denmark", "dial_code": "+45", "code": "DK"},
    {"name": "Djibouti", "dial_code": "+253", "code": "DJ"},
    {"name": "Dominica", "dial_code": "+1767", "code": "DM"},
    {"name": "Dominican Republic", "dial_code": "+1849", "code": "DO"},
    {"name": "Ecuador", "dial_code": "+593", "code": "EC"},
    {"name": "Egypt", "dial_code": "+20", "code": "EG"},
    {"name": "El Salvador", "dial_code": "+503", "code": "SV"},
    {"name": "Equatorial Guinea", "dial_code": "+240", "code": "GQ"},
    {"name": "Eritrea", "dial_code": "+291", "code": "ER"},
    {"name": "Estonia", "dial_code": "+372", "code": "EE"},
    {"name": "Ethiopia", "dial_code": "+251", "code": "ET"},
    {"name": "Falkland Islands (Malvinas)", "dial_code": "+500", "code": "FK"},
    {"name": "Faroe Islands", "dial_code": "+298", "code": "FO"},
    {"name": "Fiji", "dial_code": "+679", "code": "FJ"},
    {"name": "Finland", "dial_code": "+358", "code": "FI"},
    {"name": "France", "dial_code": "+33", "code": "FR"},
    {"name": "French Guiana", "dial_code": "+594", "code": "GF"},
    {"name": "French Polynesia", "dial_code": "+689", "code": "PF"},
    {"name": "Gabon", "dial_code": "+241", "code": "GA"},
    {"name": "Gambia", "dial_code": "+220", "code": "GM"},
    {"name": "Georgia", "dial_code": "+995", "code": "GE"},
    {"name": "Germany", "dial_code": "+49", "code": "DE"},
    {"name": "Ghana", "dial_code": "+233", "code": "GH"},
    {"name": "Gibraltar", "dial_code": "+350", "code": "GI"},
    {"name": "Greece", "dial_code": "+30", "code": "GR"},
    {"name": "Greenland", "dial_code": "+299", "code": "GL"},
    {"name": "Grenada", "dial_code": "+1473", "code": "GD"},
    {"name": "Guadeloupe", "dial_code": "+590", "code": "GP"},
    {"name": "Guam", "dial_code": "+1671", "code": "GU"},
    {"name": "Guatemala", "dial_code": "+502", "code": "GT"},
    {"name": "Guernsey", "dial_code": "+44", "code": "GG"},
    {"name": "Guinea", "dial_code": "+224", "code": "GN"},
    {"name": "Guinea-Bissau", "dial_code": "+245", "code": "GW"},
    {"name": "Guyana", "dial_code": "+595", "code": "GY"},
    {"name": "Haiti", "dial_code": "+509", "code": "HT"},
    {
      "name": "Holy See (Vatican City State)",
      "dial_code": "+379",
      "code": "VA"
    },
    {"name": "Honduras", "dial_code": "+504", "code": "HN"},
    {"name": "Hong Kong", "dial_code": "+852", "code": "HK"},
    {"name": "Hungary", "dial_code": "+36", "code": "HU"},
    {"name": "Iceland", "dial_code": "+354", "code": "IS"},
    {"name": "India", "dial_code": "+91", "code": "IN"},
    {"name": "Indonesia", "dial_code": "+62", "code": "ID"},
    {
      "name": "Iran, Islamic Republic of Persian Gulf",
      "dial_code": "+98",
      "code": "IR"
    },
    {"name": "Iraq", "dial_code": "+964", "code": "IQ"},
    {"name": "Ireland", "dial_code": "+353", "code": "IE"},
    {"name": "Isle of Man", "dial_code": "+44", "code": "IM"},
    {"name": "Israel", "dial_code": "+972", "code": "IL"},
    {"name": "Italy", "dial_code": "+39", "code": "IT"},
    {"name": "Jamaica", "dial_code": "+1876", "code": "JM"},
    {"name": "Japan", "dial_code": "+81", "code": "JP"},
    {"name": "Jersey", "dial_code": "+44", "code": "JE"},
    {"name": "Jordan", "dial_code": "+962", "code": "JO"},
    {"name": "Kazakhstan", "dial_code": "+77", "code": "KZ"},
    {"name": "Kenya", "dial_code": "+254", "code": "KE"},
    {"name": "Kiribati", "dial_code": "+686", "code": "KI"},
    {
      "name": "Korea, Democratic People's Republic of Korea",
      "dial_code": "+850",
      "code": "KP"
    },
    {
      "name": "Korea, Republic of South Korea",
      "dial_code": "+82",
      "code": "KR"
    },
    {"name": "Kuwait", "dial_code": "+965", "code": "KW"},
    {"name": "Kyrgyzstan", "dial_code": "+996", "code": "KG"},
    {"name": "Laos", "dial_code": "+856", "code": "LA"},
    {"name": "Latvia", "dial_code": "+371", "code": "LV"},
    {"name": "Lebanon", "dial_code": "+961", "code": "LB"},
    {"name": "Lesotho", "dial_code": "+266", "code": "LS"},
    {"name": "Liberia", "dial_code": "+231", "code": "LR"},
    {"name": "Libyan Arab Jamahiriya", "dial_code": "+218", "code": "LY"},
    {"name": "Liechtenstein", "dial_code": "+423", "code": "LI"},
    {"name": "Lithuania", "dial_code": "+370", "code": "LT"},
    {"name": "Luxembourg", "dial_code": "+352", "code": "LU"},
    {"name": "Macao", "dial_code": "+853", "code": "MO"},
    {"name": "Macedonia", "dial_code": "+389", "code": "MK"},
    {"name": "Madagascar", "dial_code": "+261", "code": "MG"},
    {"name": "Malawi", "dial_code": "+265", "code": "MW"},
    {"name": "Malaysia", "dial_code": "+60", "code": "MY"},
    {"name": "Maldives", "dial_code": "+960", "code": "MV"},
    {"name": "Mali", "dial_code": "+223", "code": "ML"},
    {"name": "Malta", "dial_code": "+356", "code": "MT"},
    {"name": "Marshall Islands", "dial_code": "+692", "code": "MH"},
    {"name": "Martinique", "dial_code": "+596", "code": "MQ"},
    {"name": "Mauritania", "dial_code": "+222", "code": "MR"},
    {"name": "Mauritius", "dial_code": "+230", "code": "MU"},
    {"name": "Mayotte", "dial_code": "+262", "code": "YT"},
    {"name": "Mexico", "dial_code": "+52", "code": "MX"},
    {
      "name": "Micronesia, Federated States of Micronesia",
      "dial_code": "+691",
      "code": "FM"
    },
    {"name": "Moldova", "dial_code": "+373", "code": "MD"},
    {"name": "Monaco", "dial_code": "+377", "code": "MC"},
    {"name": "Mongolia", "dial_code": "+976", "code": "MN"},
    {"name": "Montenegro", "dial_code": "+382", "code": "ME"},
    {"name": "Montserrat", "dial_code": "+1664", "code": "MS"},
    {"name": "Morocco", "dial_code": "+212", "code": "MA"},
    {"name": "Mozambique", "dial_code": "+258", "code": "MZ"},
    {"name": "Myanmar", "dial_code": "+95", "code": "MM"},
    {"name": "Namibia", "dial_code": "+264", "code": "NA"},
    {"name": "Nauru", "dial_code": "+674", "code": "NR"},
    {"name": "Nepal", "dial_code": "+977", "code": "NP"},
    {"name": "Netherlands", "dial_code": "+31", "code": "NL"},
    {"name": "Netherlands Antilles", "dial_code": "+599", "code": "AN"},
    {"name": "New Caledonia", "dial_code": "+687", "code": "NC"},
    {"name": "New Zealand", "dial_code": "+64", "code": "NZ"},
    {"name": "Nicaragua", "dial_code": "+505", "code": "NI"},
    {"name": "Niger", "dial_code": "+227", "code": "NE"},
    {"name": "Nigeria", "dial_code": "+234", "code": "NG"},
    {"name": "Niue", "dial_code": "+683", "code": "NU"},
    {"name": "Norfolk Island", "dial_code": "+672", "code": "NF"},
    {"name": "Northern Mariana Islands", "dial_code": "+1670", "code": "MP"},
    {"name": "Norway", "dial_code": "+47", "code": "NO"},
    {"name": "Oman", "dial_code": "+968", "code": "OM"},
    {"name": "Pakistan", "dial_code": "+92", "code": "PK"},
    {"name": "Palau", "dial_code": "+680", "code": "PW"},
    {
      "name": "Palestinian Territory, Occupied",
      "dial_code": "+970",
      "code": "PS"
    },
    {"name": "Panama", "dial_code": "+507", "code": "PA"},
    {"name": "Papua New Guinea", "dial_code": "+675", "code": "PG"},
    {"name": "Paraguay", "dial_code": "+595", "code": "PY"},
    {"name": "Peru", "dial_code": "+51", "code": "PE"},
    {"name": "Philippines", "dial_code": "+63", "code": "PH"},
    {"name": "Pitcairn", "dial_code": "+872", "code": "PN"},
    {"name": "Poland", "dial_code": "+48", "code": "PL"},
    {"name": "Portugal", "dial_code": "+351", "code": "PT"},
    {"name": "Puerto Rico", "dial_code": "+1939", "code": "PR"},
    {"name": "Qatar", "dial_code": "+974", "code": "QA"},
    {"name": "Romania", "dial_code": "+40", "code": "RO"},
    {"name": "Russia", "dial_code": "+7", "code": "RU"},
    {"name": "Rwanda", "dial_code": "+250", "code": "RW"},
    {"name": "Reunion", "dial_code": "+262", "code": "RE"},
    {"name": "Saint Barthelemy", "dial_code": "+590", "code": "BL"},
    {
      "name": "Saint Helena, Ascension and Tristan Da Cunha",
      "dial_code": "+290",
      "code": "SH"
    },
    {"name": "Saint Kitts and Nevis", "dial_code": "+1869", "code": "KN"},
    {"name": "Saint Lucia", "dial_code": "+1758", "code": "LC"},
    {"name": "Saint Martin", "dial_code": "+590", "code": "MF"},
    {"name": "Saint Pierre and Miquelon", "dial_code": "+508", "code": "PM"},
    {
      "name": "Saint Vincent and the Grenadines",
      "dial_code": "+1784",
      "code": "VC"
    },
    {"name": "Samoa", "dial_code": "+685", "code": "WS"},
    {"name": "San Marino", "dial_code": "+378", "code": "SM"},
    {"name": "Sao Tome and Principe", "dial_code": "+239", "code": "ST"},
    {"name": "Saudi Arabia", "dial_code": "+966", "code": "SA"},
    {"name": "Senegal", "dial_code": "+221", "code": "SN"},
    {"name": "Serbia", "dial_code": "+381", "code": "RS"},
    {"name": "Seychelles", "dial_code": "+248", "code": "SC"},
    {"name": "Sierra Leone", "dial_code": "+232", "code": "SL"},
    {"name": "Singapore", "dial_code": "+65", "code": "SG"},
    {"name": "Slovakia", "dial_code": "+421", "code": "SK"},
    {"name": "Slovenia", "dial_code": "+386", "code": "SI"},
    {"name": "Solomon Islands", "dial_code": "+677", "code": "SB"},
    {"name": "Somalia", "dial_code": "+252", "code": "SO"},
    {"name": "South Africa", "dial_code": "+27", "code": "ZA"},
    {"name": "South Sudan", "dial_code": "+211", "code": "SS"},
    {
      "name": "South Georgia and the South Sandwich Islands",
      "dial_code": "+500",
      "code": "GS"
    },
    {"name": "Spain", "dial_code": "+34", "code": "ES"},
    {"name": "Sri Lanka", "dial_code": "+94", "code": "LK"},
    {"name": "Sudan", "dial_code": "+249", "code": "SD"},
    {"name": "Suriname", "dial_code": "+597", "code": "SR"},
    {"name": "Svalbard and Jan Mayen", "dial_code": "+47", "code": "SJ"},
    {"name": "Swaziland", "dial_code": "+268", "code": "SZ"},
    {"name": "Sweden", "dial_code": "+46", "code": "SE"},
    {"name": "Switzerland", "dial_code": "+41", "code": "CH"},
    {"name": "Syrian Arab Republic", "dial_code": "+963", "code": "SY"},
    {"name": "Taiwan", "dial_code": "+886", "code": "TW"},
    {"name": "Tajikistan", "dial_code": "+992", "code": "TJ"},
    {
      "name": "Tanzania, United Republic of Tanzania",
      "dial_code": "+255",
      "code": "TZ"
    },
    {"name": "Thailand", "dial_code": "+66", "code": "TH"},
    {"name": "Timor-Leste", "dial_code": "+670", "code": "TL"},
    {"name": "Togo", "dial_code": "+228", "code": "TG"},
    {"name": "Tokelau", "dial_code": "+690", "code": "TK"},
    {"name": "Tonga", "dial_code": "+676", "code": "TO"},
    {"name": "Trinidad and Tobago", "dial_code": "+1868", "code": "TT"},
    {"name": "Tunisia", "dial_code": "+216", "code": "TN"},
    {"name": "Turkey", "dial_code": "+90", "code": "TR"},
    {"name": "Turkmenistan", "dial_code": "+993", "code": "TM"},
    {"name": "Turks and Caicos Islands", "dial_code": "+1649", "code": "TC"},
    {"name": "Tuvalu", "dial_code": "+688", "code": "TV"},
    {"name": "Uganda", "dial_code": "+256", "code": "UG"},
    {"name": "Ukraine", "dial_code": "+380", "code": "UA"},
    {"name": "United Arab Emirates", "dial_code": "+971", "code": "AE"},
    {"name": "United Kingdom", "dial_code": "+44", "code": "GB"},
    {"name": "United States", "dial_code": "+1", "code": "US"},
    {"name": "Uruguay", "dial_code": "+598", "code": "UY"},
    {"name": "Uzbekistan", "dial_code": "+998", "code": "UZ"},
    {"name": "Vanuatu", "dial_code": "+678", "code": "VU"},
    {
      "name": "Venezuela, Bolivarian Republic of Venezuela",
      "dial_code": "+58",
      "code": "VE"
    },
    {"name": "Vietnam", "dial_code": "+84", "code": "VN"},
    {"name": "Virgin Islands, British", "dial_code": "+1284", "code": "VG"},
    {"name": "Virgin Islands, U.S.", "dial_code": "+1340", "code": "VI"},
    {"name": "Wallis and Futuna", "dial_code": "+681", "code": "WF"},
    {"name": "Yemen", "dial_code": "+967", "code": "YE"},
    {"name": "Zambia", "dial_code": "+260", "code": "ZM"},
    {"name": "Zimbabwe", "dial_code": "+263", "code": "ZW"}
  ];
}
