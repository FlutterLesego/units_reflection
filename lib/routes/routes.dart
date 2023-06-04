import 'package:flutter/material.dart';

import '../views/pages/all_units_page.dart';
import '../views/pages/loading.dart';
import '../views/pages/login.dart';
import '../views/pages/register.dart';
import '../views/widgets/unit_view.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/registerPage';
  static const String allUnitsPage = '/allUnitsPage';
  static const String loadingPage = '/loadingPage';
  static const String unitViewPage = '/unitViewPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => Login(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => Register(),
        );

      case allUnitsPage:
        return MaterialPageRoute(
          builder: (context) => AllUnitsPage(),
        );

      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => Loading(),
        );

      case unitViewPage:
        return MaterialPageRoute(builder: (context) => UnitView());

      default:
        throw FormatException('Route not found! Check routes again!');
    }
  }
}
