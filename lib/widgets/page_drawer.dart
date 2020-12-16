import 'package:flutter/material.dart';

class PageDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Drawer(
        child: Column(
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
                  radius: 30,
                  child: IconButton(
                    icon: Icon(
                      Icons.person,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(bottom: 2),
              child: Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => Container(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/pikachu.jpg"),
                        ),
                      ),
                      childCount: 3,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => Container(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        child: CircleAvatar(
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                          maxRadius: 30,
                        ),
                      ),
                      childCount: 1,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
