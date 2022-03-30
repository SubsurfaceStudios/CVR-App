import 'package:cvrnet/home_page.dart';
import 'package:flutter/material.dart';
import 'main.dart'; //not sure why this isn't maked as used
import 'credits.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return new Center(
      child: Column(
        children: [
          Text("CVRNet App v1.0.2 [Developer]"),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.purple),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('Dark Mode Toggle'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('Terms of Service'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('Text Size'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Credits()),
              );
            },
            child: Text('Credits'),
          )
        ],
      ),
    );
  }
}
