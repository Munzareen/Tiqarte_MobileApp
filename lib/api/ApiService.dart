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
import 'package:tiqarte/view/MainScreen.dart';
import 'package:tiqarte/view/MyBasketScreen.dart';
import 'package:tiqarte/view/OtpVerificationScreen.dart';
import 'package:tiqarte/view/PreLoginScreen.dart';

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
          Get.offAll(() => OtpVerificationScreen(email: data['email']!),
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

  verifyOtp(BuildContext context, String email, String data) async {
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
        if (res_data is Map && res_data['isSuccess']) {
          userEmail = email;
          Get.offAll(() => AccountSetupScreen(email: email),
              transition: Transition.rightToLeft);
        } else {
          customSnackBar('error'.tr, 'Invalid code');
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
            Get.offAll(() => OtpVerificationScreen(email: data['email']!),
                transition: Transition.rightToLeft);
          } else if (!res_data['isProfileCompleted']) {
            Get.offAll(() => AccountSetupScreen(email: data['email']!),
                transition: Transition.rightToLeft);
          } else {
            Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
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

  generateOtpTemp(BuildContext context, String email) async {
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
        customSnackBar('success', 'Otp successfully sent');
      } else {
        Get.back();

        customSnackBar('error'.tr, 'somethingWentWrong'.tr);
      }
    } catch (e) {
      Get.back();
      customSnackBar('error'.tr, 'somethingWentWrong'.tr);
    }
  }

  updateProfile(
      BuildContext context, Map<String, String> data, File? imageFile) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().updateProfile);

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

      if (imageFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'imageUrl', imageFile.path,
            filename: imageFile.path.split('/').last,
            contentType: MediaType("image", "jpg"));
        request.files.add(multipartFile);
      }

      //String jsonBody = json.encode(request.fields);

      var response = await request.send();

      final res = await http.Response.fromStream(response);
      var res_data = json.decode(res.body.toString());

      if (res.statusCode == 200) {
      } else if (!res_data['status']) {
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
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getEventSearch + searchQuery);
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
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getAllProductList);

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
    final uri =
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getEventByLocation + latLng);

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
            'ticketCancelBookingRefundString'.tr,
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
