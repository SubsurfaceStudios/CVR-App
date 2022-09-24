import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedPage extends StatefulWidget {
  FeedPage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<FeedPage> {
  var feedJson = null;
  var offset = 0;
  var requested = false;
  var feedcalled = false;
  var _isLoading = false;
  var existing = null;
  var newitems = null;
  var feedsize = 12;

  ScrollController _scrollController = new ScrollController();

  Future loadFeed() async {
    print("feedload called");
    // Await the http get response, then decode the json-formatted response.
    if (requested == false) {
      requested = true;
      requested = true;
      print("getting feed");
      var response = await http.get(Uri.parse(
          "https://api.compensationvr.tk/api/social/imgfeed?offset=${offset}&count=${feedsize}&reverse"));

      // feedcalled = false;
      if (response.statusCode == 200) {
        if (feedJson != null) {
          print("combine" + offset.toString());
          print(feedJson.length);
          (feedJson as List).addAll(json.decode(response.body.toString()));
          print(feedJson.length);
        } else {
          feedJson = json.decode(response.body);
          print(feedJson.length);
          print("set" + offset.toString());
        }
        // feedJson = json.decode(response.body);

        print("Images Fetched Successfully");
        print("LOADSUCCESS " +
            "https://api.compensationvr.tk/api/social/imgfeed?offset=${offset}&count=${feedsize}&reverse");
      } else {
        print('Image feed request failed with status: ${response.statusCode}.');
        print("LOADERROR " +
            "https://api.compensationvr.tk/api/social/imgfeed?offset=${offset}&count=${feedsize}&reverse");
        showOkAlertDialog(
            context: context,
            title: "Connection Error",
            message:
                "Check the status of your internet connection and try again. if the issue persists, contact mobile support on Discord. [Error code ${response.statusCode}]");
      }
      setState(() {
        feedcalled = false;
        requested = false;
        _isLoading = false;
      });
    } else {
      print("Already requested");
    }
  }

  void nextInFeed() {
    print("NEXTINFEED");
    setState(() {
      offset = offset + feedsize;
    });
  }

  Widget build(BuildContext context) {
    print("build");
    //loadFeed();
    return new Scaffold(
      appBar: new AppBar(title: new Text("Feed"), actions: <Widget>[
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
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Refreshed Feed')));
          },
        ),
      ]),
      body: _body(),
    );
  }

  Widget _body() {
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent ||
            _scrollController.position.maxScrollExtent == 0) {
          if (_isLoading == false) {
            _isLoading = true;
            print("scrollrefresh");
            print(offset);
            nextInFeed();
          } else {
            print("refreshBLOCKED");
            print(offset);
          }
        }
      });

    var output = new SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          if (feedJson != null)
            for (int i = 0; i < (feedJson.length); i++)
              new Column(children: [
                Image.network(
                  'https://api.compensationvr.tk${feedJson[i]["filePath"]}',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / (1920 / 1080),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                        height:
                            MediaQuery.of(context).size.width / (1920 / 1080),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ));
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    print('Image feed request error: ${stackTrace}.');
                    return Container(
                        height:
                            MediaQuery.of(context).size.width / (1920 / 1080),
                        child: Center(
                            child: Column(
                          children: [
                            Text("Error loading image",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              exception.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )));
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                      "Photo by ${feedJson[i]["takenBy"]["username"]} on ${feedJson[i]["takenOn"]["humanReadable"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                )
              ]),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );

    return output;
  }
}
