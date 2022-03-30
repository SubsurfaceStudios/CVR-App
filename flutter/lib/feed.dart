import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedPage extends StatefulWidget {
  FeedPage({
    Key? key,
    @required this.feedURL,
  }) : super(key: key);

  var feedURL;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<FeedPage> {
  var feedJson = null;
  var offset = 0;

  get feedURL => String;

  Future loadFeed() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(
        "https://api.compensationvr.tk/api/social/imgfeed?offset=${offset}&count=5&reverse"));
    if (response.statusCode == 200) {
      feedJson = json.decode(response.body);
      print("Images Fetched Successfully");
      print(feedJson);
      setState(() {});
    } else {
      print('IMAGE Request failed with status: ${response.statusCode}.');
    }
  }

  void nextInFeed() {
    setState(() {
        offset = offset + 5;
      }); 
  }

  Widget build(BuildContext context) {
    loadFeed();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Feed"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return new SingleChildScrollView(
      child: Column(
        children: [
          // Text("Photo Feed goes here"),
          // TextButton(
          //   style: ButtonStyle(
          //     foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => FeedPage()),
          //     );
          //   },
          //   child: Text('More'),
          // )

          for (int i = 0; i < (feedJson.length); i++)
            new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(
                  'https://api.compensationvr.tk${feedJson[i]["filePath"]}'),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    "${i.toString()} - ${feedJson[i]["takenBy"]["username"]}: ${feedJson[i]["takenOn"]["humanReadable"]}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
              )
            ]),
            TextButton(onPressed: nextInFeed, child: Text("Next"))
        ],
      ),
    );
  }
}
