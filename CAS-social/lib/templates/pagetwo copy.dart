import 'package:flutter/material.dart';
import '/main.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<FeedPage> {
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
        children: [
          Text("Photo Feed goes here"),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedPage()),
              );
            },
            child: Text('More'),
          )
        ],
      ),
    );
  }
}
