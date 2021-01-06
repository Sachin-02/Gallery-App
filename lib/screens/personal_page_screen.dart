import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import '../providers/personal_images.dart';
import '../widgets/page_drawer.dart';
import '../screens/image_view_screen.dart';

class PersonalPageScreen extends StatefulWidget {
  static const routeName = "/personal-page";
  final String pageId;
  final String pageName;
  PersonalPageScreen(this.pageId, this.pageName);

  @override
  _PersonalPageScreenState createState() => _PersonalPageScreenState();
}

class _PersonalPageScreenState extends State<PersonalPageScreen>
    with SingleTickerProviderStateMixin {
  Future fetchAndSet;
  AnimationController _iconAnimation;
  var _gridView = true;

  @override
  void initState() {
    super.initState();
    _iconAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    fetchAndSet = Provider.of<PersonalImages>(context, listen: false)
        .fetchAndSetImages(widget.pageId);
  }

  void _changeView() {
    setState(() {
      if (_gridView) {
        _iconAnimation.forward();
      } else {
        _iconAnimation.reverse();
      }
      _gridView = !_gridView;
    });
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
    final pickedImageFile = await picker.getImage(source: source);
    if (pickedImageFile == null) {
      return;
    }
    final imageFile = File(pickedImageFile.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy("${appDir.path}/$fileName");
    Provider.of<PersonalImages>(context, listen: false)
        .addImage(widget.pageId, savedImage);
  }

  void _startDeleteImage(String id) {
    showDialog(
        context: context,
        child: SimpleDialog(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<PersonalImages>(context, listen: false)
                        .deleteImage(id);
                  },
                ),
                Text("Delete"),
              ],
            )
          ],
        ));
  }

  Widget _imageViewBuilder(PersonalImages images) {
    if (_gridView) {
      return Scrollbar(
        child: CustomScrollView(slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 1.0,
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.4,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate(
                (ctx, i) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ImageViewScreen.routeName,
                            arguments: [images.items[i].id, widget.pageName]);
                      },
                      onLongPress: () {
                        _startDeleteImage(images.items[i].id);
                      },
                      child: Hero(
                        tag: images.items[i].id,
                        child: Image.file(
                          images.items[i].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                childCount: images.items.length),
          ),
        ]),
      );
    } else {
      return Scrollbar(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (ctx, i) => Card(
                margin: EdgeInsets.only(bottom: 10, top: 6, left: 6, right: 6),
                elevation: 8,
                child: InkWell(
                  onLongPress: () {
                    _startDeleteImage(images.items[i].id);
                  },
                  onTap: () {
                    Navigator.of(context).pushNamed(ImageViewScreen.routeName,
                        arguments: [images.items[i].id, widget.pageName]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Hero(
                      tag: images.items[i].id,
                      child: Image.file(
                        images.items[i].image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              childCount: images.items.length,
            ))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PageDrawer(),
      appBar: AppBar(
        title: Text("${widget.pageName}"),
        actions: [
          IconButton(
            onPressed: _changeView,
            icon: AnimatedIcon(
              icon: AnimatedIcons.list_view,
              progress: _iconAnimation,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _startSelectImage,
          ),
        ],
      ),
      body: FutureBuilder(
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: const CircularProgressIndicator(),
                  )
                : Consumer<PersonalImages>(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Welcome! You don't have any images on this page yet. Tap the + button in the top right to add a new image.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    builder: (ctx, images, ch) =>
                        images.items.isEmpty ? ch : _imageViewBuilder(images),
                  ),
      ),
    );
  }
}
