import 'package:get/get.dart';

class BookEventController extends GetxController {
  int? eventId;
  String eventName = '';
  int economySeatCount = 0;
  int vipSeatCount = 0;
  int? economyId;
  int? vipId;
  double? baseEconomyPrice = null;
  double? economyPrice = null;
  double? baseVipPrice = null;
  double? vipPrice = null;

  String ticketId = '';

  subtractEconomy() {
    if (economySeatCount > 0) {
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
    if (vipSeatCount > 0) {
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
