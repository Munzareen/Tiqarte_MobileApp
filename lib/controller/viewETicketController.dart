import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:tiqarte/model/ViewETicketModel.dart';

class ViewETicketController extends GetxController {
  ViewETicketModel? viewETicketModel = ViewETicketModel();

  TicketBookingDetail? economy;
  TicketBookingDetail? vip;

  addETicketData(dynamic data) async {
    viewETicketModel = ViewETicketModel.fromJson(data);
    if (viewETicketModel!.ticketBookingDetail!.isNotEmpty) {
      viewETicketModel!.ticketBookingDetail!.forEach((element) {
        if (element.ticketType!.toUpperCase().contains("ECO")) {
          economy = element;
        } else if (element.ticketType!.toUpperCase().contains("VIP")) {
          vip = element;
        }
      });
    }

    if (viewETicketModel?.location != null) {
      double lat = double.parse(viewETicketModel!.location!.split(",").first);
      double long = double.parse(viewETicketModel!.location!.split(",").last);
      viewETicketModel!.location = '';
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      Placemark place = placemarks[0];
      viewETicketModel!.location =
          "${place.street}, ${place.subAdministrativeArea}, ${place.country}";
    }
    update();
  }
}
