import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/page_drawer.dart';
import '../widgets/page_cover.dart';
import '../providers/personal_pages.dart';
import '../screens/add_page_screen.dart';

class PageListScreen extends StatefulWidget {
  @override
  _PageListScreenState createState() => _PageListScreenState();
}

class _PageListScreenState extends State<PageListScreen> {
  Future fetchAndSet;
  @override
  void initState() {
    fetchAndSet =
        Provider.of<PersonalPages>(context, listen: false).fetchAndSetPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose your fighter!"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPageScreen.routeName);
            },
          ),
        ],
      ),
      drawer: PageDrawer(),
      body: FutureBuilder(
        future: fetchAndSet,
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center()
            : Consumer<PersonalPages>(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Welcome! You don't have any pages yet so tap the button in the top right to add a new page.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                builder: (ctx, pages, ch) => pages.items.isEmpty
                    ? ch
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width * 0.5,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (ctx, i) => PageCover(
                          pages.items[i].id,
                          pages.items[i].name,
                          pages.items[i].image,
                        ),
                        itemCount: pages.items.length,
                      ),
              ),
      ),
    );
  }
}
