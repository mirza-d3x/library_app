import 'package:flutter/material.dart';

import 'route_names.dart';

class NavigationServices {
  void createSplashPageRoute(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.splash,
      (route) => false,
    );
  }

  void createBooksPageRouteBuilder(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.books,
      (route) => false,
    );
  }
}

extension AppPageInjectable on BuildContext {
  NavigationServices get navigationService => NavigationServices();
}
