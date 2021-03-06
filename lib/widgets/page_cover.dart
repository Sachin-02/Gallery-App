import 'dart:io';
import 'package:flutter/material.dart';
import '../screens/personal_page_screen.dart';

class PageCover extends StatelessWidget {
  final String id;
  final String name;
  final File image;

  PageCover(this.id, this.name, this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      // Using a ClipRRect for the rounded corners
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  PersonalPageScreen.routeName,
                  arguments: [id, name]);
            },
            child: Image.file(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
