import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personal_images.dart';

class ImageViewScreen extends StatefulWidget {
  static const routeName = "image-view";
  final String id;
  ImageViewScreen(this.id);
  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    final images = Provider.of<PersonalImages>(context).items;
    final initialPage =
        Provider.of<PersonalImages>(context, listen: false).getIndex(widget.id);
    final pageController = PageController(initialPage: initialPage);
    return Scaffold(
        backgroundColor: Colors.black,
        body: PageView.builder(
            controller: pageController,
            itemCount: images.length,
            itemBuilder: (ctx, i) => Container(
                  child: Hero(
                    tag: images[i].id,
                    child: Image.file(
                      images[i].image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )));
  }
}
