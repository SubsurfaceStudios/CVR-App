import 'package:flutter/material.dart';
import 'main.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return new Center(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search users and rooms',
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {},
            child: Text('Search'),
          )
        ],
      ),
    );
  }
}
