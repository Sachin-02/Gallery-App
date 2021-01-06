import 'package:flutter/material.dart';
import '../screens/page_list_screen.dart';
import '../screens/add_page_screen.dart';
import '../screens/personal_page_screen.dart';
import '../screens/manage_pages_screen.dart';
import '../screens/image_view_screen.dart';
import '../screens/settings_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => PageListScreen());
      case AddPageScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddPageScreen(pageId: args));
      case PersonalPageScreen.routeName:
        return MaterialPageRoute(
          builder: (_) {
            final List<String> arguments = args;
            return PersonalPageScreen(arguments[0], arguments[1]);
          },
        );
      case ManagePagesScreen.routeName:
        return MaterialPageRoute(builder: (_) => ManagePagesScreen());
      case SettingsScreen.routeName:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case ImageViewScreen.routeName:
        return MaterialPageRoute(
          builder: (_) {
            final List<String> arguments = args;
            return ImageViewScreen(arguments[0], arguments[1]);
          },
        );
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
