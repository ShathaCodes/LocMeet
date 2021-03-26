class Interest {
  int id;
  String name;

  Interest(this.id, this.name);

  Interest.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.name = parsedJson['name'];
  }
}
