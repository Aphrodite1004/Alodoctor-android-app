import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/component/Bottombar.dart';
import 'package:flutter_patient/models/consultantmodel.dart';
import 'package:flutter_patient/models/menulist.dart';
import 'package:flutter_patient/screen/Addpayment.dart';
import 'package:flutter_patient/screen/ChatPage.dart';
import 'package:flutter_patient/screen/LandingPage.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/api_endpoints.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Doctordetail extends StatefulWidget {
  Doctordetail();
  @override
  _DoctordetailState createState() => _DoctordetailState();
}

class _DoctordetailState extends State<Doctordetail> {
  String category = '';
  menulist t_menu;

  bool chat_up = false;
  bool voice_up = false;
  bool video_up = false;

  bool check_video = false;
  bool check_voice = false;
  bool check_chat = false;

  BuildContext modalcontext;

  BaseMainRepository _baseMainRepository;
  consultantmodel newmodel;
  final db = Firestore.instance;
  CollectionReference chatReference;
  String country_id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _baseMainRepository = BaseMainRepository();
    for(int i = 0; i < Configs.umodel.menus.length; i++){
      if(Configs.umodel.menus[i].id == Configs.con_doctor1.menulist_id){
        setState(() {
          category = Configs.umodel.menus[i].text;
          t_menu = Configs.umodel.menus[i];
        });
      }
    }

