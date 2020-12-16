import 'package:flutter/material.dart';

class PageListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose your fighter"),
        ),
        body: Center(
          child: Text(
            "Welcome! You don't have any pages yet so tap the button in the top right to add a new page.",
            textAlign: TextAlign.center,
          ),
        ));
  }
}
