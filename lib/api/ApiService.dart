import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tiqarte/api/ApiPoint.dart';
import 'package:tiqarte/controller/ticketController.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/model/TicketModel.dart';
import 'package:tiqarte/view/AccountSetupScreen.dart';
import 'package:tiqarte/view/EditProfileScreen.dart';
import 'package:tiqarte/view/HomeScreen.dart';
import 'package:tiqarte/view/LoginScreen.dart';
import 'package:tiqarte/view/MainScreen.dart';
import 'package:tiqarte/view/MyBasketScreen.dart';
import 'package:tiqarte/view/OtpVerificationScreen.dart';
import 'package:tiqarte/view/PreLoginScreen.dart';
import 'package:tiqarte/view/SeeAllProductsScreen.dart';
import 'package:tiqarte/view/TicketScreen.dart';
import 'package:tiqarte/view/ViewETicketScreen.dart';
import 'package:tiqarte/view/newPasswordScreen.dart';
import 'package:tiqarte/view/paymentWebViewScreen.dart';

class ApiService {
  register(BuildContext context, Map<String, String> data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().register);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    final headers = {
      'Content-Type': 'application/form-data',
    };

    try {
      var request = http.MultipartRequest('POST', uri);

      request.fields.addAll(data);
      request.headers.addAll(headers);

      //String jsonBody = json.encode(request.fields);

      var response = await request.send();

      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200) {
        Get.back();

        var res_data = json.decode(res.body);
        if (res_data is Map &&
            res_data['message'].toString().toUpperCase().contains("ALREADY")) {
          customSnackBar('alert'.tr, "Email already exist, please try login");
        } else {
          Get.to(
              () => OtpVerificationScreen(
                  email: data['email']!, type: "register"),
              transition: Transition.rightToLeft);
        }
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  verifyOtp(
      BuildContext context, String email, String data, String type) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().verifyEmailOTPTemp + data);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });

    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      http.Response response = await http.get(
        uri,
        //  headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);
        Get.back();

        if (type.toUpperCase().contains("FORGOT")) {
          Get.offAll(() => NewPasswordScreen(email: email),
              transition: Transition.rightToLeft);
        } else {
          if (res_data is Map && res_data['isSuccess']) {
            userEmail = email;
            Get.offAll(() => AccountSetupScreen(email: email),
                transition: Transition.rightToLeft);
          } else {
            customSnackBar('error'.tr, 'Invalid code');
          }
        }
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  login(BuildContext context, Map<String, String> data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().login);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      var request = http.MultipartRequest('POST', uri);

      request.fields.addAll(data);
      request.headers.addAll(headers);

      //String jsonBody = json.encode(request.fields);

      var response = await request.send();

      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200) {
        Get.back();

        var res_data = json.decode(res.body);
        if (res_data is String && res_data.toUpperCase().contains("INVALID")) {
          customSnackBar('error'.tr, res_data);
        } else {
          if (!res_data['isVerified']) {
            Get.to(
                () =>
                    OtpVerificationScreen(email: data['email']!, type: 'login'),
                transition: Transition.rightToLeft);
          } else if (!res_data['isProfileCompleted']) {
            Get.offAll(() => AccountSetupScreen(email: data['email']!),
                transition: Transition.rightToLeft);
          } else {
            if (prefs == null) {
              await initializePrefs();
            }

            accessToken = res_data['token']['data'];
            userId = getUserIdFromJWT(accessToken);
            userName =
                '${res_data['user']['FirstName'].toString()} ${res_data['user']['LastName'].toString()}';
            userImage = res_data['user']['ImageUrl'].toString();
            userEmail = res_data['user']['Email'].toString();
            userNickname = res_data['user']['NickName'].toString();
            userDob = res_data['user']['DOB'].toString();
            userState = res_data['user']['State'].toString();
            userCity = res_data['user']['City'].toString();
            userZipcode = res_data['user']['ZipCode'].toString();
            userCountrycode = res_data['user']['CountryCode'].toString();
            userNumber = res_data['user']['PhoneNumber'].toString();
            userGender = res_data['user']['Gender'].toString();

            prefs?.setString("userNickname", userNickname);
            prefs?.setString("userDob", userDob);
            prefs?.setString("userState", userState);
            prefs?.setString("userCity", userCity);
            prefs?.setString("userZipcode", userZipcode);
            prefs?.setString("userCountrycode", userCountrycode);
            prefs?.setString("userNumber", userNumber);
            prefs?.setString("userGender", userGender);

            prefs?.setString("accessToken", accessToken);
            prefs?.setString("userId", userId);

            prefs?.setString("userName", userName);

            prefs?.setString("userImage", userImage);
            prefs?.setString("userEmail", userEmail);
            Get.back();

            Get.offAll(() => MainScreen(), transition: Transition.rightToLeft);
          }
        }
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  generateOtpTemp(BuildContext context, String email, String type) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().generateOtpTemp + email);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });

    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      http.Response response = await http.get(
        uri,
        // headers: headers,
      );
      if (response.statusCode == 200) {
        Get.back();

        if (type.toUpperCase().contains("FORGOT")) {
          Get.to(() => OtpVerificationScreen(email: email, type: type),
              transition: Transition.rightToLeft);
        } else {
          customSnackBar('success'.tr, 'otpSuccessfullySent'.tr);
        }
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  changePassword(BuildContext context, Map<String, String> data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().changePassword);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    final headers = {
      'Content-Type': 'application/form-data',
    };

    try {
      var request = http.MultipartRequest('POST', uri);

      request.fields.addAll(data);
      request.headers.addAll(headers);

      //String jsonBody = json.encode(request.fields);

      var response = await request.send();

      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200) {
        Get.back();
        customAlertDialogWithSpinkit(
            context,
            backgroundLogo,
            Icons.verified_user,
            'congratulations'.tr,
            'newPasswordCongratsSubString'.tr);
        Timer(Duration(seconds: 2), () {
          Get.back();

          Get.offAll(() => LoginScreen(), transition: Transition.leftToRight);
        });
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  updateProfile(BuildContext context, Map<String, String> data, File? imageFile,
      String type) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().updateProfile);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    final headers = {
      'Content-Type': 'multipart/form-data',
    };

    try {
      var request = http.MultipartRequest('POST', uri);

      request.fields.addAll(data);
      request.headers.addAll(headers);

      if (imageFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'ImageFile', imageFile.path,
            filename: imageFile.path.split('/').last,
            contentType: MediaType("ImageFile", "jpg"));
        request.files.add(multipartFile);
      } else {
        request.files.add(http.MultipartFile.fromBytes('ImageFile', [],
            contentType: MediaType('image', 'png'), filename: ''));
      }

      //String jsonBody = json.encode(request.fields);

      var response = await request.send();

      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200) {
        if (prefs == null) {
          await initializePrefs();
        }

        var res_data = json.decode(res.body.toString());
        accessToken = res_data['token']['data'];
        userId = getUserIdFromJWT(accessToken);
        userName =
            '${res_data['user']['FirstName'].toString()} ${res_data['user']['LastName'].toString()}';
        userImage = res_data['user']['ImageUrl'].toString();
        userEmail = res_data['user']['Email'].toString();
        userNickname = res_data['user']['NickName'].toString();
        userDob = res_data['user']['DOB'].toString();
        userState = res_data['user']['State'].toString();
        userCity = res_data['user']['City'].toString();
        userZipcode = res_data['user']['ZipCode'].toString();
        userCountrycode = res_data['user']['CountryCode'].toString();
        userNumber = res_data['user']['PhoneNumber'].toString();
        userGender = res_data['user']['Gender'].toString();

        prefs?.setString("userNickname", userNickname);
        prefs?.setString("userDob", userDob);
        prefs?.setString("userState", userState);
        prefs?.setString("userCity", userCity);
        prefs?.setString("userZipcode", userZipcode);
        prefs?.setString("userCountrycode", userCountrycode);
        prefs?.setString("userNumber", userNumber);
        prefs?.setString("userGender", userGender);

        prefs?.setString("accessToken", accessToken);
        prefs?.setString("userId", userId);

        prefs?.setString("userName", userName);

        prefs?.setString("userImage", userImage);
        prefs?.setString("userEmail", userEmail);
        Get.back();

        if (type.toUpperCase().contains("EDIT")) {
          customSnackBar("success".tr, 'profileSuccessfullyUpdated'.tr);
        } else {
          Get.offAll(() => MainScreen(), transition: Transition.leftToRight);
        }
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        Get.back();
        customSnackBar("error".tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar("error".tr, 'somethingWentWrong'.tr);
    }
  }

  googleSignIn(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      Get.back();

      if (googleUser != null) {
        String? firstName;
        String? lastName;
        if (googleUser.displayName!.contains(' ')) {
          firstName = googleUser.displayName?.split(' ').first.toString();
          lastName = googleUser.displayName?.split(' ').last.toString();
        }
        // final GoogleSignInAuthentication googleAuth =
        //     await googleUser.authentication;
        // final credential = await GoogleAuthProvider.credential(
        //     accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        String data =
            "Email=${googleUser.email.toString()}&FirstName=$firstName&LastName=$lastName&ImageUrl=${googleUser.photoUrl.toString()}";

        var userData = {
          "userName": googleUser.displayName.toString(),
          "userImage": googleUser.photoUrl,
          "userEmail": googleUser.email.toString()
        };

        socialLogin(context, data, userData);
      }

      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  socialLogin(BuildContext context, String stringData, dynamic userData) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().socialLogin + stringData);

    final headers = {'Content-Type': 'application/json'};
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        if (prefs == null) {
          await initializePrefs();
        }
        Get.back();

        var res_data = json.decode(response.body);
        accessToken = res_data['data'];
        userId = getUserIdFromJWT(accessToken);
        userName = userData["userName"];
        userImage = userData["userImage"];
        userEmail = userData['userEmail'];
        prefs?.setString("accessToken", accessToken);
        prefs?.setString("userId", userId);

        prefs?.setString("userName", userName);
        prefs?.setString("userImage", userImage);
        prefs?.setString("userEmail", userEmail);

        Get.offAll(() => MainScreen(), transition: Transition.leftToRight);
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getHomeDataWithFilter(BuildContext context, String filterData) async {
    final uri = Uri.parse(
        ApiPoint().baseUrl + ApiPoint().getHomeDataWithFilter + filterData);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return spinkit;
        });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);
        Get.back();

        return res_data;
      } else if (response.statusCode == 401) {
        Get.back();
        tokenExpiredLogout();
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getHomeData() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getHomeData);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getEvents() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().GetEvents);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getEventDetail(String id) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getEventDetail + id);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getRelatedEvents(String id) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getRelatedEvents + id);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getEventsByType(String id) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getEventsByType + id);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getEventSearch(BuildContext context, String searchQuery) async {
    final uri = Uri.parse(
        ApiPoint().baseUrl + ApiPoint().getEventsBySearch + searchQuery);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return spinkit;
        });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);
        Get.back();
        return res_data;
      } else if (response.statusCode == 401) {
        Get.back();
        tokenExpiredLogout();
      } else {
        Get.back();

        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getCategories() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getCategory);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getFavorites(String userId) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getfavList + userId);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  addFavorite(String data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().setFav + data);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  removeFavorite(BuildContext context, String data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().setFav + data);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });

    try {
      http.Response response = await http.post(uri, headers: headers);
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getOrganizerDetail(String id) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getOrganizerDetails + id);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  setOrganizerFollow(String data) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().setOrganizerFollow + data);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getAllProductList() async {
    final uri = Uri.parse(
        ApiPoint().baseUrl + ApiPoint().getAllProductList + promotorId);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        Get.back();

        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getSingleProductDetail(String id) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getSingleProductDetail + id);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getMoreLikeProducts(String id) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getMoreLikeProducts + id);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getEventByLocation(String latLng) async {
    final uri = Uri.parse(ApiPoint().baseUrl +
        ApiPoint().getEventByLocation +
        latLng +
        "&distance=100");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getCustomerTicketList() async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getCustomerTicketList);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getETicket(String ticketUniqueNumber) async {
    final uri = Uri.parse(
        ApiPoint().baseUrl + ApiPoint().getETicket + ticketUniqueNumber);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  eventCancel(
      BuildContext context, String ticketUniqueNumber, String reason) async {
    String data = "TicketUniqueNumber=$ticketUniqueNumber&reason=$reason";
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().eventCancel + data);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        TicketController _ticketController = Get.find();

        var res = await getCustomerTicketList();
        if (res != null && res is List) {
          _ticketController.addTicketData(ticketModelFromJson(res));
        }
        Get.back();
        customAlertDialogWithOneButton(
            context,
            backgroundLogo,
            Icons.verified_user,
            'successful'.tr,
            'ticketCancelBookingRefund'.tr,
            'ok'.tr, () {
          Get.back();
          Get.back();
        });
      } else if (response.statusCode == 401) {
        Get.back();
        tokenExpiredLogout();
      } else {
        Get.back();
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  eventReview(BuildContext context, String data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().eventReview + data);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        TicketController _ticketController = Get.find();

        var res = await getCustomerTicketList();
        if (res != null && res is List) {
          _ticketController.addTicketData(ticketModelFromJson(res));
        }
        Get.back();
        Get.back();
        customSnackBar("Success!", "Review successfully submitted");

        // customAlertDialogWithOneButton(
        //     context,
        //     backgroundLogo,
        //     Icons.verified_user,
        //     ticketCancelBookingSuccessfulString,
        //     ticketCancelBookingRefundString,
        //     ticketCancelBookingOKString, () {
        //   Get.back();
        //   Get.back();
        // });
      } else if (response.statusCode == 401) {
        Get.back();
        tokenExpiredLogout();
      } else {
        Get.back();
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      Get.back();

      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getAllFAQTypes() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getAllFAQTypes);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getAllFAQs() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getAllFAQs);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  searchFAQByType(String data) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().searchFAQByType + data);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      } else {
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  addToCart(BuildContext context, dynamic data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().addToCart);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    String jsonBody = json.encode(data);
    try {
      http.Response response =
          await http.post(uri, headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);
        Get.back();

        Get.to(() => MyBasketScreen());
      } else if (response.statusCode == 401) {
        Get.back();

        tokenExpiredLogout();
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  addToCartDelete(BuildContext context, String data) async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().addToCartDelete + data);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        Get.back();

        return response.statusCode;
      } else if (response.statusCode == 401) {
        Get.back();

        tokenExpiredLogout();
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getAddToCartByUser() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getAddToCartByUser);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getProfile() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getProfile);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      }
    } catch (e) {
      Get.back();
    }
  }

  userLogout(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });
    if (prefs == null) {
      await initializePrefs();
    }
    prefs?.clear();
    GoogleSignIn().signOut();
    isDarkTheme.value = false;
    Get.changeThemeMode(
      isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
    );
    var locale = Locale('en', 'US');
    Get.updateLocale(locale);
    language = 'en';
    accessToken = '';
    userId = '';
    userName = '';
    userImage = '';

    Get.back();
    Get.offAll(() => PreLoginScreen(), transition: Transition.leftToRight);
  }

  getArticles() async {
    final uri = Uri.parse(ApiPoint().getArticles + promotorId);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  getAllProductListByUser() async {
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getAllProductListByUser);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      } else if (response.statusCode == 401) {
        tokenExpiredLogout();
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  ticketBooking(BuildContext context, dynamic data, String eventName) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().ticketBooking);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    final jsonBody = jsonEncode(data);

    try {
      http.Response response =
          await http.post(uri, headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);
        Get.back();
        return res_data;
      } else if (response.statusCode == 401) {
        Get.back();
        tokenExpiredLogout();
      } else {
        Get.back();
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  shopProduct(BuildContext context, dynamic data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().shopCheckout);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    final jsonBody = jsonEncode(data);

    try {
      http.Response response =
          await http.post(uri, headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);
        Get.back();
        return res_data;
      } else if (response.statusCode == 401) {
        Get.back();
        tokenExpiredLogout();
      } else {
        Get.back();
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  createOrder(BuildContext context, dynamic data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().createOrder);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
        });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    final jsonBody = jsonEncode(data);

    try {
      http.Response response =
          await http.post(uri, headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);
        Get.back();
        if (res_data['isSuccess']) {
          Get.to(() => PaymentWebViewScreen(
                url: res_data['token'].toString(),
                type: 'TICKET',
              ));
        } else {
          customSnackBar('error'.tr, 'somethingWentWrong'.tr);
        }
      } else if (response.statusCode == 401) {
        Get.back();
        tokenExpiredLogout();
      } else {
        Get.back();
        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  tokenExpiredLogout() async {
    try {
      if (prefs == null) {
        await initializePrefs();
      }
      prefs?.clear();
      GoogleSignIn().signOut();
      isDarkTheme.value = false;
      Get.changeThemeMode(
        isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
      );
      var locale = Locale('en', 'US');
      Get.updateLocale(locale);
      language = 'en';
      accessToken = '';
      userId = '';
      userName = '';
      userImage = '';

      Get.offAll(() => PreLoginScreen(), transition: Transition.leftToRight);
      customSnackBar('alert'.tr, "Session expired please signin again");
    } catch (e) {
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }
}
