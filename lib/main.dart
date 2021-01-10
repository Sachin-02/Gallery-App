import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './helpers/theme_manager_widget.dart';
import './helpers/route_generator.dart';
import './providers/personal_pages.dart';
import './providers/personal_images.dart';
import './providers/theme_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PersonalPages(),
        ),
        ChangeNotifierProvider(
          create: (_) => PersonalImages(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeManager(),
          // using a builder since the theme provider needs a new context to be
          // used this high in the widget tree
          builder: (context, _) {
            return ThemeManagerWidget(
              child: Consumer<ThemeManager>(
                builder: (ctx, themeManager, _) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: themeManager.theme,
                  onGenerateRoute: RouteGenerator.generateRoute,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
