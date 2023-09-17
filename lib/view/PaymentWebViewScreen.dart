import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/view/MainScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;
  final String type;
  PaymentWebViewScreen({Key? key, required this.url, required this.type})
      : super(key: key);

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              // print the loading progress to the console
              // you can use this value to show a progress bar if you want
              debugPrint("Loading: $progress%");
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              if (url.toString().toUpperCase().contains("SUCCESS")) {
                Get.back();
                if (widget.type.toUpperCase().contains("TICKET")) {
                  customAlertDialogWithTwoButtons(
                      context,
                      backgroundLogo,
                      Icons.verified_user_sharp,
                      'congratulations'.tr,
                      '',
                      'viewETicket'.tr,
                      'cancel'.tr, () {
                    Get.back();
                    Get.offAll(() => MainScreen(),
                        transition: Transition.cupertinoDialog);
                  }, () {
                    Get.back();
                    Get.offAll(() => MainScreen(),
                        transition: Transition.cupertinoDialog);
                  });
                } else {
                  customAlertDialogWithTwoButtons(
                      context,
                      backgroundLogo,
                      Icons.verified_user_sharp,
                      'congratulations'.tr,
                      'placeOrderSuccess'.tr,
                      'shopMore'.tr,
                      'cancel'.tr, () {
                    Get.back();
                    Get.offAll(() => MainScreen(),
                        transition: Transition.cupertinoDialog);
                  }, () {
                    Get.back();
                    Get.offAll(() => MainScreen(),
                        transition: Transition.cupertinoDialog);
                  });
                }
              } else if (url.toString().toUpperCase().contains("FAILER")) {
                Get.back();
              }
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange urlChange) {}),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: WebViewWidget(
              controller: _controller,
            )),
      ),
    );
  }
}
