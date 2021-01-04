import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './helpers/route_generator.dart';
import './providers/personal_pages.dart';
import './providers/personal_images.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          // brightness: Brightness.dark,
          // primarySwatch: Colors.grey,
          // brightness: Brightness.dark,
          // primaryColor: Colors.grey[800],
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
