import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_manager.dart';

// This widget only exists to make development and debugging easier.
// the fetchAndSet future for the theme mode must be intialized in
// init state, otherwise the future will rerun on each hot reload,
// causing the app to reset to the home screen which can be very
// annoying in development.

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
    // initialzing the future in init state to prevent the issue mentioned above
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
