import 'package:LoginFlutter/models/interest.dart';

class User {
  int id;
  String nickname;
  String password;
  String location;
  bool isAdmin;
  List interests = new List();

  User(this.id, this.nickname, this.password, this.location, this.isAdmin);

  User.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.nickname = parsedJson['nickname'];
    this.location = parsedJson['location'];
    this.isAdmin = parsedJson['isAdmin'];
    this.interests = interests =
        parsedJson['Interests'].map((i) => Interest.fromJson(i)).toList();
    ;
  }
}
