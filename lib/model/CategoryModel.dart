import 'dart:convert';

List<CategoryModel> categoryModelFromJson(List data) =>
    List<CategoryModel>.from(data.map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  num? id;
  String? catagoryName;
  String? imageURL;

  bool? isSelected;

  CategoryModel({
    this.id,
    this.catagoryName,
    this.imageURL,
    this.isSelected,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["Id"],
        catagoryName: json["CatagoryName"],
        imageURL: json["ImageURL"],
        isSelected: false,
      );

  Map<String, dynamic> toJson() =>
      {"Id": id, "CatagoryName": catagoryName, "ImageURL": imageURL};
}
