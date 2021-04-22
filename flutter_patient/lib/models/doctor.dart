class doctor {
  String text;
  String photo;
  String fname;
  String lname;
  int call_id;
  int id;
  int menulist_id;
  String fcmToken;
  int active_state;
  String degree;
  String specialization;
  String youtube_link;
  String doctor_cv;
  String pcode;
  String experience;
  String authorization_no;
  String country_code;
  int service_chat = 0;
  int service_call = 0;
  int service_video = 0;
  double rate = 0;
  int questioned = 0;
  double satisfied = 0;
  int country_id = 0;
  int remain_chat = 0;
  int remain_call = 0;
  int remain_video = 0;


  doctor.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      text = jsonMap['text'];
      photo = jsonMap['photo'];
      fname = jsonMap['fname'];
      lname = jsonMap['lname'];
      call_id = jsonMap['call_id'];
      menulist_id = jsonMap['menulist_id'];
      fcmToken = jsonMap['fcmToken'];
      active_state = jsonMap['active_state'];
      degree = jsonMap['degree'];
      specialization = jsonMap['specialization'];
      doctor_cv = jsonMap['doctor_cv'];
      pcode = jsonMap['pcode'];
      experience = jsonMap['experience'];
      authorization_no = jsonMap['authorization_no'];
      service_chat = jsonMap['service_chat'];
      service_call =  jsonMap['service_call'];
      service_video = jsonMap['service_video'];
      rate = jsonMap['rate'];
      questioned = jsonMap['questioned'];
      satisfied = jsonMap['satisfied'];
      country_id = jsonMap['country_id'];
      remain_chat = jsonMap['remain_chat'];
      remain_call = jsonMap['remain_call'];
      remain_video = jsonMap['remain_video'];
      country_code = jsonMap['country_code'];
      youtube_link = jsonMap['youtube_link'];
    } catch (e) {
      print(e);
    }
  }
}