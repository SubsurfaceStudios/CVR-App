import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import './api_base.dart';

part 'api_accounts.g.dart';

class AccountsAPI {
  static Future<PublicPlayerData?> GetPublicData(String AccountId) async {
    var response = await http.get(Uri.parse(
        "https://${Constants.API_BASE_HOST}/api/accounts/${AccountId}/public"));

    if (response.statusCode != 200) return null;

    try {
      var x = jsonDecode(response.body);
      return PublicPlayerData.fromJson(x);
    } catch (ex) {
      return null;
    }
  }

  static Future<List<String>?> Search(
      String query, AccountSearchMode mode) async {
    late String mode_parsed;
    switch (mode) {
      case AccountSearchMode.Username:
        mode_parsed = "username";
        break;
      case AccountSearchMode.Nickname:
        mode_parsed = "nickname";
        break;
      case AccountSearchMode.Bio:
        mode_parsed = "bio";
        break;
    }

    var query_encoded = Uri.encodeQueryComponent(query);

    var response = await http.get(Uri.parse(
        "https://${Constants.API_BASE_HOST}/api/accounts/search?mode=${mode_parsed}&query=${query_encoded}"));

    if (response.statusCode != 200) return null;

    try {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((x) => x as String)
          .toList();
    } catch (ex) {
      print(ex);
      return null;
    }
  }
}

enum AccountSearchMode { Nickname, Username, Bio }

@JsonSerializable(explicitToJson: true)
class PublicPlayerData {
  final String nickname;
  final String username;
  final String tag;
  final Map<String, String> outfit;
  final String bio;
  final String pronouns;

  PublicPlayerData(this.nickname, this.username, this.tag, this.outfit,
      this.bio, this.pronouns);

  factory PublicPlayerData.fromJson(Map<String, dynamic> json) =>
      _$PublicPlayerDataFromJson(json);

  Map<String, dynamic> toJson() => _$PublicPlayerDataToJson(this);
}
