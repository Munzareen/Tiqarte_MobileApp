import 'dart:convert';

List<LocationsModel> locationsModelFromJson(List data) =>
    List<LocationsModel>.from(data.map((x) => LocationsModel.fromJson(x)));

String locationsModelToJson(List<LocationsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationsModel {
  int? id;
  String? locationName;
  bool? isActive;

  LocationsModel({this.id, this.locationName, this.isActive});

  LocationsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    locationName = json['LocationName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['LocationName'] = this.locationName;
    data['isActive'] = this.isActive;
    return data;
  }
}
