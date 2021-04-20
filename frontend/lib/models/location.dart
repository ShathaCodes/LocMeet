class Location {
  int id;
  double lat;
  double lng;
  bool show;

  Location.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.lat = parsedJson['lat'];
    this.lng = parsedJson['lng'];
    this.show = parsedJson['show'];
  }
}
