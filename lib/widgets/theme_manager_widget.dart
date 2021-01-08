import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_manager.dart';

class ThemeManagerWidget extends StatefulWidget {
  final Widget child;
  ThemeManagerWidget({@required this.child});
  @override
  _ThemeManagerWidgetState createState() => _ThemeManagerWidgetState();
}

class _ThemeManagerWidgetState extends State<ThemeManagerWidget> {
  Future fetchAndSet;

  @override
  void initState() {
    super.initState();
    fetchAndSet =
        Provider.of<ThemeManager>(context, listen: false).fetchAndSetMode();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchAndSet,
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : widget.child,
    );
  }
}
