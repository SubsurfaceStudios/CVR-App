//purpose: new feed testing area
//created by: alizardguy (9/24/2022 11:22AM)
//Project: https://github.com/alizardguy/CompensationVR-App-Tegu
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashPage extends StatefulWidget {
  DashPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<DashPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          //title text
          title: new Text("Dash"),
          //actions
          actions: <Widget>[
            //refresh button
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Refresh',
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Refreshed Feed')));
              },
            ),
          ]),
      body: _body(),
    );
  }

  Widget _body() {
    return new Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Dash"),
        ],
      ),
    );
  }
}
