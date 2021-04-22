import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:flutter_patient/models/usermodel.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logincontroller extends ControllerMVC {
  BaseMainRepository _baseMainRepository;
  FirebaseMessaging _firebaseMessaging;

  logincontroller() {
    _baseMainRepository = BaseMainRepository();
    _firebaseMessaging = FirebaseMessaging();
  }
  Future<String> login(email, password) async{

   String token = await _firebaseMessaging.getToken();
   String response = await _baseMainRepository.Login(email, password, token);
   var result = jsonDecode(response);
   if(result['status'] == 'success'){
     Map<String, dynamic> decodedJSON = {};
     decodedJSON = jsonDecode(response) as Map<String, dynamic>;
     Configs.umodel = usermodel.fromJson(decodedJSON);
     Configs.auth_flag = true;
   }
   return result['status'];
  }
  Future<String> loginwithgoogle(email, name) async{

    String token = await _firebaseMessaging.getToken();
    String response = await _baseMainRepository.LoginWithSocial(email, name, token);
    var result = jsonDecode(response);
    if(result['status'] == 'success'){
      Map<String, dynamic> decodedJSON = {};
      decodedJSON = jsonDecode(response) as Map<String, dynamic>;
      Configs.umodel = usermodel.fromJson(decodedJSON);
      Configs.auth_flag = true;
    }
    return result['status'];
  }
  Future<void> saveParam(String t_email, String t_pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rememberme', 'true');
    prefs.setString('email', t_email);
    prefs.setString('password', t_pass);
    prefs.setString('social', 'false');
  }
  Future<void> saveParamwithgoogle(String t_email, String displayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rememberme', 'true');
    prefs.setString('email', t_email);
    prefs.setString('name', displayName);
    prefs.setString('social', 'true');
  }
  Future<String> getpatientlist() async{
    String response = await _baseMainRepository.patientgetlist();
    var result = jsonDecode(response);
    if(result['status'] == 'success'){
      Map<String, dynamic> decodedJSON = {};
      decodedJSON = jsonDecode(response) as Map<String, dynamic>;
      Configs.umodel = usermodel.fromJsondata(decodedJSON);
    }
    return result['status'];
  }
}