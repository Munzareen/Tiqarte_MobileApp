List<FAQTypeModel> categoryModelFromJson(List data) =>
    List<FAQTypeModel>.from(data.map((x) => FAQTypeModel.fromJson(x)));

class FAQTypeModel {
  String? name;
  bool? isSelected;

  FAQTypeModel({this.name, this.isSelected});

  factory FAQTypeModel.fromJson(String json) =>
      FAQTypeModel(name: json, isSelected: false);
}
