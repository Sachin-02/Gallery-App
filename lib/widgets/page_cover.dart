import 'dart:io';
import 'package:flutter/material.dart';

class PageCover extends StatelessWidget {
  final String id;
  final String name;
  final File image;

  PageCover(this.id, this.name, this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          child: InkWell(
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
