import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/models/meeting.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'models/Interest.dart';
import 'models/therapist.dart';
import 'models/user.dart';

class ApiProvider {
  static const addr = "172.23.144.1";

  ApiProvider();

  //----------------------------------------------------------------Get methods
  Future<List> getMeetings(ip) async {
    String _url = 'http://$ip:3000/meetings';

    http.Response result = await http.get(_url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final meetingsmap = jsonResponse;
      print(result.body);
      List meetings = meetingsmap.map((i) => Meeting.fromJson(i)).toList();
      return meetings;
    } else {
      return null;
    }
  }

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
  //----------------------------------------------------------------Location

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
  //----------------------------------------------------------------User

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

  Future<http.Response> updateUser(var id, String nickname, String password,
      String ip, var interests) async {
    String _url = 'http://$ip:3000/update_user';
    var body = {
      "id": id.toString(),
      "nickname": nickname,
      "password": password,
      "interests": json.encode(interests)
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
      "id": id.toString(),
    };
    return http.post(_url, body: body);
  }

  //----------------------------------------------------------------Meeting
  Future<http.Response> addMeeting(
      String date, LocationUser location, int creatorid, String ip) async {
    String _url = 'http://$ip:3000/add_meeting';
    var body = {
      "date": date,
      "creator": creatorid.toString(),
      "Location": {
        "lat": location.lat.toString(),
        "lng": location.lng.toString(),
        "show": "true"
      }
    };
    var bb = jsonEncode(body);

    return http.post(
      _url,
      body: bb,
      headers: {"Content-Type": "application/json"},
    );
  }

  Future<http.Response> updateMeeting(int id, String date, String ip) async {
    String _url = 'http://$ip:3000/update_meeting';
    var body = {
      "id": id.toString(),
      "date": date,
    };

    return http.post(_url, body: body);
  }

  Future<http.Response> deleteMeeting(int id, String ip) async {
    String _url = 'http://$ip:3000/delete_meeting';
    var body = {
      "id": id.toString(),
    };
    return http.post(_url, body: body);
  }

  Future<http.Response> joinMeeting(
      int meetingId, int userId, String ip) async {
    String _url = 'http://$ip:3000/join_meeting';
    var body = {"meeting": meetingId.toString(), "user": userId.toString()};

    return http.post(_url, body: body);
  }

  Future<http.Response> abandonMeeting(
      int meetingId, int userId, String ip) async {
    String _url = 'http://$ip:3000/abandon_meeting';
    var body = {"meeting": meetingId.toString(), "user": userId.toString()};

    return http.post(_url, body: body);
  }
}
