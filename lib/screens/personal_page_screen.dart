import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/page_drawer.dart';

class PersonalPageScreen extends StatefulWidget {
  static const routeName = "/personal-page";
  final String pageId;
  final String pageName;
  PersonalPageScreen(this.pageId, this.pageName);

  @override
  _PersonalPageScreenState createState() => _PersonalPageScreenState();
}

class _PersonalPageScreenState extends State<PersonalPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PageDrawer(),
      appBar: AppBar(
        title: Text("Name"),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text(widget.pageId),
      ),
    );
  }
}
