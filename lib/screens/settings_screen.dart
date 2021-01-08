import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_manager.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";
  @override
  Widget build(BuildContext context) {
    // var isDarkMode = Provider.of<ThemeManager>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListTile(
          title: Text(
            "Dark Mode",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Switch(
              // value: isDarkMode,
              value: false,
              onChanged: (val) {
                Provider.of<ThemeManager>(context, listen: false)
                    .changeMode(val);
              }),
        ),
      ),
    );
  }
}
