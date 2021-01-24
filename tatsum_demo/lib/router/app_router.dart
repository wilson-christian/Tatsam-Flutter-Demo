import 'package:get/get.dart';
import 'package:tatsum_demo/router/app_router_constants.dart';
import 'package:tatsum_demo/view/countries_list_view.dart';
import 'package:tatsum_demo/view/favourite_list_view.dart';

class AppRouter {
  static final route = [
    GetPage(
      name: routeHome,
      page: () => CountriesListView(),
    ),
    GetPage(
      name: routeFavourite,
      page: () => FavouriteListView(),
    ),
  ];
}
