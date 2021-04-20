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
    this.location = parsedJson['Location'].fromJson();
  }

  void getTokenData() async {
    TokenService tokenService = new TokenService();
    tokenService.getDecodedToken().then((decodedToken) => {
          this.nickname = decodedToken["nickname"],
          this.id = decodedToken["id"],
          this.isAdmin = decodedToken["isAdmin"],
          this.location = Location.fromJson(decodedToken["Location"]),
          this.interests = decodedToken['Interests']
              .map((i) => Interest.fromJson(i))
              .toList()
        });
  }
}
