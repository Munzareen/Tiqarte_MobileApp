class FAQTypeModel {
  String? name;
  bool? isSelected;

  FAQTypeModel({this.name, this.isSelected});

  factory FAQTypeModel.fromJson(List<String> json) {
    return FAQTypeModel(
      name: json[0],
      isSelected: false,
    );
  }
}
