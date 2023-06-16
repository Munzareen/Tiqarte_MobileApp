import 'package:get/get.dart';

class BookEventController extends GetxController {
  int economySeatCount = 1;
  int vipSeatCount = 1;
  double? baseEconomyPrice = null;
  double? economyPrice = null;
  double? baseVipPrice = null;
  double? vipPrice = null;

  subtractEconomy() {
    if (economySeatCount > 1) {
      economySeatCount--;
      economyPrice = economyPrice! - baseEconomyPrice!;
      update();
    }
  }

  addEconomy() {
    economySeatCount++;
    economyPrice = economyPrice! + baseEconomyPrice!;
    update();
  }

  subtractVip() {
    if (vipSeatCount > 1) {
      vipSeatCount--;
      vipPrice = vipPrice! - baseVipPrice!;
      update();
    }
  }

  addVip() {
    vipSeatCount++;
    vipPrice = vipPrice! + baseVipPrice!;
    update();
  }
}
