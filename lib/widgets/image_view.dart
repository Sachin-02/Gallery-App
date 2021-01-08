import 'dart:io';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String id;
  final String pageName;
  final File image;
  final bool imageOnly;
  final Function changeView;
  ImageView({
    @required this.id,
    @required this.image,
    @required this.pageName,
    @required this.imageOnly,
    @required this.changeView,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InteractiveViewer(
          child: GestureDetector(
            onTap: changeView,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(0),
              child: Hero(
                tag: id,
                child: Image.file(
                  image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        if (!imageOnly)
          Positioned(
            height: 50,
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).padding.top,
            left: 0,
            child: Container(
              color: Colors.black26,
              padding: EdgeInsets.only(
                top: 3,
                left: 10,
              ),
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
