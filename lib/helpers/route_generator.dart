import 'package:flutter/material.dart';
import '../screens/page_list_screen.dart';
import '../screens/add_page_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => PageListScreen());
      case AddPageScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddPageScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
                body: Center(
              child: Text("ERROR"),
            )));
  }
}
