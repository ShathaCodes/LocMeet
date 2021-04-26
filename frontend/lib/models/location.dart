class LocationUser {
  int id;
  double lat;
  double lng;
  bool show;
  LocationUser();

  LocationUser.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.lat = parsedJson['lat'].toDouble();
    this.lng = parsedJson['lng'].toDouble();
    this.show = parsedJson['show'];
  }
}
