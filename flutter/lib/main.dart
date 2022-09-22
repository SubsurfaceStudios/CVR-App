import 'package:cvrnet/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'feed.dart';
import 'credits.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Loading...',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: new HomePage(),
    );
  }
}
