import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/cancelBookingController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/strings.dart';

class CancelBookingScreen extends StatefulWidget {
  final String ticketUniqueNumber;
  const CancelBookingScreen({super.key, required this.ticketUniqueNumber});

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  final _cancelBookingController = Get.put(CancelBookingController());

  @override
  void dispose() {
    _cancelBookingController.selectedValue = -1;
    _cancelBookingController.otherSelectedValue = -1;
    _cancelBookingController.otherReasonController.clear();
    _cancelBookingController.otherReasonEnabled = false;

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
          //   backgroundColor: kSecondBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GetBuilder<CancelBookingController>(builder: (_cbc) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.arrow_back)),
                      10.horizontalSpace,
                      Text(
                        ticketCancelBookingHeadingString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Expanded(
                      child: ListView(
                    children: [
                      FittedBox(
                        child: Text(
                          ticketCancelBookingSelectReasonString,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      Divider(),
                      10.verticalSpace,
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _cbc.definedReasons.length,
                        itemBuilder: (context, index) {
                          return customRadioButton(
                              _cbc.definedReasons[index]['value'],
                              _cbc.definedReasons[index]['name'],
                              index);
                        },
                      ),
                      20.verticalSpace,
                      RadioListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        activeColor: kPrimaryColor,
                        title: Text(
                          ticketCancelBookingReasonOthersString,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: 1,
                        groupValue: _cancelBookingController.otherSelectedValue,
                        onChanged: (value) {
                          _cancelBookingController
                              .changeOtherSelectedValue(value!);
                        },
                      ),
                      20.verticalSpace,
                      Container(
                        height: 90,
                        child: TextFormField(
                          focusNode: _cbc.otherReasonFocusNode,
                          cursorColor: kPrimaryColor,
                          controller: _cbc.otherReasonController,
                          keyboardType: TextInputType.text,
                          enabled: _cbc.otherReasonEnabled,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please enter your username';
                          //   }
                          //   return null;
                          // },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 90.0, horizontal: 10.0),
                              errorBorder: customOutlineBorder,
                              enabledBorder: customOutlineBorder,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              disabledBorder: customOutlineBorder,
                              //  fillColor: filledColorOther,
                              filled: true,
                              hintText:
                                  ticketCancelBookingReasonOthersSubString,
                              hintStyle: TextStyle(
                                  color: Color(0xff9E9E9E), fontSize: 14)),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(textRegExp),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      Divider(),
                      20.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          if (_cbc.selectedValue == -1 &&
                              _cbc.otherSelectedValue == -1) {
                            customSnackBar(alert, "Please Select your reason");
                          } else {
                            if (_cbc.otherSelectedValue != -1 &&
                                _cbc.otherReasonController.text
                                    .trim()
                                    .isEmpty) {
                              customSnackBar(alert, "Please enter your reason");
                            } else if (_cbc.otherSelectedValue != -1 &&
                                _cbc.otherReasonController.text
                                    .trim()
                                    .isNotEmpty) {
                              ApiService().eventCancel(
                                  context,
                                  widget.ticketUniqueNumber,
                                  _cbc.otherReasonController.text.trim());
                            } else {
                              dynamic reason = _cbc.definedReasons.firstWhere(
                                  (element) => element['isSelected'] = true);
                              ApiService().eventCancel(context,
                                  widget.ticketUniqueNumber, reason['name']);
                            }
                          }
                        },
                        child: customButton(
                            ticketCancelBookingHeadingString, kPrimaryColor),
                      ),
                      20.verticalSpace
                    ],
                  ))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  customRadioButton(int value, String name, int index) {
    return RadioListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      activeColor: kPrimaryColor,
      title: Text(
        name,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: value,
      groupValue: _cancelBookingController.selectedValue,
      onChanged: (value) {
        _cancelBookingController.changeSelectedValue(value!, index);
      },
    );
  }
}
