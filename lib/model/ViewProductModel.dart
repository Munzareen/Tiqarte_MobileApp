// To parse this JSON data, do
//
//     final viewProductModel = viewProductModelFromJson(jsonString);

import 'dart:convert';

List<ViewProductModel> viewProductModelFromJson(List data) =>
    List<ViewProductModel>.from(data.map((x) => ViewProductModel.fromJson(x)));

String viewProductModelToJson(List<ViewProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewProductModel {
  num? id;
  String? sku;
  String? productName;
  String? description;
  String? deliveryDetails;
  num? price;
  num? catagoryId;
  String? productFor;
  bool? isActive;
  num? promotorId;
  String? createdDate;
  List<ProductImageUrLs>? productImageUrLs;
  List<Attribute>? attributes;

  ViewProductModel({
    this.id,
    this.sku,
    this.productName,
    this.description,
    this.deliveryDetails,
    this.price,
    this.catagoryId,
    this.productFor,
    this.isActive,
    this.promotorId,
    this.createdDate,
    this.productImageUrLs,
    this.attributes,
  });

  factory ViewProductModel.fromJson(Map<String, dynamic> json) =>
      ViewProductModel(
        id: json["Id"],
        sku: json["Sku"],
        productName: json["ProductName"],
        description: json["Description"],
        deliveryDetails: json["DeliveryDetails"],
        price: json["Price"],
        catagoryId: json["CatagoryId"],
        productFor: json["ProductFor"],
        isActive: json["isActive"],
        promotorId: json["PromotorId"],
        createdDate: json["CreatedDate"],
        productImageUrLs: json["ProductImageURLs"] != null
            ? convertJsonToProductImageUrLsList(json["ProductImageURLs"])
            : [],
        attributes: json["Attributes"] != null
            ? List<Attribute>.from(
                json["Attributes"].map((x) => Attribute.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Sku": sku,
        "ProductName": productName,
        "Description": description,
        "DeliveryDetails": deliveryDetails,
        "Price": price,
        "CatagoryId": catagoryId,
        "ProductFor": productFor,
        "isActive": isActive,
        "PromotorId": promotorId,
        "CreatedDate": createdDate,
        "ProductImageURLs": List<dynamic>.from(productImageUrLs!.map((x) => x)),
        "Attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}

List<ProductImageUrLs> convertJsonToProductImageUrLsList(
    List<dynamic> jsonImages) {
  List<ProductImageUrLs> imagesUrl = [];

  for (String imageUrl in jsonImages) {
    ProductImageUrLs productImageUrLs = ProductImageUrLs(imageUrl: imageUrl);
    imagesUrl.add(productImageUrLs);
  }

  return imagesUrl;
}

class ProductImageUrLs {
  String? imageUrl;
  bool? isSelected;

  ProductImageUrLs({
    this.imageUrl,
    this.isSelected = false,
  });
}

class Attribute {
  num? id;
  num? productId;
  String? attributeName;
  String? attributeDescription;
  List<Variation>? variations;

  Attribute({
    this.id,
    this.productId,
    this.attributeName,
    this.attributeDescription,
    this.variations,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["Id"],
        productId: json["ProductId"],
        attributeName: json["AttributeName"],
        attributeDescription: json["AttributeDescription"],
        variations: json["Variations"] != null
            ? List<Variation>.from(
                json["Variations"].map((x) => Variation.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProductId": productId,
        "AttributeName": attributeName,
        "AttributeDescription": attributeDescription,
        "Variations": List<dynamic>.from(variations!.map((x) => x.toJson())),
      };
}

class Variation {
  num? id;
  num? productId;
  num? attributeId;
  String? variationName;
  String? variationDescription;
  bool? isSelected;

  Variation({
    this.id,
    this.productId,
    this.attributeId,
    this.variationName,
    this.variationDescription,
    this.isSelected,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        id: json["Id"],
        productId: json["ProductId"],
        attributeId: json["AttributeId"],
        variationName: json["VariationName"],
        variationDescription: json["VariationDescription"],
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProductId": productId,
        "AttributeId": attributeId,
        "VariationName": variationName,
        "VariationDescription": variationDescription,
      };
}
