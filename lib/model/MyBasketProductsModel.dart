import 'dart:convert';

List<MyBasketProductsModel> myBasketProductsModelFromJson(List data) =>
    List<MyBasketProductsModel>.from(
        data.map((x) => MyBasketProductsModel.fromJson(x)));

String myBasketProductsModelToJson(List<MyBasketProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBasketProductsModel {
  num? id;
  num? productId;
  String? productName;
  String? description;
  double? price;
  String? productURLs;
  List<Attributes>? attributes;
  num? quantity;

  MyBasketProductsModel(
      {this.id,
      this.productId,
      this.productName,
      this.description,
      this.price,
      this.productURLs,
      this.attributes,
      this.quantity});

  MyBasketProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    productId = json['ProductId'];
    productName = json['ProductName'];
    description = json['Description'];
    price = json['Price'];
    productURLs = json['ProductURLs'];
    if (json['Attributes'] != null) {
      attributes = <Attributes>[];
      json['Attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProductId'] = this.productId;
    data['ProductName'] = this.productName;
    data['Description'] = this.description;
    data['Price'] = this.price;
    data['ProductURLs'] = this.productURLs;
    if (this.attributes != null) {
      data['Attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['Quantity'] = this.quantity;
    return data;
  }
}

class Attributes {
  String? attributeName;
  String? variationName;

  Attributes({this.attributeName, this.variationName});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributeName = json['AttributeName'];
    variationName = json['VariationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AttributeName'] = this.attributeName;
    data['VariationName'] = this.variationName;
    return data;
  }
}
