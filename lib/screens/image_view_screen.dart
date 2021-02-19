import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personal_images.dart';
import '../widgets/image_view.dart';

class ImageViewScreen extends StatefulWidget {
  static const routeName = "image-view";
  final String imageId;
  final String pageName;
  ImageViewScreen(this.imageId, this.pageName);

  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  // boolean to display back button bar or not. This is managed in this widget
  // as opposed to the image_view widget so that it does not reset on each swipe.
  var _imageOnly = false;

  void _changeView() {
    setState(() {
      _imageOnly = !_imageOnly;
    });
  }

  @override
  Widget build(BuildContext context) {
    final images = Provider.of<PersonalImages>(context).items;
    final initialPage = Provider.of<PersonalImages>(context, listen: false)
        .getIndex(widget.imageId);
    final pageController = PageController(initialPage: initialPage);
    return Scaffold(
      backgroundColor: Colors.black,
      body: images.isEmpty
          ? Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                    "You have no images left. Press this button to return to the previous page."),
              ),
            )
          // using page view to allow swiping between images in a full screen view mode
          : PageView.builder(
              controller: pageController,
              itemCount: images.length,
              itemBuilder: (ctx, i) => ImageView(
                id: images[i].id,
                image: images[i].image,
                pageName: widget.pageName,
                imageOnly: _imageOnly,
                changeView: _changeView,
              ),
            ),
    );
  }
}
