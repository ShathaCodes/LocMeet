import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'models/Interest.dart';

class ApiProvider {
  static const ip = "192.168.1.4";

  ApiProvider();

  Future<List> getInterests() async {
    String _url = 'http://$ip:3000/interests';

    http.Response result = await http.get(_url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final interestsMap = jsonResponse['results'];
      List interests = interestsMap.map((i) => Interest.fromJson(i)).toList();
      return interests;
    } else {
      return null;
    }
  }

  Future<http.Response> doLogin(String nickname, String password) async {
    String _url = 'http://$ip:3000/login';

    var body = {"nickname": nickname, "password": password};

    return http.post(_url, body: body);
  }

  Future<http.Response> doRegistration(
    String nickname,
    String password,
  ) async {
    var interests = [1, 0, 2];

    Map<String, dynamic> toJson(i) => {"id": interests[i]};
    var json = toJson(0);

    String _url = 'http://$ip:3000/register';
    var body = {
      "user": {
        "nickname": nickname,
        "password": password,
        "location": "",
        "isAdmin": "false"
      },
    };

    return http.post(_url, body: body);
  }
}
