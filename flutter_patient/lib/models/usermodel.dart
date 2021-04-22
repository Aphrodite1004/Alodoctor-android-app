import 'package:flutter_patient/models/countrymodel.dart';
import 'package:flutter_patient/models/doctor.dart';
import 'package:flutter_patient/models/menulist.dart';

class usermodel {
  int id;
  String name;
  String email;
  String phone;
  String password;
  String username;
  String photo;
  int money;
  int sex;
  String address;
  String moreInfo;
  String status;
  String callLogin;
  String callPassword;
  int callId;
  String createdAt;
  String updatedAt;
  String fcmToken;
  List<menulist> menus;
  List<doctor> doctors;

  usermodel.fromJson(Map<String, dynamic> json) {
    try{
      id = json['patient']['id'] != null ? json['patient']['id'] : 0;
      name = json['patient']['name'] != null ? json['patient']['name'] : '';
      email = json['patient']['email'] != null ? json['patient']['email'] : '';
      phone = json['patient']['phone'] != null ? json['patient']['phone'] : '';
      password = json['patient']['password'] != null ? json['patient']['password'] : '';
      username = json['patient']['username'] != null ? json['patient']['username'] : '';
      photo = json['patient']['photo'] != null ? json['patient']['photo'] : '';
      money = json['patient']['money'] != null ? json['patient']['money'] : 0;
      sex = json['patient']['sex'] != null ? json['patient']['sex'] : 0 ;
      address = json['patient']['address'] != null ? json['patient']['address']: '';
      moreInfo = json['patient']['more_info'] != null ? json['patient']['more_info']: '';
      status = json['patient']['status'] != null ? json['patient']['status'] : '';
      callLogin = json['patient']['call_login'] != null ? json['patient']['call_login'] : '';
      callPassword = json['patient']['call_password'] != null ? json['patient']['call_password'] : '';
      callId = json['patient']['call_id'] != null ? json['patient']['call_id']: 0;
      createdAt = json['patient']['created_at'] != null ? json['patient']['created_at']: '';
      updatedAt = json['patient']['updated_at'] != null ?  json['patient']['updated_at']: '';
      fcmToken = json['patient']['fcmToken'] != null ? json['patient']['fcmToken'] : '';
      menus = json['menulist'] != null ? List.from(json['menulist']).map((e) => menulist.fromJSON(e)).toList() : [];
      doctors = json['doctor'] != null ? List.from(json['doctor']).map((e) => doctor.fromJSON(e)).toList() : [];
    } catch(e){
      print(e);
    }
  }
  usermodel.fromJsondata(Map<String, dynamic> json) {
    try{
      menus = json['menulist'] != null ? List.from(json['menulist']).map((e) => menulist.fromJSON(e)).toList() : [];
      doctors = json['doctor'] != null ? List.from(json['doctor']).map((e) => doctor.fromJSON(e)).toList() : [];
    } catch(e){
      print(e);
    }
  }
}
