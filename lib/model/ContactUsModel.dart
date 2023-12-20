class ContactUsModel {
  int? id;
  int? promotorId;
  String? customerService;
  String? whatsAppNumber;
  String? websiteAddress;
  String? emailAddress;
  String? facebookId;
  String? twitterId;
  String? instagramId;
  String? linkedInId;
  String? address;

  ContactUsModel(
      {this.id,
      this.promotorId,
      this.customerService,
      this.whatsAppNumber,
      this.websiteAddress,
      this.emailAddress,
      this.facebookId,
      this.twitterId,
      this.instagramId,
      this.linkedInId,
      this.address});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    promotorId = json['PromotorId'];
    customerService = json['CustomerService'];
    whatsAppNumber = json['WhatsAppNumber'];
    websiteAddress = json['WebsiteAddress'];
    emailAddress = json['EmailAddress'];
    facebookId = json['FacebookId'];
    twitterId = json['TwitterId'];
    instagramId = json['InstagramId'];
    linkedInId = json['LinkedInId'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['PromotorId'] = this.promotorId;
    data['CustomerService'] = this.customerService;
    data['WhatsAppNumber'] = this.whatsAppNumber;
    data['WebsiteAddress'] = this.websiteAddress;
    data['EmailAddress'] = this.emailAddress;
    data['FacebookId'] = this.facebookId;
    data['TwitterId'] = this.twitterId;
    data['InstagramId'] = this.instagramId;
    data['LinkedInId'] = this.linkedInId;
    data['Address'] = this.address;
    return data;
  }
}
