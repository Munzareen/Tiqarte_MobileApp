import 'dart:convert';

List<MerchandiseOrderHistoryModel> merchandiseOrderHistoryModelFromJson(
        List data) =>
    List<MerchandiseOrderHistoryModel>.from(
        data.map((x) => MerchandiseOrderHistoryModel.fromJson(x)));

String merchandiseOrderHistoryModelToJson(
        List<MerchandiseOrderHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MerchandiseOrderHistoryModel {
  num? id;
  num? orderNo;
  List<CheckOutProducts>? checkOutProducts;
  num? userId;
  String? customerName;
  String? customerEmail;
  String? state;
  String? city;
  String? postalCode;
  String? mobileNumber;
  String? purchaseDate;

  MerchandiseOrderHistoryModel(
      {this.id,
      this.orderNo,
      this.checkOutProducts,
      this.userId,
      this.customerName,
      this.customerEmail,
      this.state,
      this.city,
      this.postalCode,
      this.mobileNumber,
      this.purchaseDate});

  MerchandiseOrderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    orderNo = json['OrderNo'];
    if (json['CheckOutProducts'] != null) {
      checkOutProducts = <CheckOutProducts>[];
      json['CheckOutProducts'].forEach((v) {
        checkOutProducts!.add(new CheckOutProducts.fromJson(v));
      });
    }
    userId = json['UserId'];
    customerName = json['CustomerName'];
    customerEmail = json['CustomerEmail'];
    state = json['State'];
    city = json['City'];
    postalCode = json['PostalCode'];
    mobileNumber = json['MobileNumber'];
    purchaseDate = json['PurchaseDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['OrderNo'] = this.orderNo;
    if (this.checkOutProducts != null) {
      data['CheckOutProducts'] =
          this.checkOutProducts!.map((v) => v.toJson()).toList();
    }
    data['UserId'] = this.userId;
    data['CustomerName'] = this.customerName;
    data['CustomerEmail'] = this.customerEmail;
    data['State'] = this.state;
    data['City'] = this.city;
    data['PostalCode'] = this.postalCode;
    data['MobileNumber'] = this.mobileNumber;
    data['PurchaseDate'] = this.purchaseDate;
    return data;
  }
}

class CheckOutProducts {
  num? id;
  num? checkOutId;
  String? productName;
  List<AttributeNames>? attributeNames;
  num? quantity;

  CheckOutProducts(
      {this.id,
      this.checkOutId,
      this.productName,
      this.attributeNames,
      this.quantity});

  CheckOutProducts.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    checkOutId = json['CheckOutId'];
    productName = json['ProductName'];
    if (json['AttributeNames'] != null) {
      attributeNames = <AttributeNames>[];
      json['AttributeNames'].forEach((v) {
        attributeNames!.add(new AttributeNames.fromJson(v));
      });
    }
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CheckOutId'] = this.checkOutId;
    data['ProductName'] = this.productName;
    if (this.attributeNames != null) {
      data['AttributeNames'] =
          this.attributeNames!.map((v) => v.toJson()).toList();
    }
    data['Quantity'] = this.quantity;
    return data;
  }
}

class AttributeNames {
  String? attributeName;
  String? variationName;

  AttributeNames({this.attributeName, this.variationName});

  AttributeNames.fromJson(Map<String, dynamic> json) {
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
