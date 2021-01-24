import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsum_demo/controller/countries_controller.dart';
import 'package:tatsum_demo/utility/app_constants.dart';

class FavouriteListView extends StatelessWidget {
  final CountriesController _countriesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(favourites),
      ),
      body: _countriesController.favouriteList.isEmpty
          ? noFavourite()
          : contentOfScreen(),
    );
  }

  Widget noFavourite() {
    return Center(
      child: Text(noFavourites),
    );
  }

  Widget contentOfScreen() {
    return Container(
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: _countriesController.favouriteList.length,
          itemBuilder: (context, index) {
            var model = _countriesController.favouriteList[index];

            return Card(
              child: ListTile(
                title: Text("${model.countryName} (${model.countryCode})"),
                subtitle: Text(model.region),
                trailing: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
