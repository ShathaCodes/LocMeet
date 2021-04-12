import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'models/Interest.dart';

class ApiProvider {
  static const addr = "192.168.137.1";

  ApiProvider();
  Future<List> getInterests(ip) async {
    String _url = 'http://$ip:3000/interests';

    http.Response result = await http.get(_url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final interestsMap = jsonResponse;
      print(result.body);
      List interests = interestsMap.map((i) => Interest.fromJson(i)).toList();
      return interests;
    } else {
      return null;
    }
  }

  Future<http.Response> doLogin(
      String nickname, String password, String ip) async {
    String _url = 'http://$ip:3000/login';

    var body = {"nickname": nickname, "password": password};

    return http.post(_url, body: body);
  }

  Future<http.Response> doRegistration(
      String nickname, String password, String ip) async {
    String _url = 'http://$ip:3000/register';
    //const interests = [1, 2];
    /*List<Map<String, dynamic>> toJson() => [
          for (var item in interests) {"id": item}
        ];*/
    var body = {
      "nickname": nickname,
      "password": password,
      'location': "",
      "isAdmin": "false"
    };

    /*var body = {
      "user": {
        "nickname": nickname,
        "password": password,
        "location": "",
        "isAdmin": "false"
      },
      "interests": 
        toJson()
      
    };*/

    return http.post(_url, body: body);
  }
}
