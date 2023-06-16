import 'dart:convert';

List<FAQModel> fAQModelFromJson(List data) =>
    List<FAQModel>.from(data.map((x) => FAQModel.fromJson(x)));

String fAQModelToJson(List<FAQModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FAQModel {
  num? id;
  String? fAQType;
  String? fAQQuestion;
  String? fAQAnswer;

  FAQModel({this.id, this.fAQType, this.fAQQuestion, this.fAQAnswer});

  FAQModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fAQType = json['FAQType'];
    fAQQuestion = json['FAQQuestion'];
    fAQAnswer = json['FAQAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FAQType'] = this.fAQType;
    data['FAQQuestion'] = this.fAQQuestion;
    data['FAQAnswer'] = this.fAQAnswer;
    return data;
  }
}
