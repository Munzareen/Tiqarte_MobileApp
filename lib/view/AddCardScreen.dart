import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/PaymentScreen.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  bool _isCardNumberEnabled = false;
  bool _isExpiryDateEnabled = false;
  bool _isCvvEnabled = false;

  TextEditingController _controller = TextEditingController();

  List<TextInputFormatter> _cardNumberFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(numberRegExp),
    LengthLimitingTextInputFormatter(16),
    CustomFormatter(),
  ];

  final _formKey = GlobalKey<FormState>();

  final _cardNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _cvvController = TextEditingController();
  final _expiryDateController = TextEditingController();

  final _cardNameFocusNode = FocusNode();
  final _cardNumberFocusNode = FocusNode();
  final _cvvFocusNode = FocusNode();

  Color _filledColorCardName = kDisabledColor.withOpacity(0.4);
  Color _filledColorCardNumber = kDisabledColor.withOpacity(0.4);
  Color _filledColorCvv = kDisabledColor.withOpacity(0.4);

  @override
  void initState() {
    super.initState();

    _cardNameController.addListener(() {
      if (_cardNameController.text.isNotEmpty &&
          _cardNameController.text.contains(' ')) {
        setState(() {
          _isCardNumberEnabled = true;
        });
      } else {
        setState(() {
          _isCardNumberEnabled = false;
          _isExpiryDateEnabled = false;

          _isCvvEnabled = false;
        });
      }
    });

    _cardNumberController.addListener(() {
      if (_cardNumberController.text.length == 19) {
        setState(() {
          _isExpiryDateEnabled = true;
        });
      } else {
        setState(() {
          _isExpiryDateEnabled = false;
          _isCvvEnabled = false;
        });
      }
    });
    _expiryDateController.addListener(() {
      if (_expiryDateController.text.isNotEmpty) {
        setState(() {
          _isCvvEnabled = true;
        });
      } else {
        setState(() {
          _isCvvEnabled = false;
        });
      }
    });

    _cardNameFocusNode.addListener(() {
      if (_cardNameFocusNode.hasFocus) {
        setState(() {
          _filledColorCardName = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorCardName = kDisabledColor.withOpacity(0.4);
        });
      }
    });

    _cardNumberFocusNode.addListener(() {
      if (_cardNumberFocusNode.hasFocus) {
        setState(() {
          _filledColorCardNumber = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorCardNumber = kDisabledColor.withOpacity(0.4);
        });
      }
    });
    _cvvFocusNode.addListener(() {
      if (_cvvFocusNode.hasFocus) {
        setState(() {
          _filledColorCvv = kPrimaryColor.withOpacity(0.2);
        });
      } else {
        setState(() {
          _filledColorCvv = kDisabledColor.withOpacity(0.4);
        });
      }
    });
  }

  @override
  void dispose() {
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _cvvController.dispose();
    _expiryDateController.dispose();
    _cardNameFocusNode.dispose();
    _cardNumberFocusNode.dispose();
    _cvvFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondBackgroundColor,
      body: SafeArea(
          child: Container(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back)),
                        10.horizontalSpace,
                        Text(
                          addNewCard,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Image.asset(scanIcon),
                  ],
                ),
                20.verticalSpace,
                Container(
                  height: 0.3.sh,
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: AssetImage(cardBackgroundImage),
                        fit: BoxFit.fill,
                      )),
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mocard",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Amazon",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        width: 0.8.sw,
                        child: TextField(
                          controller: _cardNumberController,
                          enabled: false,
                          //   initialValue: '',
                          obscureText: true,
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          decoration: InputDecoration(
                            isDense: false,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // Text(
                      //   _cardNameController.text,
                      //   textAlign: TextAlign.center,
                      // style: TextStyle(
                      //     fontSize: 48,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cardHolderName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Container(
                                width: 0.3.sw,
                                child: TextField(
                                  controller: _cardNameController,
                                  enabled: false,
                                  //   initialValue: '',
                                  obscureText: true,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  decoration: InputDecoration(
                                    isDense: false,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // Text(
                              //   "...........",
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white),
                              // ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                expiryDate,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Container(
                                width: 0.2.sw,
                                child: TextField(
                                  controller: _expiryDateController,
                                  enabled: false,
                                  //   initialValue: '',
                                  obscureText: true,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  decoration: InputDecoration(
                                    isDense: false,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // Text(
                              //   "...........",
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white),
                              // ),
                            ],
                          ),
                          Image.asset(emptyCardLogo),
                        ],
                      )
                    ],
                  ),
                ),
                10.verticalSpace,
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        10.verticalSpace,
                        TextFormField(
                          cursorColor: kPrimaryColor,
                          controller: _cardNameController,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          focusNode: _cardNameFocusNode,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains(' ')) {
                              return 'Please enter full name';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                              errorBorder: customOutlineBorder,
                              enabledBorder: customOutlineBorder,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              disabledBorder: customOutlineBorder,
                              focusedErrorBorder: customOutlineBorder,
                              fillColor: _filledColorCardName,
                              filled: true,
                              hintText: cardName,
                              hintStyle: TextStyle(
                                  color: Color(0xff9E9E9E), fontSize: 14)),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(textRegExp),
                          ],
                        ),
                        10.verticalSpace,
                        Text(
                          cardNumber,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        10.verticalSpace,
                        TextFormField(
                          enabled: _isCardNumberEnabled,
                          cursorColor: kPrimaryColor,
                          controller: _cardNumberController,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          focusNode: _cardNumberFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter card number';
                            } else if (value.length != 19) {
                              return 'Please enter valid card number';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                              errorBorder: customOutlineBorder,
                              enabledBorder: customOutlineBorder,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              disabledBorder: customOutlineBorder,
                              focusedErrorBorder: customOutlineBorder,
                              fillColor: _filledColorCardNumber,
                              filled: true,
                              hintText: cardNumber,
                              hintStyle: TextStyle(
                                  color: Color(0xff9E9E9E), fontSize: 14)),
                          inputFormatters: _cardNumberFormatter,
                        ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  expiryDate,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                10.verticalSpace,
                                InkWell(
                                  onTap: () {
                                    _isExpiryDateEnabled
                                        ? _selectDate(context)
                                        : null;
                                  },
                                  child: Container(
                                    width: 0.4.sw,
                                    child: TextFormField(
                                      controller: _expiryDateController,
                                      enabled: false,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      cursorColor: kPrimaryColor,
                                      decoration: InputDecoration(
                                        hintText: expiryDate,
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
                                        focusedErrorBorder: customOutlineBorder,
                                        fillColor:
                                            kDisabledColor.withOpacity(0.4),
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cvv,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                10.verticalSpace,
                                Container(
                                  width: 0.4.sw,
                                  child: TextFormField(
                                    enabled: _isCvvEnabled,
                                    cursorColor: kPrimaryColor,
                                    controller: _cvvController,
                                    style: const TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.number,
                                    focusNode: _cvvFocusNode,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length != 3) {
                                        return 'Please enter 3 digit cvv';
                                      }

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        errorBorder: customOutlineBorder,
                                        enabledBorder: customOutlineBorder,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            borderSide: BorderSide(
                                                color: kPrimaryColor)),
                                        disabledBorder: customOutlineBorder,
                                        focusedErrorBorder: customOutlineBorder,
                                        fillColor: _filledColorCvv,
                                        filled: true,
                                        hintText: cvv,
                                        hintStyle: TextStyle(
                                            color: Color(0xff9E9E9E),
                                            fontSize: 14)),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          numberRegExp),
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
                20.verticalSpace,
                InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Get.off(() => PaymentScreen(),
                            transition: Transition.leftToRight,
                            preventDuplicates: false);
                      }
                    },
                    child: customButton(add, kPrimaryColor))
              ],
            ),
          ),
        ),
      )),
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
              colorScheme: ColorScheme.light(
                primary: kPrimaryColor,
                onPrimary: Colors.white,
                onSurface: kPrimaryColor,
              ),
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
        _expiryDateController.text = myFormat.format(picked).toString();

        FocusManager.instance.primaryFocus?.unfocus();
      });
    }
  }
}

class CustomFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i % 4 == 0 && i != 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    var string = buffer.toString();

    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
