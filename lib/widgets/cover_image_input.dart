import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:image_cropper/image_cropper.dart';

class CoverImageInput extends StatefulWidget {
  final Function onSelectImage;
  final File image;
  CoverImageInput(this.onSelectImage, {this.image});
  @override
  _CoverImageInputState createState() => _CoverImageInputState();
}

class _CoverImageInputState extends State<CoverImageInput> {
  File _storedImage;

  @override
  void initState() {
    super.initState();
    if (widget.image != null) {
      _storedImage = widget.image;
    }
  }

  void _startSelectImage() {
    showDialog(
      context: context,
      child: SimpleDialog(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Column(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(height: 10),
                    Text("Camera"),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _selectImage(ImageSource.camera);
                },
              ),
              InkWell(
                child: Column(
                  children: [
                    Icon(Icons.image),
                    SizedBox(height: 10),
                    Text("Gallery"),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _selectImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(source: source);
    if (imageFile == null) {
      return;
    }
    final croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      maxHeight: 400,
      maxWidth: 400,
      androidUiSettings: AndroidUiSettings(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor: Theme.of(context).textTheme.headline6.color,
        activeControlsWidgetColor: Theme.of(context).primaryColor,
      ),
    );
    if (croppedImage == null) {
      return;
    }
    setState(() {
      _storedImage = croppedImage;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy("${appDir.path}/$fileName");
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        ClipRRect(
          child: Container(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _storedImage != null
                    ? Image.file(
                        _storedImage,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        color: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                ClipPath(
                  clipper: InvertedCircleClipper(),
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        FlatButton.icon(
          onPressed: _startSelectImage,
          icon: Icon(Icons.image),
          label: Text(
            "Select Image",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width * 0.5))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
