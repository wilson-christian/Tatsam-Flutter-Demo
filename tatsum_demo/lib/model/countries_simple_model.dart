import 'dart:convert';

import 'package:get/get.dart';

List<CountriesModel> countriesModelFromJson(String str) =>
    List<CountriesModel>.from(
        json.decode(str).map((x) => CountriesModel.fromJson(x))).obs;

String countriesModelToJson(List<CountriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountriesModel {
  String countryCode;
  String countryName;
  String region;
  var isFavourite = false.obs;

  CountriesModel({
    this.countryCode,
    this.countryName,
    this.region,
  });

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        countryCode: json["country_code"],
        countryName: json["country_name"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "country_name": countryName,
        "region": region,
      };
}
