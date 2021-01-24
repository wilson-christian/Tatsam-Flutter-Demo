import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tatsum_demo/http/api_request.dart';
import 'package:tatsum_demo/http/url.dart';
import 'package:tatsum_demo/model/countries_model.dart';
import 'package:tatsum_demo/model/countries_simple_model.dart';
import 'package:tatsum_demo/utility/app_constants.dart';

class CountriesController extends GetxController {
  var dataList = List<CountriesModel>().obs;
  var favouriteList = List<CountriesModel>().obs;
  GetStorage box;

  //Map<String, dynamic> dataList = new Map<String, dynamic>().obs;

  @override
  void onInit() {
    box = GetStorage();
    _retrieveFavouriteListFromLocalStorage()
        .then((value) => _apiGetCountriesList());

    super.onInit();
  }

  Future _retrieveFavouriteListFromLocalStorage() {
    String data = box.read(keyFavouriteList);

    try {
      favouriteList = countriesModelFromJson(data);

      print("${favouriteList.length}");
    } catch (e) {
      print(e);
    }

    return Future.value("done");
  }

  void _apiGetCountriesList() async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));

    ApiRequest apiRequest = ApiRequest(urlCountries, null);
    List<CountriesModel> tempList = [];

    apiRequest.get().then((value) {
      Countries responseModel = countriesFromJson(value.body);
      for (String key in responseModel.data.keys) {
        Datum singleItem = responseModel.data[key];

        tempList.add(CountriesModel(
            countryCode: key,
            countryName: singleItem.country,
            region: singleItem.country));
      }
      dataList.assignAll(tempList);
      Get.back();
    }).catchError((onError) {
      Get.back();
      print(onError);
    });
  }

  void removeFavourite(String countryCode) {
    favouriteList.removeWhere((element) => element.countryCode == countryCode);
  }

  void addFavourite(CountriesModel model) {
    favouriteList.insert(0, model);
  }

  void storeFavouriteListLocally() {
    box.write(keyFavouriteList, countriesModelToJson(favouriteList));
  }
}
