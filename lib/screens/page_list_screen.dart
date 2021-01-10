import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/page_drawer.dart';
import '../widgets/page_cover.dart';
import '../providers/personal_pages.dart';
import '../screens/add_page_screen.dart';
import '../screens/manage_pages_screen.dart';
import '../screens/settings_screen.dart';

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
    // Intializing the future inside init state to prevent any unnecessary
    // reruns of the future when opening and closing the drawer. This can
    // happen when using the future builder without init state.
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
        {
          Navigator.of(context).pushNamed(SettingsScreen.routeName);
        }
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
        title: Text(
          "Choose your fighter!",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          PopupMenuButton<MenuAction>(
            color: Theme.of(context).popupMenuTheme.color,
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
          child: Icon(Icons.add, color: Colors.white),
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
                                      // Maximum of 2 columns in the grid
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
                            // adding a sized box so the floating action button
                            // doesn't overlap the page covers when scrolled all
                            // the way at the bottom
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (ctx, i) => SizedBox(
                                        height: 70,
                                      ),
                                  childCount: 1),
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
