import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tatsum_demo/controller/countries_controller.dart';
import 'package:tatsum_demo/model/countries_simple_model.dart';
import 'package:tatsum_demo/router/app_router_constants.dart';
import 'package:tatsum_demo/utility/app_constants.dart';

// ignore: must_be_immutable
class CountriesListView extends StatelessWidget {
  final CountriesController _countriesController =
      Get.put(CountriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(appName),
        actions: [actionFavourite()],
      ),
      body: ConnectivityWidget(
        showOfflineBanner: false,
        builder: (context, isOnline) {
          return isOnline ? contentOfScreen() : noInternetConnection();
        },
      ),
    );
  }

  Widget noInternetConnection() {
    return Center(
      child: Text(noInternet),
    );
  }

  Widget contentOfScreen() {
    if (_countriesController.dataList.length == 0) {
      _countriesController.onInit();
    }

    return Container(
      child: Obx(
        () {
          // int lengthOfList =
          //     (_countriesController.dataList.length ~/ 5).toInt();
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: _countriesController.dataList.length,
            itemBuilder: (context, index) {
              var model = _countriesController.dataList[index];
              int indexOfFav =
                  _countriesController.favouriteList.indexWhere((element) {
                return element.countryCode == model.countryCode;
              });

              bool isFav = indexOfFav != -1;

              model.isFavourite.value = isFav;

              return Card(
                child: ListTile(
                  title: Text("${model.countryName} (${model.countryCode})"),
                  subtitle: Text(model.region),
                  trailing: Obx(
                    () => Icon(
                      model.isFavourite.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: model.isFavourite.value ? Colors.red : null,
                    ),
                  ),
                  onTap: () {
                    if (model.isFavourite.value) {
                      _countriesController.removeFavourite(model.countryCode);
                      model.isFavourite.value = false;
                    } else {
                      model.isFavourite.value = true;
                      _countriesController.addFavourite(model);
                    }

                    _countriesController.storeFavouriteListLocally();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget actionFavourite() {
    return FlatButton(
      textColor: Colors.white,
      onPressed: () {
        Get.toNamed(routeFavourite);
      },
      child: Text(favourites),
      shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
    );
  }
}
