import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:tiqarte/api/ApiService.dart';
import 'package:tiqarte/controller/viewETicketController.dart';
import 'package:tiqarte/helper/colors.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/MainScreen.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ViewETicketScreen extends StatefulWidget {
  final String ticketUniqueNumber;
  const ViewETicketScreen({super.key, required this.ticketUniqueNumber});

  @override
  State<ViewETicketScreen> createState() => _ViewETicketScreenState();
}

class _ViewETicketScreenState extends State<ViewETicketScreen> {
  final _viewETicketController = Get.put(ViewETicketController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await ApiService().getETicket(widget.ticketUniqueNumber);
    if (res != null && res is Map) {
      _viewETicketController.addETicketData(res);
    }
  }

  @override
  void dispose() {
    _viewETicketController.viewETicketModel = null;
    _viewETicketController.economy = null;
    _viewETicketController.vip = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: GetBuilder<ViewETicketController>(builder: (_vetc) {
            return _vetc.viewETicketModel?.event == null
                ? Center(
                    child: spinkit,
                  )
                : Column(
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
                              Text(
                                eTicket,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color:
                                      Theme.of(context).colorScheme.background),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Icon(
                              Icons.more_horiz_sharp,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                          child: ListView(
                        children: [
                          //20.verticalSpace,
                          Container(
                            width: 1.sw,
                            child: CachedNetworkImage(
                              imageUrl:
                                  _vetc.viewETicketModel!.qRcodeURL.toString(),
                              placeholder: (context, url) => spinkit,
                              errorWidget: (context, url, error) => Icon(
                                Icons.error_outline,
                                size: 80,
                              ),
                            ),
                            // Image.network(
                            //   _vetc.viewETicketModel!.qRcodeURL.toString(),
                            //   height: 300,

                            // ),
                          ),
                          20.verticalSpace,
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customColumn(event,
                                    _vetc.viewETicketModel!.event.toString()),
                                15.verticalSpace,
                                customColumn(
                                    dateAndHour,
                                    EventDateForETicket(_vetc
                                        .viewETicketModel!.eventDate
                                        .toString())),
                                15.verticalSpace,
                                customColumn(
                                    eventLocation,
                                    _vetc.viewETicketModel!.location
                                        .toString()),
                                15.verticalSpace,
                                customColumn(
                                    eventOrganizer,
                                    _vetc.viewETicketModel!.organizer
                                        .toString()),
                              ],
                            ),
                          ),
                          20.verticalSpace,
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customRow(
                                    fullName,
                                    _vetc.viewETicketModel!.fullName
                                        .toString()),
                                10.verticalSpace,
                                customRow(
                                    nickName,
                                    _vetc.viewETicketModel!.nickName
                                        .toString()),
                                10.verticalSpace,
                                customRow(gender,
                                    _vetc.viewETicketModel!.gender.toString()),
                                10.verticalSpace,
                                customRow(dateOfBirth,
                                    _vetc.viewETicketModel!.dOB.toString()),
                                10.verticalSpace,
                                customRow(country,
                                    _vetc.viewETicketModel!.country.toString()),
                                10.verticalSpace,
                                customRow(
                                    phone,
                                    _vetc.viewETicketModel!.mobileNo
                                        .toString()),
                                10.verticalSpace,
                                customRow(email,
                                    _vetc.viewETicketModel!.email.toString()),
                              ],
                            ),
                          ),
                          20.verticalSpace,
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _vetc.economy != null
                                    ? Column(
                                        children: [
                                          customRow(
                                              "${int.parse(_vetc.economy!.ticketCount.toString())} $seat ($economy)",
                                              "\$${_vetc.economy!.ticketPrice.toString()}"),
                                          10.verticalSpace,
                                        ],
                                      )
                                    : SizedBox(),
                                _vetc.vip != null
                                    ? Column(
                                        children: [
                                          customRow(
                                              "${int.parse(_vetc.vip!.ticketCount.toString())} $seat ($vip)",
                                              "\$${_vetc.vip!.ticketPrice.toString()}"),
                                          10.verticalSpace,
                                        ],
                                      )
                                    : SizedBox(),
                                customRow(
                                    tax,
                                    _vetc.economy != null && _vetc.vip != null
                                        ? "\$${(_vetc.economy!.taxAmount! + _vetc.vip!.taxAmount!).toString()}"
                                        : _vetc.economy != null
                                            ? "\$${_vetc.economy!.taxAmount!.toString()}"
                                            : "\$${_vetc.vip!.taxAmount!.toString()}"),
                                10.verticalSpace,
                                Divider(
                                  color: kDisabledColor,
                                ),
                                10.verticalSpace,
                                customRow(
                                    total,
                                    _vetc.economy != null && _vetc.vip != null
                                        ? "\$${(_vetc.economy!.ticketPrice! + _vetc.vip!.ticketPrice!).toString()}"
                                        : _vetc.economy != null
                                            ? "\$${_vetc.economy!.ticketPrice!.toString()}"
                                            : "\$${_vetc.vip!.ticketPrice!.toString()}"),
                              ],
                            ),
                          ),
                          20.verticalSpace,
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customRow(
                                    paymentMethods,
                                    _vetc.viewETicketModel!.paymentMethod
                                        .toString()),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orderID,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          _vetc.viewETicketModel!.orderId
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        5.horizontalSpace,
                                        GestureDetector(
                                          onTap: () async {
                                            await Clipboard.setData(
                                                ClipboardData(
                                                    text: _vetc
                                                        .viewETicketModel!
                                                        .orderId
                                                        .toString()));

                                            customSnackBar("Information",
                                                "$orderID is copied to clipboard");
                                          },
                                          child: Image.asset(
                                            copyIcon,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      status,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                              color: kPrimaryColor,
                                              width: 1.5)),
                                      child: Text(
                                        paid,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          20.verticalSpace,
                        ],
                      )),
                      Container(
                        width: 1.sw,
                        color: Theme.of(context).secondaryHeaderColor,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: GestureDetector(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                          onWillPop: () async => false,
                                          child: spinkit);
                                    });
                                generatePDF(_vetc.viewETicketModel!.qRcodeURL
                                    .toString());
                              },
                              child:
                                  customButton(downloadTicket, kPrimaryColor),
                            )),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }

  customRow(String name, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Text(
          data,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  pwCustomRow(String name, String data) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          name,
          style: pw.TextStyle(fontSize: 15, color: PdfColors.grey700),
        ),
        pw.Text(
          data,
          style: pw.TextStyle(fontSize: 13, color: PdfColors.black),
        )
      ],
    );
  }

  pwCustomColumn(String name, String data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          name,
          style: pw.TextStyle(fontSize: 15, color: PdfColors.grey700),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          data,
          style: pw.TextStyle(fontSize: 13, color: PdfColors.black),
        )
      ],
    );
  }

  customColumn(String name, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        10.verticalSpace,
        Text(
          data,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Future<bool> onWillPop() {
    Get.offAll(() => MainScreen(), transition: Transition.leftToRight);

    return Future.value(false);
  }

  Future<pw.MemoryImage> fetchNetworkImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final image = pw.MemoryImage(bytes);
    return image;
  }

  generatePDF(String imageUrl) async {
    final pdf = pw.Document();
    final image = await fetchNetworkImage(imageUrl);
    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4.copyWith(
        width: 600,
        height: 1200,
      ),
    );
    pdf.addPage(
      pw.Page(
        pageTheme: pageTheme,
        build: (pw.Context context) {
          return pw.ListView(
            children: [
              //20.verticalSpace,
              pw.Container(
                  width: 1.sw,
                  // height: 200,
                  child: pw.Image(
                    image,
                  )),
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pwCustomColumn(
                        event,
                        _viewETicketController.viewETicketModel!.event
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomColumn(
                        dateAndHour,
                        EventDateForETicketForPDF(_viewETicketController
                            .viewETicketModel!.eventDate
                            .toString())),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomColumn(
                        eventLocation,
                        _viewETicketController.viewETicketModel!.location
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomColumn(
                        eventOrganizer,
                        _viewETicketController.viewETicketModel!.organizer
                            .toString()),
                    pw.SizedBox(
                      height: 30,
                    ),
                    pwCustomRow(
                        fullName,
                        _viewETicketController.viewETicketModel!.fullName
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomRow(
                        nickName,
                        _viewETicketController.viewETicketModel!.nickName
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomRow(
                        gender,
                        _viewETicketController.viewETicketModel!.gender
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomRow(
                        dateOfBirth,
                        _viewETicketController.viewETicketModel!.dOB
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomRow(
                        country,
                        _viewETicketController.viewETicketModel!.country
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomRow(
                        phone,
                        _viewETicketController.viewETicketModel!.mobileNo
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomRow(
                        email,
                        _viewETicketController.viewETicketModel!.email
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    if (_viewETicketController.economy != null)
                      pw.Column(
                        children: [
                          pwCustomRow(
                              "${int.parse(_viewETicketController.economy!.ticketCount.toString())} $seat ($economy)",
                              "\$${_viewETicketController.economy!.ticketPrice.toString()}"),
                          pw.SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    else
                      pw.SizedBox(),
                    if (_viewETicketController.vip != null)
                      pw.Column(
                        children: [
                          pwCustomRow(
                              "${int.parse(_viewETicketController.vip!.ticketCount.toString())} $seat ($vip)",
                              "\$${_viewETicketController.vip!.ticketPrice.toString()}"),
                          pw.SizedBox(height: 10),
                        ],
                      )
                    else
                      pw.SizedBox(),
                    pwCustomRow(
                        tax,
                        _viewETicketController.economy != null &&
                                _viewETicketController.vip != null
                            ? "\$${(_viewETicketController.economy!.taxAmount! + _viewETicketController.vip!.taxAmount!).toString()}"
                            : _viewETicketController.economy != null
                                ? "\$${_viewETicketController.economy!.taxAmount!.toString()}"
                                : "\$${_viewETicketController.vip!.taxAmount!.toString()}"),
                    pw.SizedBox(height: 5),
                    pw.Divider(
                      color: PdfColors.grey300,
                    ),
                    pw.SizedBox(height: 5),
                    pwCustomRow(
                        total,
                        _viewETicketController.economy != null &&
                                _viewETicketController.vip != null
                            ? "\$${(_viewETicketController.economy!.ticketPrice! + _viewETicketController.vip!.ticketPrice!).toString()}"
                            : _viewETicketController.economy != null
                                ? "\$${_viewETicketController.economy!.ticketPrice!.toString()}"
                                : "\$${_viewETicketController.vip!.ticketPrice!.toString()}"),
                    pw.SizedBox(
                      height: 30,
                    ),
                    pwCustomRow(
                        paymentMethods,
                        _viewETicketController.viewETicketModel!.paymentMethod
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pwCustomRow(
                        orderID,
                        _viewETicketController.viewETicketModel!.orderId
                            .toString()),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          status,
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.grey700),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(12.0),
                              border: pw.Border.all(width: 1.5)),
                          child: pw.Text(
                            paid,
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ],
          );
        },
      ),
    );

    final tempDir = await getTemporaryDirectory();
    final file = File(
        '${tempDir.path}/${_viewETicketController.viewETicketModel?.event.toString()}.pdf');
    await file.writeAsBytes(await pdf.save());

    final extDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final savedDir = extDir!.path;
    deletePdfFile(tempDir);

    final savedFile = await file.copy(
        '$savedDir/${_viewETicketController.viewETicketModel?.event.toString()}.pdf');

    Get.back();
    OpenFile.open(savedFile.path);
  }

  Future<void> deletePdfFile(Directory directory) async {
    try {
      if (await directory.exists()) {
        directory.deleteSync(recursive: true);
        print('Directory deleted successfully.');
      } else {
        print('Directory does not exist.');
      }
    } catch (e) {
      print('Failed to delete directory: $e');
    }
  }
}
