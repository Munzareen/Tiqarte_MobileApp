import 'dart:async';

import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  Timer? timer;
  int remainSeconds = 1;
  final time = '60'.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer(59);
  }

  startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        // int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value =
            //  minutes.toString().padLeft(2, "0") +
            //     ":" +
            seconds.toString().padLeft(2, "0");
        remainSeconds--;
      }
    });
  }
}
