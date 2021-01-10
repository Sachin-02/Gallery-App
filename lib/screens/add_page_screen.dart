import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cover_image_input.dart';
import '../providers/personal_pages.dart';

class AddPageScreen extends StatefulWidget {
  static const routeName = "/add-page";
  final String pageId;
  AddPageScreen({this.pageId});
  @override
  _AddPageScreenState createState() => _AddPageScreenState();
}

class _AddPageScreenState extends State<AddPageScreen> {
  final _nameController = TextEditingController();
  File _pickedImage;
  var _isInit = true;
  var _isEditing = false;

  @override
  void didChangeDependencies() {
    // checking if arguments were passed in to determine if editing
    // a page or adding a new one
    if (_isInit) {
      _isInit = false;
      if (widget.pageId != null) {
        final page = Provider.of<PersonalPages>(context, listen: false)
            .findById(widget.pageId);
        _nameController.text = page.name;
        _pickedImage = page.image;
        _isEditing = true;
      }
    }
    super.didChangeDependencies();
  }

  // function to pass into the cover image input widget to
  // allow the image from cover image input to be used here
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePage() {
    // making sure the page has a title
    if (_nameController.text.isEmpty || _pickedImage == null) {
      return;
    }
    if (_isEditing) {
      Provider.of<PersonalPages>(context, listen: false)
          .editPage(widget.pageId, _nameController.text, _pickedImage);
      Navigator.of(context).pop();
    } else {
      Provider.of<PersonalPages>(context, listen: false)
          .addPage(_nameController.text, _pickedImage);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  if (_pickedImage == null) CoverImageInput(_selectImage),
                  if (_pickedImage != null)
                    CoverImageInput(_selectImage, image: _pickedImage),
                  TextField(
                    autocorrect: false,
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _nameController,
                  ),
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            color: Theme.of(context).primaryColor,
            onPressed: _savePage,
            icon: Icon(Icons.add, color: Colors.white),
            label: _isEditing
                ? Text(
                    "Save page",
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    "Add page",
                    style: TextStyle(color: Colors.white),
                  ),
            materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, // removes lower padding
            elevation: 0,
          )
        ],
      ),
    );
  }
}
