import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;
  PaymentWebViewScreen({Key? key, required this.url}) : super(key: key);

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
              print(url);
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange urlChange) {
              print(urlChange.url);
            }),
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
