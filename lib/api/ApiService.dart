import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:tiqarte/api/ApiPoint.dart';
import 'package:tiqarte/helper/common.dart';

class ApiService {
  googleSignIn(BuildContext context) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return WillPopScope(onWillPop: () async => false, child: spinkit);
    //     });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = await GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        // var data = {
        //   "identifier": googleUser.email.toString(),
        //   "socialID": googleUser.id.toString(),
        //   "socialToken": googleAuth.accessToken.toString(),
        //   "loginType": "google",
        //   "latitude": latitude,
        //   "longitude": longitude,
        //   "notificationToken": fcmToken,
        // };
        // userName = googleUser.displayName.toString();
        // userLogin(context, data);
      }

      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      //  Get.back();
      customSnackBar("Error!", e.toString());
    }
  }

  getHomeData() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getHomeData);

    final headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      }
      return "Something went wrong!";
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  getEvents() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().GetEvents);

    final headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      }
      return "Something went wrong!";
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  getEventDetail(String id) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getEventDetail + id);

    final headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      }
      return "Something went wrong!";
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  getCategories() async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getCategory);

    final headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      }
      return "Something went wrong!";
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  getFavorites(String userId) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().getfavList + userId);

    final headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      }
      return "Something went wrong!";
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  addFavorite(String data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().setFav + data);

    final headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var res_data = json.decode(response.body);

        return res_data;
      }
      return "Something went wrong!";
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }

  removeFavorite(BuildContext context, String data) async {
    final uri = Uri.parse(ApiPoint().baseUrl + ApiPoint().setFav + data);

    final headers = {'Content-Type': 'application/json'};

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
      }
      return "Something went wrong!";
    } catch (e) {
      Get.back();
      customSnackBar("Error!", "Something went wrong!");
    }
  }
}
