import 'dart:collection';

import 'package:LoginFlutter/models/interest.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/models/meeting.dart';
import 'package:LoginFlutter/token_service.dart';

class User {
  int id;
  String nickname;
  String password;
  bool isAdmin;
  List interests = new List();
  LocationUser location;
  List myMeetings = new List();
  List meetings = new List();
  User();

  //User(this.id, this.nickname, this.password, this.isAdmin);

  User.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.nickname = parsedJson['nickname'];
    this.isAdmin = parsedJson['isAdmin'];
    if (parsedJson['Interests'] != null)
      this.interests =
          parsedJson['Interests'].map((i) => Interest.fromJson(i)).toList();
    if (parsedJson['Location'] != null)
      this.location = LocationUser.fromJson(parsedJson['Location']);
    if (parsedJson['meetings'] != null)
      this.meetings =
          parsedJson['meetings'].map((i) => Meeting.fromJson(i)).toList();
    if (parsedJson['meeting'] != null)
      this.myMeetings =
          parsedJson['meeting'].map((i) => Meeting.fromJson(i)).toList();
  }

  Future<User> getTokenData() async {
    TokenService tokenService = new TokenService();
    User u = new User();
    tokenService.getDecodedToken().then((decodedToken) => {
          u.nickname = decodedToken["nickname"],
          u.id = decodedToken["id"],
          u.isAdmin = decodedToken["isAdmin"],
          u.location = LocationUser.fromJson(decodedToken["Location"]),
          if (decodedToken['Interests'] != null)
            u.interests = decodedToken['Interests']
                .map((i) => Interest.fromJson(i))
                .toList()
        });
    return u;
  }
}
