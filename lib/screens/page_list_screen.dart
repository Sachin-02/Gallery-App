import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/page_drawer.dart';
import '../widgets/page_cover.dart';
import '../providers/personal_pages.dart';
import '../screens/add_page_screen.dart';
import '../screens/manage_pages_screen.dart';

enum MenuAction { managePages, settings }

class PageListScreen extends StatefulWidget {
  static const routeName = "/";
  @override
  _PageListScreenState createState() => _PageListScreenState();
}

class _PageListScreenState extends State<PageListScreen> {
  Future fetchAndSet;
  @override
  void initState() {
    super.initState();
    fetchAndSet =
        Provider.of<PersonalPages>(context, listen: false).fetchAndSetPages();
  }

  void menuAction(MenuAction action) {
    switch (action) {
      case MenuAction.managePages:
        {
          Navigator.of(context).pushNamed(ManagePagesScreen.routeName);
        }
        break;
      case MenuAction.settings:
        {}
        break;
      default:
        {}
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose your fighter!"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: menuAction,
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: MenuAction.managePages,
                child: Text("Manage Pages"),
              ),
              PopupMenuItem(
                value: MenuAction.settings,
                child: Text("Settings"),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        padding: EdgeInsets.only(bottom: 12),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddPageScreen.routeName);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: PageDrawer(),
      body: FutureBuilder(
        future: fetchAndSet,
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<PersonalPages>(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Welcome! You don't have any pages yet.  Tap the + button in the top right to add a new page.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                builder: (ctx, pages, ch) => pages.items.isEmpty
                    ? ch
                    : Scrollbar(
                        child: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.all(12),
                              sliver: SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width * 0.5,
                                  childAspectRatio: 1.0,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (ctx, i) => PageCover(
                                    pages.items[i].id,
                                    pages.items[i].name,
                                    pages.items[i].image,
                                  ),
                                  childCount: pages.items.length,
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (ctx, i) => SizedBox(
                                        height: 70,
                                      ),
                                  childCount: 1),
                            )
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
