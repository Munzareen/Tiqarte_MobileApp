import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/TicketScreen.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({super.key});

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  int _selectedValue = -1;

  final _otherReasonController = TextEditingController();
  Color filledColorOther = kDisabledColor.withOpacity(0.4);
  final _otherReasonFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _otherReasonFocusNode.addListener(() {
      if (_otherReasonFocusNode.hasFocus) {
        setState(() {
          filledColorOther = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          filledColorOther = kDisabledColor.withOpacity(0.4);
        });
      }
    });
  }

  @override
  void dispose() {
    _otherReasonFocusNode.dispose();
    _otherReasonController.dispose();

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
            child: Column(
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
                    customRadioButton(1, ticketCancelBookingReason1String),
                    customRadioButton(2, ticketCancelBookingReason2String),
                    customRadioButton(3, ticketCancelBookingReason3String),
                    customRadioButton(4, ticketCancelBookingReason4String),
                    customRadioButton(5, ticketCancelBookingReason5String),
                    customRadioButton(6, ticketCancelBookingReason6String),
                    customRadioButton(7, ticketCancelBookingReason7String),
                    20.verticalSpace,
                    Text(
                      ticketCancelBookingReasonOthersString,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      height: 90,
                      child: TextFormField(
                        focusNode: _otherReasonFocusNode,
                        cursorColor: kPrimaryColor,
                        controller: _otherReasonController,
                        keyboardType: TextInputType.text,
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
                            hintText: ticketCancelBookingReasonOthersSubString,
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
                    InkWell(
                      onTap: () {
                        customAlertDialogWithOneButton(
                            context,
                            backgroundLogo,
                            Icons.verified_user,
                            ticketCancelBookingSuccessfulString,
                            ticketCancelBookingRefundString,
                            ticketCancelBookingOKString, () {
                          Get.off(() => TicketScreen(),
                              transition: Transition.leftToRight);
                        });
                      },
                      child: customButton(
                          ticketCancelBookingHeadingString, kPrimaryColor),
                    ),
                    20.verticalSpace
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  customRadioButton(int value, String name) {
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
      groupValue: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value!;
        });
      },
    );
  }
}
