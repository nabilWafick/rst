// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:rst/main.dart';
import 'package:rst/modules/auth/connection/views/page/connection.page.dart';
import 'package:rst/modules/auth/registration/views/page/registration.page.dart';
import 'package:rst/modules/home/views/page/home.page.dart';

class RoutesManager {
  static const main = '/main';
  static const registration = '/registration';
  static const connection = '/connection';
  static const home = '/home';

  static Route onGenerateRoute(RouteSettings routeSettings) {
    Map<String, dynamic> passedValue;

    if (routeSettings.arguments != null) {
      passedValue = routeSettings.arguments as Map<String, dynamic>;
    }

    switch (routeSettings.name) {
      case registration:
        return MaterialPageRoute(
          builder: (context) => const RegistrationPage(),
        );

      case connection:
        return MaterialPageRoute(
          builder: (context) => const ConnectionPage(),
        );

      case home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );

      case main:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );
    }
  }

  static navigateTo(
      {required BuildContext context, required String routeName}) {
    return Navigator.of(context).pushNamed(routeName);
  }
}
