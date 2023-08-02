import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tiqarte/api/ApiPoint.dart';
import 'package:tiqarte/controller/ticketController.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/model/TicketModel.dart';
import 'package:tiqarte/view/AccountSetupScreen.dart';
import 'package:tiqarte/view/MainScreen.dart';
import 'package:tiqarte/view/MyBasketScreen.dart';
import 'package:tiqarte/view/OtpVerificationScreen.dart';
import 'package:tiqarte/view/PreLoginScreen.dart';

class ApiService {
  // register(
  //     BuildContext context, Map<String, String> data ) async {
  //   final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().register);

  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return WillPopScope(onWillPop: () async => false, child: spinkit);
  //       });
  //   final headers = {
  //     'Content-Type': 'application/json',
  //   };

  //   try {
  //     var request = http.MultipartRequest('POST', uri);

  //     request.fields.addAll(data);
  //     request.headers.addAll(headers);

  //     //String jsonBody = json.encode(request.fields);

  //     var response = await request.send();

  //     final res = await http.Response.fromStream(response);

  //     if (res.statusCode == 200) {

  //               Get.back();

  //         Get.offAll(() => OtpVerificationScreen(),
  //           transition: Transition.rightToLeft);
  //     } else{
  //       Get.back();
  //     customSnackBar(error, somethingWentWrong);
  //     }
  //   } catch (e) {
  //     Get.back();
  //     customSnackBar(error, somethingWentWrong);
  //   }
  // }
  register(BuildContext context, dynamic data) async {
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
      String jsonBody = json.encode(data);

      http.Response response =
          await http.post(uri, headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        Get.back();

        var res_data = json.decode(response.body);

        Get.offAll(() => OtpVerificationScreen(),
            transition: Transition.rightToLeft);
      } else {
        Get.back();

        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
    }
  }

  verifyOtp(BuildContext context, String otp) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().verifyOtp + otp);

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

        Get.offAll(() => AccountSetupScreen(),
            transition: Transition.rightToLeft);
      } else {
        Get.back();

        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
    }
  }

  login(BuildContext context, dynamic data) async {
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
      String jsonBody = json.encode(data);

      http.Response response =
          await http.post(uri, headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        Get.back();

        var res_data = json.decode(response.body);

        return res_data;
      } else {
        Get.back();

        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
    }
  }

  updateProfile(
      BuildContext context, Map<String, String> data, File imageFile) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().updateProfile);

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
      var request = http.MultipartRequest('POST', uri);

      request.fields.addAll(data);
      request.headers.addAll(headers);

      var multipartFile = await http.MultipartFile.fromPath(
          'imageUrl', imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: MediaType("image", "jpg"));
      request.files.add(multipartFile);

      //String jsonBody = json.encode(request.fields);

      var response = await request.send();

      final res = await http.Response.fromStream(response);
      var res_data = json.decode(res.body.toString());

      if (res.statusCode == 200) {
      } else if (!res_data['status']) {
        Get.back();
        customSnackBar("Error!", res_data['message']);
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
      customSnackBar(error, somethingWentWrong);
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

        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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

        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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

        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        return somethingWentWrong;
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
            ticketCancelBookingSuccessfulString,
            ticketCancelBookingRefundString,
            ticketCancelBookingOKString, () {
          Get.back();
          Get.back();
        });
      } else if (response.statusCode == 401) {
        Get.back();
        tokenExpiredLogout();
      } else {
        Get.back();
        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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

        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      Get.back();

      customSnackBar(error, somethingWentWrong);
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
        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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

        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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

        customSnackBar(error, somethingWentWrong);
      }
    } catch (e) {
      Get.back();
      customSnackBar(error, somethingWentWrong);
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
      customSnackBar(error, somethingWentWrong);
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
    accessToken = '';
    userId = '';
    userName = '';
    userImage = '';

    Get.back();
    Get.offAll(() => PreLoginScreen(), transition: Transition.leftToRight);
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
      accessToken = '';
      userId = '';
      userName = '';
      userImage = '';

      Get.offAll(() => PreLoginScreen(), transition: Transition.leftToRight);
      customSnackBar(alert, "Session expired please signin again");
    } catch (e) {
      customSnackBar(error, somethingWentWrong);
    }
  }
}
