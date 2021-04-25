import 'dart:collection';

import 'package:LoginFlutter/models/interest.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/token_service.dart';

class User {
  int id;
  String nickname;
  String password;
  bool isAdmin;
  List interests = new List();
  Location location;
  User();

  //User(this.id, this.nickname, this.password, this.isAdmin);

  User.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.nickname = parsedJson['nickname'];
    this.isAdmin = parsedJson['isAdmin'];
    this.interests =
        parsedJson['Interests'].map((i) => Interest.fromJson(i)).toList();
    if (parsedJson['Location'] != null)
      this.location = Location.fromJson(parsedJson['Location']);
  }

  Future<User> getTokenData() async {
    TokenService tokenService = new TokenService();
    User u = new User();
    tokenService.getDecodedToken().then((decodedToken) => {
          u.nickname = decodedToken["nickname"],
          u.id = decodedToken["id"],
          u.isAdmin = decodedToken["isAdmin"],
          u.location = Location.fromJson(decodedToken["Location"]),
          u.interests = decodedToken['Interests']
              .map((i) => Interest.fromJson(i))
              .toList()
        });
    return u;
  }
}
