import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  bool _isDarkMode;

  final _lightTheme = ThemeData(
    primaryColor: const Color(0xFF3b70b3),
    scaffoldBackgroundColor: const Color(0xFFa4c8f5),
    canvasColor: const Color(0xFFa4c8f5),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF3b70b3),
    ),
    appBarTheme: AppBarTheme(
      color: const Color(0xFF3b70b3),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    dividerColor: Colors.black,
  );

  final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF2c2f33),
    canvasColor: const Color(0xFF1d1e21),
    scaffoldBackgroundColor: const Color(0xFF3a3d42),
    appBarTheme: AppBarTheme(
      color: const Color(0xFF2c2f33),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      button: TextStyle(
        color: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF383838),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    dividerColor: Colors.white,
  );

  ThemeData get theme {
    if (_isDarkMode) {
      return _darkTheme;
    } else {
      return _lightTheme;
    }
  }

  bool get isDarkMode {
    if (_isDarkMode) {
      return true;
    } else {
      return false;
    }
  }

  // setting the theme on startup of the app
  Future<void> fetchAndSetMode() async {
    // accessing the device storage to check if dark mode preferences
    // have been set. If it has not been set, setting it to false (light mode)
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("darkMode")) {
      await prefs.setBool("darkMode", false);
      _isDarkMode = false;
      return;
    }
    final extractedData = prefs.getBool("darkMode");
    _isDarkMode = extractedData;
    notifyListeners();
  }

  void changeMode(bool val) async {
    _isDarkMode = val;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkMode", val);
  }
}
