import 'package:flutter/material.dart';
import 'package:flutter_patient/controllers/consultantcontroller.dart';
import 'package:flutter_patient/models/doctor.dart';
import 'package:flutter_patient/models/usermodel.dart';
import 'package:flutter_patient/models/consultantmodel.dart';


class Configs {
  static final String APP_ID = 'b71d83143daf4cd0b8900de43aede7e0';
  static double calheight = 0;
  static double calwidth = 0;
  static usermodel umodel;
  static consultantmodel conmodel;
  static consultantmodel callmodel;
  static consultantcontroller con;
  static doctor con_doctor;
  static doctor con_doctor1;
  static bool menu_flag = false;
  static TabController tabController;
  static TabController tabController1;
  static List<doctor> menu_dotors = List();
  static String menu_title = '';
  static BuildContext con_context;
  static bool auth_flag = false;

  static double calcheight(data){
    return calheight * data;
  }
  static double calcwidth(data){
    return calwidth * data;
  }
  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}