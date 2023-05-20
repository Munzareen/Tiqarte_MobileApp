import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiqarte/api/ApiPoint.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/view/MainScreen.dart';

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
          "userImage": googleUser.photoUrl
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
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        Get.back();

        var res_data = json.decode(response.body);
        accessToken = res_data['data'];
        userId = getUserIdFromJWT(accessToken);
        userName = userData["userName"];
        userImage = userData["userImage"];
        _prefs.setString("accessToken", accessToken);
        _prefs.setString("userName", userName);
        _prefs.setString("userImage", userImage);

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
      } else {
        return "Something went wrong!";
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
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: () async => false, child: spinkit);
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
        Uri.parse(ApiPoint().baseUrl + ApiPoint().getOrganizerDetail + id);

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
}
