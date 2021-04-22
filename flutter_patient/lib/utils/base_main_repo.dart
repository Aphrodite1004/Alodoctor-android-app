import 'dart:io';

import 'package:flutter_patient/models/menulist.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/network_utils.dart';

import 'api_endpoints.dart';

class BaseMainRepository {
  Future<String> Login(String email, String password, String token) async {
    String platform = '';
    if (Platform.isAndroid) {
      platform = 'android';
    }
    if (Platform.isIOS) {
      platform = 'ios';
    }
    Map<String, Object> values = {
      'email': email,
      'password': password,
      'remember': 1,
      'fcmToken': token,
      'platform': platform
    };
    String result =
        await NetworkHelper.makePostRequest(APIEndPoints.loginurl, values);
    return result;
  }

  Future<String> getconsultant() async {
    Map<String, Object> values = {
      'patient_id': Configs.umodel.id,
    };
    String result =
        await NetworkHelper.makePostRequest(APIEndPoints.consultanturl, values);
    return result;
  }

  Future<String> patient_startConsultant(
      int id, int id2, int menulist_id, String ty) async {
    String platform = '';
    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
    Map<String, Object> values = {
      'doctor_id': id,
      'patient_id': id2,
      'menulist_id': menulist_id,
      'type': ty
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.patient_startConsultant, values);
    return result;
  }

  Future<String> sendnotification(String s, String trim) async {
    Map<String, Object> values = {
      'noti_type': s,
      'sender_id': Configs.conmodel.patientId,
      'receiver_id': Configs.conmodel.doctorId,
      'value': trim
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.patient_sendNotification, values);
    return result;
  }

  Future<String> patient_menulist(int id) async {
    Map<String, Object> values = {
      'menulist_id': id,
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.patient_menulist, values);
    return result;
  }

  Future<String> patient_givefeedback(String trim, int ratings) async {
    print(Configs.conmodel.doctorId);
    print(Configs.conmodel.patientId);
    print(Configs.conmodel.id);
    print(ratings);
    Map<String, Object> values = {
      'doctor_id': Configs.conmodel.doctorId,
      'patient_id': Configs.conmodel.patientId,
      'rate': ratings,
      'feedback': trim,
      'type': Configs.conmodel.type,
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.patient_givefeedback, values);
    return result;
  }

  Future<String> patient_addmoney(String cardnums, String exp_month,
      String exp_year, String cvc, String amount) async {
    Map<String, Object> values = {
      'cardnumber': cardnums,
      'exp_month': exp_month,
      'exp_year': exp_year,
      'cvc': cvc,
      'patient_id': Configs.umodel.id,
      'amount': amount
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.patient_addmoney, values);
    return result;
  }

  Future<String> changepssword(String t_old, String t_new) async {
    Map<String, Object> values = {
      'current': t_old,
      'new': t_new,
      'patient_id': Configs.umodel.id,
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.changepasswordurl, values);
    return result;
  }

  Future<String> patient_register(
      String t_fullname, String t_pass, String t_email) async {
    Map<String, Object> values = {
      'name': t_fullname,
      'password': t_pass,
      'email': t_email,
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.patient_register, values);
    return result;
  }

  Future<String> sendcontact(String trim) async {
    Map<String, Object> values = {
      'name': Configs.umodel.name,
      'phone_number': Configs.umodel.phone.toString(),
      'email': Configs.umodel.email,
      'message': trim,
    };
    String result =
        await NetworkHelper.makePostRequest(APIEndPoints.contactus, values);
    return result;
  }

  Future<String> patientgetlist() async {
    Map<String, Object> values = {};
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.patientgetlist, values);
    return result;
  }

  Future<String> LoginWithSocial(email, name, String token) async {
    String platform = '';
    if (Platform.isAndroid) {
      platform = 'android';
    }
    if (Platform.isIOS) {
      platform = 'ios';
    }
    Map<String, Object> values = {
      'email': email,
      'name': name,
      'remember': 1,
      'fcmToken': token,
      'platform': platform
    };
    String result = await NetworkHelper.makePostRequest(
        APIEndPoints.loginsocialurl, values);
    return result;
  }
}
