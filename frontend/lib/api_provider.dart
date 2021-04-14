import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'models/Interest.dart';
import 'models/user.dart';

class ApiProvider {
  static const addr = "192.168.43.247";

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

  Future<List> getUsers(ip) async {
    String _url = 'http://$ip:3000/interests';

    http.Response result = await http.get(_url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      print(result.body);
      List users = jsonResponse.map((i) => Interest.fromJson(i)).toList();
      return users;
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
      String nickname, String password, String ip, var interests) async {
    String _url = 'http://$ip:3000/register';
    var body = {
      "nickname": nickname,
      "password": password,
      'location': "",
      "isAdmin": "false",
      "interests": interests.toString()
    };

    return http.post(_url, body: body);
  }

  Future<http.Response> editUser(User u, String ip, var interests) async {
    String _url = 'http://$ip:3000/register';
    List i = new List();
    for (var interest in u.interests) i.add(interest.id);
    var body = {
      "id": u.id,
      "nickname": u.nickname,
      "password": u.password,
      'location': u.location,
      "isAdmin": u.isAdmin.toString(),
      "interests": i
    };

    return http.post(_url, body: body);
  }

  Future<http.Response> deleteUser(int id, String ip) async {
    String _url = 'http://$ip:3000/register';
    var body = {
      "id": id,
    };
    return http.post(_url, body: body);
  }
}
