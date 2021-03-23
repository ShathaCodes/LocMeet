import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class ApiProvider {
  static const addr = "your ip address";

  ApiProvider();

  Future<http.Response> doLogin(
      String nickname, String password, String ip) async {
    String _url = 'http://$ip:3000/login';

    var body = {"nickname": nickname, "password": password};

    return http.post(_url, body: body);
  }

  Future<http.Response> doRegistration(
      String nickname, String password, String ip) async {
    String _url = 'http://$ip:3000/register';

    var body = {
      "nickname": nickname,
      "password": password,
      'location': "",
      "isAdmin": "false"
    };

    return http.post(_url, body: body);
  }
}
