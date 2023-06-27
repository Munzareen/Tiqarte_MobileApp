import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:tiqarte/api/ApiPoint.dart';
import 'package:tiqarte/controller/ticketController.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/model/TicketModel.dart';
import 'package:tiqarte/view/MainScreen.dart';
import 'package:tiqarte/view/MyBasketScreen.dart';
import 'package:tiqarte/view/PreLoginScreen.dart';

class ApiService {
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
      customSnackBar("Error!", "Something went wrong!");
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

        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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

        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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

        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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

        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      Get.back();

      customSnackBar("Error!", "Something went wrong!");
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
        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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

        customSnackBar("Error!", "Something went wrong!");
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
        var res_data = json.decode(response.body);
        Get.back();

        return res_data;
      } else if (response.statusCode == 401) {
        Get.back();

        tokenExpiredLogout();
      } else {
        Get.back();

        return "Something went wrong!";
      }
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
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
      customSnackBar("Error!", "Something went wrong!");
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
      customSnackBar("Alert!", "Session expired please signin again");
    } catch (e) {
      customSnackBar("Error!", "Something went wrong!");
    }
  }
}
