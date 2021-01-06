import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/personal_pages.dart';
import '../screens/add_page_screen.dart';

class ManagePagesScreen extends StatelessWidget {
  void showDeleteDialog(BuildContext ctx, String id, String title) {
    showDialog(
      context: ctx,
      child: AlertDialog(
        title: Text(
          "Delete $title?",
          style: TextStyle(color: Theme.of(ctx).textTheme.headline5.color),
        ),
        content: Text(
            "Warning: deleting a page will delete any images inside of it. Are you sure you want to delete this page?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              "Cancel",
              style: Theme.of(ctx).textTheme.button,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Provider.of<PersonalPages>(ctx, listen: false).deletePage(id);
            },
            child: Text(
              "Delete",
              style: Theme.of(ctx).textTheme.button,
            ),
          ),
        ],
      ),
    );
  }

  static const routeName = "/manage-pages";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Manage Pages", style: Theme.of(context).textTheme.headline6),
      ),
      body: Consumer<PersonalPages>(
        child: Center(child: Text("You have no pages.")),
        builder: (ctx, pages, ch) => pages.items.length <= 0
            ? ch
            : Scrollbar(
                child: ListView.builder(
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(pages.items[i].image),
                    ),
                    title: Text(
                      pages.items[i].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  AddPageScreen.routeName,
                                  arguments: pages.items[i].id);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              showDeleteDialog(
                                context,
                                pages.items[i].id,
                                pages.items[i].name,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: pages.items.length,
                ),
              ),
      ),
    );
  }
}
