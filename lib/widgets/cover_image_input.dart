import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class CoverImageInput extends StatefulWidget {
  final Function onSelectImage;
  CoverImageInput(this.onSelectImage);
  @override
  _CoverImageInputState createState() => _CoverImageInputState();
}

class _CoverImageInputState extends State<CoverImageInput> {
  File _storedImage;

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
                    Icon(
                      Icons.camera,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Camera",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
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
                    Icon(
                      Icons.image,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Gallery",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
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
    final imageFile = await picker.getImage(source: source, maxWidth: 100);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy("${appDir.path}/$fileName");
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage:
                _storedImage != null ? FileImage(_storedImage) : null,
            child: _storedImage != null
                ? null
                : Icon(
                    Icons.person,
                    size: 60,
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
