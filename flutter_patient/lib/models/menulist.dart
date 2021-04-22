class menulist {
  int id;
  String text;
  int price_chat;
  int price_voice;
  int price_video;

  menulist.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      text = jsonMap['text'];
      price_chat = jsonMap['price_chat'];
      price_voice = jsonMap['price_voice'];
      price_video = jsonMap['price_video'];
    } catch (e) {
      print(e);
    }
  }
}