import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personal_pages.dart';
import '../screens/page_list_screen.dart';
import '../screens/personal_page_screen.dart';
import '../screens/add_page_screen.dart';

class PageDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = Provider.of<PersonalPages>(context).items;
    return Container(
      width: 80,
      child: Drawer(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top + 2,
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30,
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(
                              Icons.home,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(
                                  PageListScreen.routeName);
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.only(bottom: 2),
                      child: Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
                childCount: 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => Container(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(
                        PersonalPageScreen.routeName,
                        arguments: [
                          pages[i].id,
                          pages[i].name,
                        ],
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(pages[i].image),
                    ),
                  ),
                ),
                childCount: pages.length,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => Container(
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed(AddPageScreen.routeName);
                      },
                    ),
                    maxRadius: 30,
                  ),
                ),
                childCount: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
