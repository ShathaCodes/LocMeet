import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'models/interest.dart';
import 'models/therapist.dart';
import 'models/user.dart';

class ApiProvider {
  //static const addr = "172.21.32.1";
  static const addr ="192.168.1.14";

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

  Future<List> getTherapists(ip) async {
    String _url = 'http://$ip:3000/therapists';

    http.Response result = await http.get(_url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List therapists = jsonResponse.map((i) => Therapist.fromJson(i)).toList();
      return therapists;
    } else {
      return [];
    }
  }

  Future<List> getUsers(ip) async {
    String _url = 'http://$ip:3000/users';

    http.Response result = await http.get(_url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List users = jsonResponse.map((i) => User.fromJson(i)).toList();
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
    String _url = 'http://$ip:3000/edit_user';
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
    String _url = 'http://$ip:3000/delete_user';
    var body = {
      "id": id,
    };
    return http.post(_url, body: body);
  }
}
