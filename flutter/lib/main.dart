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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: new HomePage(),
    );
  }
}
