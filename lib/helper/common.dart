import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tiqarte/helper/colors.dart';

SpinKitCircle spinkit = SpinKitCircle(
  color: kPrimaryColor,
  size: 50.0,
);

const OutlineInputBorder customOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide.none,
);

final textRegExp = RegExp('[a-zA-Z]*');

customButton(String text, Color color) {
  return Container(
    height: 50,
    width: 0.9.sw,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(50.0)),
    child: Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white)),
    ),
  );
}
