import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tiqarte/view/LocationSetupScreen.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  String? phoneNumber;
  File? imageFile;
  String? latitude;
  String? longitude;
  Position? position;
  LocationPermission? permission;
  final _fullNameController = TextEditingController();
  final _nickNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();

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

  String? selectedGender;

  @override
  void initState() {
    super.initState();
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
        backgroundColor: kSecondBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kSecondBackgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            fillYourProfile,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.verticalSpace,
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      imageFile == null
                          ? Container(
                              width: 100.h,
                              height: 100.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200.0),
                                  border: Border.all(
                                    color: kDisabledColor,
                                    style: BorderStyle.solid,
                                  ),
                                  color: kDisabledColor.withOpacity(0.2)),
                              child: Icon(
                                Icons.person,
                                color: kDisabledColor,
                                size: 100,
                              ),
                            )
                          : Container(
                              width: 100.h,
                              height: 100.h,
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
                          color: kDisabledColor,
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
                  40.verticalSpace,
                  Form(
                      //     key: _formKey,
                      child: Column(
                    children: [
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: _fullNameController,
                        style: const TextStyle(color: Colors.black),
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
                            fillColor: _filledColorFullName,
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
                        style: const TextStyle(color: Colors.black),
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
                            fillColor: _filledColorNickName,
                            filled: true,
                            hintText: nickName,
                            hintStyle: TextStyle(
                                color: Color(0xff9E9E9E), fontSize: 14)),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(textRegExp),
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
                            fillColor: kDisabledColor.withOpacity(0.4),
                            filled: true,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: _emailController,
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
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            disabledBorder: customOutlineBorder,
                            fillColor: _filledColorEmail,
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
                        focusNode: _phoneFocusNode,
                        // controller: _phoneController,
                        flagsButtonPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        cursorColor: Colors.black,
                        showDropdownIcon: false,
                        showCountryFlag: true, //showFlag
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
                            gender,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 15.sp),
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
                            Get.to(
                                () => LocationSetupScreen(
                                    lat: latitude.toString(),
                                    long: longitude.toString()),
                                transition: Transition.rightToLeft);
                          } else {
                            checkLocationPermission();
                          }
                        },
                        child: customButton(continueButton, kPrimaryColor),
                      ),
                      20.verticalSpace,
                    ],
                  )),
                ],
              ),
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

  // DateTime? currentBackPressTime;

  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
  //     currentBackPressTime = now;
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         "Tap again to exit from app",
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       backgroundColor: kSecondaryColor,
  //     ));
  //     return Future.value(false);
  //   }
  //   customAlertDialog(
  //       context, "Alert!", "Are you sure you want to exit from app?", () {
  //     exitUser();
  //   });

  //   return Future.value(false);
  // }

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
            enableLocation,
            locationDialogSubString,
            enableLocation,
            cancel, () {
          openAppSettings().then((value) {
            //checkLocationPermission();
          });
          Get.back();
        });
      }
    } else if (permission == LocationPermission.deniedForever) {
      customAlertDialogForPermission(context, backgroundLogo, Icons.location_on,
          enableLocation, locationDialogSubString, enableLocation, cancel, () {
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
            galleryDialogHeadingString,
            galleryDialogSubString,
            galleryDialogButtonEnableString,
            galleryDialogButtonCancelString, () {
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
          galleryDialogHeadingString,
          galleryDialogSubString,
          galleryDialogButtonEnableString,
          galleryDialogButtonCancelString, () {
        openAppSettings().then((value) {
          checkGalleryPermissionAndPickImage();
        });
        Get.back();
      });
    } else if (photoStatus.isGranted) {
      _getFromGallery();
    }
  }
}
