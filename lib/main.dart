import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './helpers/route_generator.dart';
import './providers/personal_pages.dart';
import './providers/personal_images.dart';
import 'providers/theme_manager.dart';

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
          builder: (context, _) {
            return FutureBuilder(
              future: Provider.of<ThemeManager>(context, listen: false)
                  .fetchAndSetMode(),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<ThemeManager>(
                          builder: (ctx, themeManager, ch) => MaterialApp(
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

//         ChangeNotifierProvider(
//           create: (_) => ThemeManager(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primaryColor: const Color(0xFF3b70b3),
//           scaffoldBackgroundColor: const Color(0xFFa4c8f5),
//           canvasColor: const Color(0xFFa4c8f5),
//           floatingActionButtonTheme: FloatingActionButtonThemeData(
//             backgroundColor: const Color(0xFF3b70b3),
//           ),
//           appBarTheme: AppBarTheme(
//             color: const Color(0xFF3b70b3),
//             centerTitle: true,
//           ),
//           textTheme: TextTheme(
//             headline6: TextStyle(color: Colors.white),
//             headline5: TextStyle(color: Colors.black),
//           ),
//           iconTheme: IconThemeData(
//             color: Colors.black87,
//           ),
//           dividerColor: Colors.black,
//         ),
//         onGenerateRoute: RouteGenerator.generateRoute,
//       ),
//     );
//   }
// }
