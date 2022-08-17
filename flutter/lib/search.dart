import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

import './api_accounts.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class AccountSearchResult extends StatelessWidget {
  const AccountSearchResult({required this.data});

  final PublicPlayerData data;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.blueGrey[200],
            borderRadius: BorderRadiusDirectional.all(Radius.circular(15)),
            border: Border.all()),
        child: Padding(
          child: Column(
            children: [
              Text("'${data.nickname}'", style: TextStyle(color: Colors.white)),
              Text("@${data.username}", style: TextStyle(color: Colors.white)),
              Text(
                "Bio: ${data.bio}",
                style: TextStyle(color: Colors.white),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.all(8),
        ));
  }
}

class _SearchPageState extends State<Search> {
  late List<PublicPlayerData>? result = null;
  bool loading = false;

  final inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search Accounts"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (loading) {
      return new Center(child: Column(children: [Text("Loading...")]));
    }

    late List<AccountSearchResult> results = [];
    if (result != null) {
      results = [];
      for (PublicPlayerData data in result!) {
        results.add(AccountSearchResult(data: data));
      }
    }

    return new Center(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a username to search',
            ),
            controller: inputController,
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              setState(() {
                this.loading = true;
              });
              var searchResult = await AccountsAPI.Search(
                  inputController.text, AccountSearchMode.Username);
              if (searchResult == null)
                return showAlertDialog(
                    context: context,
                    title: "Internal error",
                    message:
                        "We were unable to complete your query. Please check your internet connection or try again later.");

              List<PublicPlayerData> temp = [];
              for (String i in searchResult) {
                var x = await AccountsAPI.GetPublicData(i);
                if (x == null)
                  continue;
                else
                  temp.add(x);
              }
              setState(() {
                this.result = temp;
                this.loading = false;
              });
            },
            child: Text('Search'),
          ),
          Expanded(
              child: ListView(
            children: results,
            shrinkWrap: true,
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.zero,
          )),
        ],
      ),
    );
  }
}
