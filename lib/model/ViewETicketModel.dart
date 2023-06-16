class ViewETicketModel {
  String? event;
  String? eventDate;
  String? location;
  String? organizer;
  String? fullName;
  String? nickName;
  String? gender;
  String? dOB;
  String? country;
  String? mobileNo;
  String? email;
  List<TicketBookingDetail>? ticketBookingDetail;
  String? paymentMethod;
  num? orderId;
  String? status;
  String? barcodeURL;
  String? qRcodeURL;

  ViewETicketModel(
      {this.event,
      this.eventDate,
      this.location,
      this.organizer,
      this.fullName,
      this.nickName,
      this.gender,
      this.dOB,
      this.country,
      this.mobileNo,
      this.email,
      this.ticketBookingDetail,
      this.paymentMethod,
      this.orderId,
      this.status,
      this.barcodeURL,
      this.qRcodeURL});

  ViewETicketModel.fromJson(Map<String, dynamic> json) {
    event = json['Event'];
    eventDate = json['EventDate'];
    location = json['Location'];
    organizer = json['Organizer'];
    fullName = json['FullName'];
    nickName = json['NickName'];
    gender = json['Gender'];
    dOB = json['DOB'];
    country = json['Country'];
    mobileNo = json['MobileNo'];
    email = json['Email'];
    if (json['TicketBookingDetail'] != null) {
      ticketBookingDetail = <TicketBookingDetail>[];
      json['TicketBookingDetail'].forEach((v) {
        ticketBookingDetail!.add(new TicketBookingDetail.fromJson(v));
      });
    }
    paymentMethod = json['PaymentMethod'];
    orderId = json['OrderId'];
    status = json['Status'];
    barcodeURL = json['BarcodeURL'];
    qRcodeURL = json['QRcodeURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Event'] = this.event;
    data['EventDate'] = this.eventDate;
    data['Location'] = this.location;
    data['Organizer'] = this.organizer;
    data['FullName'] = this.fullName;
    data['NickName'] = this.nickName;
    data['Gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['Country'] = this.country;
    data['MobileNo'] = this.mobileNo;
    data['Email'] = this.email;
    if (this.ticketBookingDetail != null) {
      data['TicketBookingDetail'] =
          this.ticketBookingDetail!.map((v) => v.toJson()).toList();
    }
    data['PaymentMethod'] = this.paymentMethod;
    data['OrderId'] = this.orderId;
    data['Status'] = this.status;
    data['BarcodeURL'] = this.barcodeURL;
    data['QRcodeURL'] = this.qRcodeURL;
    return data;
  }
}

class TicketBookingDetail {
  String? ticketType;
  num? ticketCount;
  num? ticketPrice;
  num? taxAmount;

  TicketBookingDetail(
      {this.ticketType, this.ticketCount, this.ticketPrice, this.taxAmount});

  TicketBookingDetail.fromJson(Map<String, dynamic> json) {
    ticketType = json['TicketType'];
    ticketCount = json['TicketCount'];
    ticketPrice = json['TicketPrice'];
    taxAmount = json['TaxAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TicketType'] = this.ticketType;
    data['TicketCount'] = this.ticketCount;
    data['TicketPrice'] = this.ticketPrice;
    data['TaxAmount'] = this.taxAmount;
    return data;
  }
}
