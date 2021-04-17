class Therapist {
  int id;
  String name;
  int number;
  String email;
  String location;
  String description;

  Therapist(this.id, this.name, this.number, this.email, this.location,
      this.description);

  Therapist.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.name = parsedJson['name'];
    this.number = parsedJson['number'];
    this.email = parsedJson['email'];
    this.location = parsedJson['location'];
    this.description = parsedJson['description'];
  }
}
