class countrymodel {
  int id;
  String text;

  countrymodel.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'];
      text = json['text'];
    } catch (e) {
      print(e);
    }
  }
}