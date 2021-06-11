import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/models/user.dart';

class Meeting {
  int id;
  DateTime date;
  User creator;
  List guests = new List();
  LocationUser location;
  Meeting();

  Meeting.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.date = DateTime.parse(parsedJson['date'].toString());
    if (parsedJson['creator'] != null)
      this.creator = User.fromJson(parsedJson["creator"]);
    if (parsedJson['guests'] != null)
      this.guests = parsedJson['guests'].map((i) => User.fromJson(i)).toList();
    if (parsedJson['Location'] != null)
      this.location = LocationUser.fromJson(parsedJson['Location']);
  }
}
