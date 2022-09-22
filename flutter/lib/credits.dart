import 'package:flutter/material.dart';
import 'main.dart';
import 'settings.dart';

class Credits extends StatefulWidget {
  Credits({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Feed"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Created with love using Flutter."),
          Text("Written in Dart."),
          Text("CVRNet/API Developer - Bobrobot1."),
          Text("CompensationVR/API Developer - Rose932."),
          Text("CompensationVR/Music Developer - LeonToGamer."),
          Text("Marketing - Opabina."),
          Text("Marketing - Ciunics."),
          Text("Support - Demented."),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back'),
          )
        ],
      ),
    );
  }
}
