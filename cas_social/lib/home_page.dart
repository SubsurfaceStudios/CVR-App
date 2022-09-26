import 'package:cvrnet/feed.dart';
import 'package:cvrnet/dash.dart';
import 'package:cvrnet/store.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'settings.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CVR Socail"),
        leading: Image.asset(
          'assets/CASpurple-logo.png',
          width: 50,
          height: 50,
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return new Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Dash
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashPage()),
                );
              },
              child: Text('Dashboard')),
          //search
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Text('Search')),
          //store
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StorePage()),
                );
              },
              child: Text('Store')),
          //settings
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: Text('Settings')),
        ],
      ),
    );
  }
}
