import 'package:LoginFlutter/models/location.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'models/Interest.dart';
import 'models/therapist.dart';
import 'models/user.dart';

class ApiProvider {
  //static const addr = "192.168.1.9"; shatha
  //static const addr = "192.168.1.14"; missa
  static const addr = "192.168.1.18";

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
      print(jsonResponse);
      List users = jsonResponse.map((i) => User.fromJson(i)).toList();
      return users;
    } else {
      return null;
    }
  }

  Future<List> nearby(ip, lat, lng, dist) async {
    var queryParameters = {
      'lat': lat.toString(),
      'lng': lng.toString(),
      'distance': dist.toString()
    };

    final uri = Uri.http("$ip:3000", "/nearby", queryParameters);
    print(uri);
    http.Response result = await http.get(uri);

    print("what");
    if (result.statusCode == HttpStatus.ok) {
      List<dynamic> jsonResponse = json.decode(result.body);
      print(jsonResponse);
      List users = jsonResponse.map((i) => User.fromJson(i)).toList();
      return users;
    } else {
      return null;
    }
  }

  Future<http.Response> updateLocation(LocationUser location, String ip) async {
    String _url = 'http://$ip:3000/update_location';
    var body = {
      "id": location.id.toString(),
      "lat": location.lat.toString(),
      "lng": location.lng.toString(),
      "show": location.show.toString(),
    };

    return http.post(_url, body: body);
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
      "isAdmin": "false",
      "interests": json.encode(interests)
    };

    return http.post(
      _url,
      body: body,
      headers: {"Accept": "application/json"},
    );
  }

  Future<http.Response> updateUser(User u, String ip) async {
    String _url = 'http://$ip:3000/update_user';
    List i = new List();
    for (var interest in u.interests) i.add(interest.name);
    var body = {
      "id": u.id.toString(),
      "nickname": u.nickname,
      "password": u.password,
      "isAdmin": u.isAdmin.toString(),
      "interests": json.encode(i)
    };

    return http.post(
      _url,
      body: body,
      headers: {"Accept": "application/json"},
    );
  }

  Future<http.Response> deleteUser(int id, String ip) async {
    String _url = 'http://$ip:3000/delete_user';
    var body = {
      "id": id,
    };
    return http.post(_url, body: body);
  }
}
