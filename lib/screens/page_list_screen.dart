import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/page_drawer.dart';
import '../widgets/page_cover.dart';
import '../providers/personal_pages.dart';

class PageListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = Provider.of<PersonalPages>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose your fighter!"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
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
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (ctx, i) => PageCover(
                pages[i].id,
                pages[i].name,
                pages[i].image,
              ),
              itemCount: pages.length,
            ),
    );
  }
}
