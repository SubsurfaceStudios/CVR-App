import 'package:cvrnet/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'feed.dart';
import 'credits.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(), //this shit lets theme switching
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'CVR Socail',
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false, //removes the debug watermark
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: new HomePage(),
          );
        },
      );
}