    check_consultant();
  }
  @override
  Widget build(BuildContext context) {
    modalcontext = context;
    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: Configs.calcheight(120) + MediaQuery.of(context).padding.top / 2,
                    padding: EdgeInsets.only(left: Configs.calcheight(31), right: Configs.calcheight(31), bottom: 0, top: MediaQuery.of(context).padding.top / 2),
                    color: primaryColor,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Share.share('https://www.alodoctor.online');
                          },
                          child: Container(
                            child: Image.asset('assets/images/ic_share_white.png',
                              width: Configs.calcheight(45),
                              height: Configs.calcheight(45),),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Configs.calcheight(10),
                              ),
                              Text(
                                Configs.con_doctor1.fname + ' ' + Configs.con_doctor1.lname,
                                style: TextStyle(
                                    fontSize: Configs.calcheight(35),
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(
                                width: Configs.calcheight(15),
                              ),
                              Text(
                                ' .د',
                                style: TextStyle(
                                    fontSize: Configs.calcheight(35),
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(
                                width: Configs.calcheight(10),
                              ),
                              Image.asset('assets/images/ic_bright.png',
                                width: Configs.calcheight(28),
                                height: Configs.calcheight(28),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            child: Image.asset('assets/images/ic_rightarrow.png',
                              width: Configs.calcheight(28),
                              height: Configs.calcheight(28),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: Configs.calcheight(254),
                    color: primaryColor,
                    child: Row(
                      children: [
                        Container(
                          width: Configs.calcheight(150),
                          height: Configs.calcheight(210),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Configs.calcheight(10))),
                            color: Colors.white,),
                          margin: EdgeInsets.all(Configs.calcheight(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Configs.calcheight(10),
                              ),
                              Flag(Configs.con_doctor1.country_code, height: Configs.calcheight(30), width: Configs.calcheight(45), fit: BoxFit.fill),
                              InkWell(
                                child:  Image.asset('assets/images/qrcode.png',
                                  width: Configs.calcheight(140),
                                  height: Configs.calcheight(140),
                                  fit: BoxFit.contain,
                                ),
                                onTap: (){
                                  launch('https://www.alodoctor.online');
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Container(
                          width: double.infinity,
                          color: Gray03,
                          child: SingleChildScrollView(
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: Configs.calcheight(150),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: Configs.calcheight(200),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Configs.calcheight(5))),
                                        color: Color(0xffDFE7F2),),
                                      margin: EdgeInsets.only(right: Configs.calcheight(20), top: Configs.calcheight(10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Text('ﺭﻗﻢ ﺍﻟﺘﺮﺧﻴﺺ',
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              textAlign: TextAlign.right,),
                                            margin: EdgeInsets.only(right: Configs.calcheight(10)),
                                            width: double.infinity,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.all(Configs.calcheight(10)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(Configs.calcheight(5))),
                                              color: Colors.white,),
                                            child: Text(
                                              Configs.con_doctor1.authorization_no,
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: Configs.calcheight(200),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Configs.calcheight(5))),
                                        color: Color(0xffDFE7F2),),
                                      margin: EdgeInsets.only(right: Configs.calcheight(20), top: Configs.calcheight(10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Text('ﺳﻨﻮﺍﺕ ﺍﻟﺨﺒﺮﺓ',
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              textAlign: TextAlign.right,),
                                            margin: EdgeInsets.only(right: Configs.calcheight(10)),
                                            width: double.infinity,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.all(Configs.calcheight(10)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(Configs.calcheight(5))),
                                              color: Colors.white,),
                                            child: Text(
                                              Configs.con_doctor1.experience,
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Configs.calcheight(5))),
                                        color: Color(0xffDFE7F2),),
                                      margin: EdgeInsets.only(right: Configs.calcheight(20), top: Configs.calcheight(10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Text('ﺍﻟﺘﺨﺼﺺ',
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              textAlign: TextAlign.right,),
                                            margin: EdgeInsets.only(right: Configs.calcheight(10)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(Configs.calcheight(10)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(Configs.calcheight(5))),
                                              color: Colors.white,),
                                            child: Text(
                                              t_menu.text,
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: Configs.calcheight(200),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Configs.calcheight(5))),
                                        color: Color(0xffDFE7F2),),
                                      margin: EdgeInsets.only(right: Configs.calcheight(20), top: Configs.calcheight(10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Text('ﺍﻟﺪﺭﺟﺔ ﺍﻟﻌﻠﻤﻴﺔ',
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              textAlign: TextAlign.right,),
                                            margin: EdgeInsets.only(right: Configs.calcheight(10)),
                                            width: double.infinity,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.all(Configs.calcheight(10)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(Configs.calcheight(5))),
                                              color: Colors.white,),
                                            child: Text(
                                              Configs.con_doctor1.degree,
                                              style: TextStyle(
                                                  color: Colors.black
                                              ),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: Configs.calcheight(8), bottom: Configs.calcheight(8), right: Configs.calcheight(16)),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text('مقدمة',
                                          style: TextStyle(
                                            color: Black02,
                                            fontSize: Configs.calcheight(24),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(right: Configs.calcheight(25)),
                                      ),
                                      Container(
                                        child: Image.asset('assets/images/ic_runvideo.png',
                                          width: Configs.calcheight(70),
                                          height: Configs.calcheight(70),),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: Configs.calcwidth(571),
                                    height: Configs.calcheight(397),
                                    color: Gray03,
                                    child: WebView(
                                      javascriptMode: JavascriptMode.unrestricted,
                                      initialUrl: 'https://www.youtube.com/embed/K1dmrYjeaL0',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(Configs.calcheight(11),),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text('عن الطبيب',
                                          style: TextStyle(
                                            color: Black02,
                                            fontSize: Configs.calcheight(24),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(right: Configs.calcheight(25)),
                                      ),
                                      Container(
                                        child: Image.asset('assets/images/ic_information.png',
                                          width: Configs.calcheight(45),
                                          height: Configs.calcheight(45),),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: Configs.calcwidth(568),
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(Configs.calcheight(24)),
                                          child: Text('السيرة الذاتية',
                                            style: TextStyle(
                                                color: Black02,
                                                fontSize: Configs.calcheight(20)
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(Configs.calcheight(24)),
                                          child: Text(Configs.con_doctor1.doctor_cv,
                                            style: TextStyle(
                                                color: Black02,
                                                fontSize: Configs.calcheight(20)
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(Configs.calcheight(11)),
                                  margin: EdgeInsets.only(right: Configs.calcheight(25)),
                                  child: Text(
                                    'نوع الخدمة الاستشارية',
                                    style: TextStyle(
                                        color: Black02,
                                        fontSize: Configs.calcheight(24)
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Visibility(
                                              child: Container(
                                                width: Configs.calcwidth(90),
                                                padding: EdgeInsets.all(Configs.calcheight(7)),
                                                child: FlatButton(
                                                    color: Green01,
                                                    textColor: Colors.white,
                                                    padding: EdgeInsets.all(0),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(Configs.calcheight(7)),
                                                    ),
                                                    onPressed: (){
                                                      maaking_consultant('typing');
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/ic_left1.png',
                                                          width: Configs.calcheight(25),
                                                          height: Configs.calcheight(25),),
                                                        Container(
                                                          child: Text(
                                                            'بدء',
                                                            style: TextStyle(
                                                                fontSize: Configs.calcheight(25),
                                                                color: Colors.white
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          margin: EdgeInsets.only(left: Configs.calcheight(7)),
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ),
                                              visible: check_chat,
                                            ),
                                            Text(
                                              '\$' + Configs.con_doctor1.remain_chat.toString(),
                                              style: TextStyle(
                                                  fontSize: Configs.calcheight(25),
                                                  color: Black02
                                              ),
                                            ),
                                            Container(
                                              width: Configs.calcwidth(30),
                                              padding: EdgeInsets.all(Configs.calcheight(7)),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                padding: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(Configs.calcheight(7)),
                                                ),
                                                onPressed: (){
                                                  setState(() {
                                                    chat_up = !chat_up;
                                                  });
                                                },
                                                child: Image.asset(!chat_up ? 'assets/images/ic_down1.png': 'assets/images/ic_up1.png',
                                                  width: Configs.calcheight(25),
                                                  height: Configs.calcheight(25),),
                                              ),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.3,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: Configs.calcheight(20)),
                                        child: Text(
                                          'محادثة كتابية',
                                          style: TextStyle(
                                              fontSize: Configs.calcheight(20),
                                              color: Black02
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                chat_up ? Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.5, color: Colors.grey),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(bottom: 25),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Text('تحدث مع الطبيب مباشرة', style: TextStyle(
                                              fontSize: Configs.calcheight(20),
                                              color: Black02
                                          ),
                                            textAlign: TextAlign.right,),
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top: Configs.calcheight(15)),
                                        ),
                                        Container(
                                          child: Text("""لديك الفرصة للتحدث مع طبيب حول موضوع محدد والمستشار مسؤول عن الإجابة على سؤالك
                                      بالكامل. الحد الأقصى لوقت استجابة الطبيب هو 10 ساعات بعد بدء المحادثة.""", style: TextStyle(
                                              fontSize: Configs.calcheight(20),
                                              color: Black02
                                          ),
                                            textAlign: TextAlign.right,),
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top: Configs.calcheight(15)),
                                        )
                                      ],
                                    ),
                                  ),
                                ): Container(),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Visibility(
                                              child: Container(
                                                width: Configs.calcwidth(90),
                                                padding: EdgeInsets.all(Configs.calcheight(7)),
                                                child: FlatButton(
                                                    color: Green01,
                                                    textColor: Colors.white,
                                                    padding: EdgeInsets.all(0),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(Configs.calcheight(7)),
                                                    ),
                                                    onPressed: (){
                                                      maaking_consultant('voice');
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/ic_left1.png',
                                                          width: Configs.calcheight(25),
                                                          height: Configs.calcheight(25),),
                                                        Container(
                                                          child: Text(
                                                            'بدء',
                                                            style: TextStyle(
                                                                fontSize: Configs.calcheight(25),
                                                                color: Colors.white
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          margin: EdgeInsets.only(left: Configs.calcheight(7)),
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ),
                                              visible: check_voice,
                                            ),
                                            Text(
                                              '\$' + Configs.con_doctor1.remain_call.toString(),
                                              style: TextStyle(
                                                  fontSize: Configs.calcheight(25),
                                                  color: Black02
                                              ),
                                            ),
                                            Container(
                                              width: Configs.calcwidth(30),
                                              padding: EdgeInsets.all(Configs.calcheight(7)),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                padding: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(Configs.calcheight(7)),
                                                ),
                                                onPressed: (){
                                                  setState(() {
                                                    voice_up = !voice_up;
                                                  });
                                                },
                                                child: Image.asset(!voice_up ? 'assets/images/ic_down1.png': 'assets/images/ic_up1.png',
                                                  width: Configs.calcheight(25),
                                                  height: Configs.calcheight(25),),
                                              ),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.3,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: Configs.calcheight(20)),
                                        child: Text(
                                          'محادثة صوتية',
                                          style: TextStyle(
                                              fontSize: Configs.calcheight(20),
                                              color: Black02
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                voice_up ? Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.5, color: Colors.grey),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(bottom: 25),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Text("""سيقوم الطبيب بمدة تقل عن 3 ساعات بالاتصال بك والحد الأقصى 15 دقيقة لإجراء محادثة معك""", style: TextStyle(
                                              fontSize: Configs.calcheight(20),
                                              color: Black02
                                          ),
                                            textAlign: TextAlign.right,),
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top: Configs.calcheight(15)),
                                        )
                                      ],
                                    ),
                                  ),
                                ): Container(),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Visibility(
                                              child: Container(
                                                width: Configs.calcwidth(90),
                                                padding: EdgeInsets.only(top: Configs.calcheight(7), right: Configs.calcheight(7), left: Configs.calcheight(7)),
                                                child: FlatButton(
                                                    color: Green01,
                                                    textColor: Colors.white,
                                                    padding: EdgeInsets.all(0),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(Configs.calcheight(7)),
                                                    ),
                                                    onPressed: (){
                                                      maaking_consultant('video');
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/ic_left1.png',
                                                          width: Configs.calcheight(25),
                                                          height: Configs.calcheight(25),),
                                                        Container(
                                                          child: Text(
                                                            'بدء',
                                                            style: TextStyle(
                                                                fontSize: Configs.calcheight(25),
                                                                color: Colors.white
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          margin: EdgeInsets.only(left: Configs.calcheight(7)),
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ),
                                              visible: check_video,
                                            ),
                                            Text(
                                              '\$' + Configs.con_doctor1.remain_video.toString(),
                                              style: TextStyle(
                                                  fontSize: Configs.calcheight(25),
                                                  color: Black02
                                              ),
                                            ),
                                            Container(
                                              width: Configs.calcwidth(30),
                                              padding: EdgeInsets.all(Configs.calcheight(7)),
                                              child: FlatButton(
                                                color: Colors.transparent,
                                                padding: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(Configs.calcheight(7)),
                                                ),
                                                onPressed: (){
                                                  setState(() {
                                                    video_up = !video_up;
                                                  });
                                                },
                                                child: Image.asset(!video_up ? 'assets/images/ic_down1.png': 'assets/images/ic_up1.png',
                                                  width: Configs.calcheight(25),
                                                  height: Configs.calcheight(25),),
                                              ),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.3,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: Configs.calcheight(20)),
                                        child: Text(
                                          'محادثة فيديو',
                                          style: TextStyle(
                                              fontSize: Configs.calcheight(20),
                                              color: Black02
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                video_up ? Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.5, color: Colors.grey),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(bottom: 25),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Text("""سيقوم الطبيب بمدة لا تقل عن 3 ساعات بالاتصال بك والحد الأقصى 15 دقيقة لإجراء محادثة
                                    معك""", style: TextStyle(
                                              fontSize: Configs.calcheight(20),
                                              color: Black02
                                          ),
                                            textAlign: TextAlign.right,),
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top: Configs.calcheight(15)),
                                        )
                                      ],
                                    ),
                                  ),
                                ): Container(),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(Configs.calcheight(11)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('الخدمة مضمونة',
                                        style: TextStyle(
                                            color: Black02,
                                            fontSize: Configs.calcheight(24)
                                        ),),
                                      SizedBox(
                                        width: Configs.calcheight(25),
                                      ),
                                      Image.asset('assets/images/ic_hand.png',
                                        width: Configs.calcheight(37),
                                        height: Configs.calcheight(37),),
                                    ],
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(bottom: 10),
                                      width: double.infinity,
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'متخصص موثّق',
                                                style: TextStyle(
                                                    fontSize: Configs.calcheight(25),
                                                    color: Black02
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'محادثتك مع المتخصص محمية بالكامل',
                                                style: TextStyle(
                                                    fontSize: Configs.calcheight(18),
                                                    color: Black02
                                                ),
                                                textAlign: TextAlign.right,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: Configs.calcheight(15),
                                          ),
                                          Image.asset('assets/images/ic_user.png',
                                            width: Configs.calcheight(100),
                                            height: Configs.calcheight(100),),
                                        ],
                                      ),
                                    )
                                ),
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(bottom: 10),
                                      width: double.infinity,
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [

                                                  Text(
                                                    'ضمان الخصوصية ',
                                                    style: TextStyle(
                                                        fontSize: Configs.calcheight(25),
                                                        color: Black02
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  Text(
                                                    '%100',
                                                    style: TextStyle(
                                                        fontSize: Configs.calcheight(25),
                                                        color: Black02
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'محادثتك مع المتخصص محمية بالكامل',
                                                style: TextStyle(
                                                    fontSize: Configs.calcheight(18),
                                                    color: Black02
                                                ),
                                                textAlign: TextAlign.right,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: Configs.calcheight(15),
                                          ),
                                          Image.asset('assets/images/ic_checking.png',
                                            width: Configs.calcheight(100),
                                            height: Configs.calcheight(100),),
                                        ],
                                      ),
                                    )
                                ),
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(bottom: 10),
                                      margin: EdgeInsets.only(bottom: 50),
                                      width: double.infinity,
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'ضمان النتائج',
                                                style: TextStyle(
                                                    fontSize: Configs.calcheight(25),
                                                    color: Black02
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'إذا لم تكن راضيًا ، نضمن استرداد مبلغ الاستشارة',
                                                style: TextStyle(
                                                    fontSize: Configs.calcheight(18),
                                                    color: Black02
                                                ),
                                                textAlign: TextAlign.right,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: Configs.calcheight(15),
                                          ),
                                          Image.asset('assets/images/ic_gurantee.png',
                                            width: Configs.calcheight(100),
                                            height: Configs.calcheight(100),),
                                        ],
                                      ),
                                    )
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                  ),
                  Bottombar(1)
                ],
              ),
            ),
            Positioned(
              bottom: Configs.calcheight(150),
              left: 0,
              child: Row(
                children: [
                  Visibility(
                    child: Material(
                      child:  Container(
                        width: Configs.calcheight(103),
                        height: Configs.calcheight(103),
                        margin: EdgeInsets.only(left: Configs.calcwidth(13/2), right:  Configs.calcwidth(13/2)),
                        child: FlatButton(
                          color: Green01,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(Configs.calcheight(103/2)),
                          ),
                          onPressed: () {
                            maaking_consultant('video');
                          },
                          child: Image.asset('assets/images/ic_videowhite.png',
                            width: Configs.calcheight(50),
                            height: Configs.calcheight(50),
                          ),
                        ),
                      ),
                      shape:  CircleBorder(),
                      elevation: 10,
                    ),
                    visible: check_video,
                  ),
                  Visibility(
                    child: Material(
                      child: Container(
                        width: Configs.calcheight(103),
                        height: Configs.calcheight(103),
                        margin: EdgeInsets.only(left: Configs.calcwidth(13/2), right:  Configs.calcwidth(13/2)),
                        child: FlatButton(
                          color: Green01,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(Configs.calcheight(103/2)),
                          ),
                          onPressed: () {
                            maaking_consultant('voice');
                          },
                          child: Image.asset('assets/images/ic_voicewhite.png',
                            width: Configs.calcheight(50),
                            height: Configs.calcheight(50),
                          ),
                        ),
                      ),
                      elevation: 10,
                      shape: CircleBorder(),
                    ),
                    visible: check_voice,
                  ),
                  Visibility(
                    child:  Material(
                      child: Container(
                        width: Configs.calcheight(103),
                        height: Configs.calcheight(103),
                        margin: EdgeInsets.only(left: Configs.calcwidth(13/2), right:  Configs.calcwidth(13/2)),
                        child: FlatButton(
                          color: Green01,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(Configs.calcheight(103/2)),
                          ),
                          onPressed: () {
                            maaking_consultant('typing');
                          },
                          child: Image.asset('assets/images/ic_chat_white.png',
                            width: Configs.calcheight(50),
                            height: Configs.calcheight(50),
                          ),
                        ),
                      ),
                      elevation: 10,
                      shape: CircleBorder(),
                    ),
                    visible: check_chat,
                  )
                ],
              ),
            ),
            Positioned(
              top: Configs.calcheight(160),
              right: Configs.calcheight(15),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Gray02,
                    border: Border.all(
                        color: Green01, width: Configs.calcheight(7))),
                margin: EdgeInsets.only(top: Configs.calcheight(20)),
                height: Configs.calcheight(300),
                width: Configs.calcheight(300),
                alignment: Alignment.center,
                child: Container(
                    width: Configs.calcheight(300),
                    height: Configs.calcheight(300),
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(APIEndPoints.mediaurl + Configs.con_doctor1.photo)))),
              ),
            )
          ],
        )
    );
  }
  Future<bool> calculatemodel() async {
    List<consultantmodel> consultArr;
    List<consultantmodel> new_consultArr;

    consultArr = List();
    new_consultArr = List();


    String response = await _baseMainRepository.getconsultant();
    var result = jsonDecode(response);
    if(result['status'] == 'success'){

      Map<String, dynamic> decodedJSON = {};
      decodedJSON = jsonDecode(response) as Map<String, dynamic>;
      consultArr = decodedJSON['consultant'] != null ? List.from(decodedJSON['consultant']).map((e) => consultantmodel.fromJSON(e)).toList() : [];
      for(int i = 0; i < consultArr.length; i++){
        if(consultArr[i].status == 'now'){
          new_consultArr.add(consultArr[i]);
        }
      }
      for(int i = 0; i < new_consultArr.length; i++){
        if(new_consultArr[i].doctorId == Configs.con_doctor1.id && new_consultArr[i].patientId == Configs.umodel.id){
          Configs.conmodel = new_consultArr[i];
          return true;
        }
      }
      // Configs.con.getConsultant();
    }
    return false;
  }
  Future<void> check_consultant() async {
    if(!Configs.auth_flag){
      setState(() {
        check_video = true;
        check_voice = true;
        check_chat = true;
      });
      return;
    }
    List<consultantmodel> consultArr;
    List<consultantmodel> new_consultArr;
    List<consultantmodel> old_consultArr;

    consultArr = List();
    new_consultArr = List();
    old_consultArr = List();


    String response = await _baseMainRepository.getconsultant();
    var result = jsonDecode(response);
    if(result['status'] == 'success'){
      Map<String, dynamic> decodedJSON = {};
      decodedJSON = jsonDecode(response) as Map<String, dynamic>;
      consultArr = decodedJSON['consultant'] != null ? List.from(decodedJSON['consultant']).map((e) => consultantmodel.fromJSON(e)).toList() : [];
      for(int i = 0; i < consultArr.length; i++){
        if(consultArr[i].status != 'now'){
          old_consultArr.add(consultArr[i]);
        } else{
          new_consultArr.add(consultArr[i]);
        }
      }
    }
    bool t_video = false, t_audio = false, t_chat = false;
    for(int i = 0; i < new_consultArr.length; i++){
      if(new_consultArr[i].doctorId == Configs.con_doctor1.id && new_consultArr[i].type == 'video' ){
        t_video = true; break;
      }
      if(new_consultArr[i].doctorId == Configs.con_doctor1.id && new_consultArr[i].type == 'voice'){
        t_audio = true; break;
      }
      if(new_consultArr[i].doctorId == Configs.con_doctor1.id && new_consultArr[i].type == 'typing') {
        t_chat = true; break;
      }
    }
    if(!t_video && !t_audio && !t_chat){
      setState(() {
        check_chat = true;
        check_video = true;
        check_voice = true;
      });
    }
    if(t_video){
      setState(() {
        check_chat = false;
        check_video = true;
        check_voice = false;
      });
    }
    if(t_audio) {
      setState(() {
        check_chat = false;
        check_video = false;
        check_voice = true;
      });
    }
    if(t_chat) {
      setState(() {
        check_chat = true;
        check_video = false;
        check_voice = false;
      });
    }
  }

  Future<void> maaking_consultant(String ty) async {
    if(!Configs.auth_flag){
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => LandingPage()
      ));
      return;
    }
    String response = await _baseMainRepository.patient_startConsultant(
        Configs.con_doctor1.id,
        Configs.umodel.id,
        Configs.con_doctor1.menulist_id,
        ty
    );
    var result = jsonDecode(response);
    if(result['status'] == 'success'){
      newmodel = consultantmodel.fromJSON(result['consultant']);
      await sendwelcomemessage();
      if(ty == 'voice'){
        Configs.umodel.money = Configs.umodel.money - Configs.con_doctor1.remain_call;
        Configs.con.getConsultant();
        openvoicemodal();
      }
      if(ty == 'video'){
        Configs.umodel.money = Configs.umodel.money - Configs.con_doctor1.remain_video;
        Configs.con.getConsultant();
        openvideomodal();
      }
      if(ty == 'typing') {
        Configs.umodel.money = Configs.umodel.money - Configs.con_doctor1.remain_chat;
        Configs.con.getConsultant();
        openchatmodal();
      }
    } else if(result['status'] == 'noenough'){
      openpaymentmodal();
    } else{
      bool result = await calculatemodel();
      Configs.con_doctor =  Configs.con_doctor1;
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatPage()
      ));
    }
  }

  void openvoicemodal() {
    showDialog(
        barrierDismissible: true,
        context: modalcontext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(9)))),
            child: Container(
                width: Configs.calcwidth(513),
                height: Configs.calcheight(462),
                padding: EdgeInsets.all(Configs.calcheight(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/images/ic_success.png',
                      width: Configs.calcheight(121),
                      height: Configs.calcheight(121),),
                    SizedBox(
                      height: Configs.calcheight(23),
                    ),
                    Image.asset('assets/images/ic_voice.png',
                      width: Configs.calcheight(40),
                      height: Configs.calcheight(40),),
                    SizedBox(
                      height: Configs.calcheight(10),
                    ),
                    Text('ﺗﻢ ﻃﻠﺐ ﺍﻷﺗﺼﺎﻝ ﺍﻟﺼﻮﺗﻲ ﻣﻊ ﺍﻟﻄﺒﻴﺐ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(25),

                      ),),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Configs.calcheight(10),
                          ),
                          Text(Configs.con_doctor1.fname + ' ' + Configs.con_doctor1.lname,
                            style: TextStyle(
                                fontSize: Configs.calcheight(35),
                                color: Colors.black
                            ),),
                          SizedBox(
                            width: 20,
                          ),
                          Text(' .د',
                            style: TextStyle(
                                fontSize: Configs.calcheight(35),
                                color: Colors.black
                            ),),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset('assets/images/ic_bright.png',
                            width: Configs.calcheight(30),
                            height: Configs.calcheight(30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Configs.calcheight(20)),
                      child: Text(
                        'يمكنك البدأ بطرح سؤالك وارسال الوثائق الطبية وسيقوم الطبيب بالاتصال',
                        style: TextStyle(
                          fontSize: Configs.calcheight(25),
                          color: Colors.black,

                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
            ),
          );
        }).then((value) async {
      bool result = await calculatemodel();
      Configs.con_doctor =  Configs.con_doctor1;
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatPage()
      ));
    });
  }

  void openvideomodal() {
    showDialog(
        barrierDismissible: true,
        context: modalcontext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(9)))),
            child: Container(
                width: Configs.calcwidth(513),
                height: Configs.calcheight(462),
                padding: EdgeInsets.all(Configs.calcheight(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/images/ic_success.png',
                      width: Configs.calcheight(121),
                      height: Configs.calcheight(121),),
                    SizedBox(
                      height: Configs.calcheight(23),
                    ),
                    Image.asset('assets/images/ic_video.png',
                      width: Configs.calcheight(40),
                      height: Configs.calcheight(40),),
                    SizedBox(
                      height: Configs.calcheight(10),
                    ),
                    Text('ﺗﻢ ﻃﻠﺐ ﺍتصال فيديو ﻣﻊ ﺍﻟﻄﺒﻴﺐ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(25),

                      ),),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Configs.calcheight(10),
                          ),
                          Text(Configs.con_doctor1.fname + ' ' + Configs.con_doctor1.lname,
                            style: TextStyle(
                                fontSize: Configs.calcheight(35),
                                color: Colors.black
                            ),),
                          SizedBox(
                            width: 20,
                          ),
                          Text( ' .د',
                            style: TextStyle(
                                fontSize: Configs.calcheight(35),
                                color: Colors.black
                            ),),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset('assets/images/ic_bright.png',
                            width: Configs.calcheight(30),
                            height: Configs.calcheight(30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Configs.calcheight(20)),
                      child: Text(
                        'يمكنك البدأ بطرح سؤالك وارسال الوثائق الطبية وسيقوم الطبيب بالاتصال',
                        style: TextStyle(
                          fontSize: Configs.calcheight(25),
                          color: Colors.black,

                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
            ),
          );
        }).then((value) async {
      bool result =  await calculatemodel();
      Configs.con_doctor =  Configs.con_doctor1;
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatPage()
      ));
    });
  }

  void openchatmodal() {
    showDialog(
        barrierDismissible: true,
        context: modalcontext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(38)))),
            child: Container(
                width: Configs.calcwidth(460),
                height: Configs.calcheight(392),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Configs.calcheight(38))),),
                padding: EdgeInsets.all(Configs.calcheight(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/ic_success.png',
                      width: Configs.calcheight(171),
                      height: Configs.calcheight(171),),
                    SizedBox(
                      height: Configs.calcheight(20),
                    ),
                    Text('ﺗﻢ بدأ ﺍﻻﺳﺘﺸﺎﺭﺓ النصية ﺑﻨﺠﺎﺡ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(25),
                      ),),
                  ],
                )
            ),
          );
        }).then((value) async {
      bool result = await calculatemodel();
      Configs.con_doctor =  Configs.con_doctor1;
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatPage()
      ));
    });
  }

  void openpaymentmodal() {
    showDialog(
        barrierDismissible: true,
        context: modalcontext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(9)))),
            child: Container(
                width: Configs.calcwidth(460),
                height: Configs.calcheight(266),
                padding: EdgeInsets.only(top: Configs.calcheight(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ﻻ ﻳﻮﺟﺪ ﻟﺪﻳﻚ ﺭﺻﻴﺪ ﻛﺎﻑ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Configs.calcheight(30)
                          ),
                        ),
                        SizedBox(
                          width: Configs.calcheight(10),
                        ),
                        Image.asset('assets/images/ic_warning1.png',
                          width: Configs.calcheight(55),
                          height: Configs.calcheight(55),),
                      ],
                    ),
                    SizedBox(
                      height: Configs.calcheight(20),
                    ),
                    Text('ﻳﺮﺟﻰ ﺍﺿﺎﻓﺔ ﺭﺻﻴﺪ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Configs.calcheight(30)
                      ),),
                    Container(
                      width: Configs.calcwidth(272),
                      height: Configs.calcheight(72),
                      margin: EdgeInsets.only(top: Configs.calcheight(23)
                      ),
                      child: FlatButton(
                          color: primaryColor,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(Configs.calcheight(8)),
                          ),
                          onPressed: () {
                            Navigator.popUntil(context, ModalRoute.withName('/consultant'));
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Addpayment()
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ﺍﺿﺎﻓﺔ ﺭﺻﻴﺪ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Configs.calcheight(30)
                                ),
                              ),
                              SizedBox(
                                width: Configs.calcheight(26),
                              ),
                              Image.asset('assets/images/ic_add.png',
                                width: Configs.calcheight(47),
                                height: Configs.calcheight(47),
                              ),
                            ],
                          )
                      ),
                    ),
                  ],
                )
            ),
          );
        });
  }

  Future<void> sendwelcomemessage() async {
    chatReference =
        db.collection("chats")
            .document(newmodel.id.toString())
            .collection('messages');
    String txt1 =  ' ﺃﻧﺎ ﺍﻟﻄﺒﻴﺐ '+ ( Configs.con_doctor1.fname + ' ' + Configs.con_doctor1.lname )+ '\n'+ (  ' ﻣﺘﺨﺼﺺ ﻓﻲ ' + Configs.con_doctor1.text.toString()  );
    String txt2 = "ﻫﻨﺎ ﺗﺴﺘﻄﻴﻊ ﺍﻟﺘﺤﺪﺙ ﻣﻌﻲ ﻣﺒﺎﺷﺮﺓ ﻭﻃﺮﺡ ﺍﺳﺄﻟﺘﻚ";
    String txt3 =  "ﻳﻤﻜﻨﻚ ﺍﺭﺳﺎﻝ ﺳﺆﺍﻟﻚ ﺍﻵﻥ ﻭﺗﻔﺎﺻﻴﻞ ﺣﺎﻟﺘﻚ ﻛﻤﺎ ﻳﻤﻜﻨﻚ ﺍﺭﺳﺎﻝ ﺍﻟﻤﻠﻔﺎﺕ ﺍﻭ ﺻﻮﺭﺓ عن حالتك";
    String txt4 = "ﻛﻤﺎ ﻳﻤﻜﻨﻚ ﺍﺭﺳﺎﻝ ﺍﻟﻤﻠﻔﺎﺕ ﺍﻭ ﺻﻮﺭﺓ عن حالتك";

    await chatReference.add({
      'type': 'Welcome',
      'text': txt1,
      'sender_id': newmodel.patientId.toString(),
      'receiver_id': newmodel.doctorId.toString(),
      'isRead': true,
      'image_url': '',
      'time': FieldValue.serverTimestamp(),
    });
    await chatReference.add({
      'type': 'Welcome',
      'text': txt2,
      'sender_id': newmodel.patientId.toString(),
      'receiver_id': newmodel.doctorId.toString(),
      'isRead': true,
      'image_url': '',
      'time': FieldValue.serverTimestamp(),
    });
    await chatReference.add({
      'type': 'Welcome',
      'text': txt3 ,
      'sender_id': newmodel.patientId.toString(),
      'receiver_id': newmodel.doctorId.toString(),
      'isRead': true,
      'image_url': '',
      'time': FieldValue.serverTimestamp(),
    });
  }


}
