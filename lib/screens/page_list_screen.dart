import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/page_drawer.dart';
import '../providers/personal_pages.dart';

class PageListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = Provider.of<PersonalPages>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose your fighter!"),
      ),
      drawer: PageDrawer(),
      body: pages.isEmpty
          ? Center(
              child: Text(
                "Welcome! You don't have any pages yet so tap the button in the top right to add a new page.",
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width,
              ),
              itemBuilder: (ctx, i) => Container(),
              itemCount: pages.length,
            ),
    );
  }
}
