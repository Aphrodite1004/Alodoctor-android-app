import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient/component/Bottombar.dart';
import 'package:flutter_patient/component/NavDrawer.dart';
import 'package:flutter_patient/models/consultantmodel.dart';
import 'package:flutter_patient/models/menulist.dart';
import 'package:flutter_patient/screen/Addpayment.dart';
import 'package:flutter_patient/screen/ChatPage.dart';
import 'package:flutter_patient/screen/LandingPage.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/api_endpoints.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui' as ui;

class Doctordetail extends StatefulWidget {
  Doctordetail();
  @override
  _DoctordetailState createState() => _DoctordetailState();
}

class _DoctordetailState extends State<Doctordetail> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    for (int i = 0; i < Configs.umodel.menus.length; i++) {
      if (Configs.umodel.menus[i].id == Configs.con_doctor1.menulist_id) {
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
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    modalcontext = context;
    return Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        endDrawer: NavDrawer(scaffoldKey),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                    width: double.infinity,
                                    height: Configs.calcheight(120) +
                                        MediaQuery.of(context).padding.top / 2,
                                    padding: EdgeInsets.only(
                                        left: Configs.calcheight(15),
                                        right: Configs.calcheight(15),
                                        bottom: 0,
                                        top:
                                            MediaQuery.of(context).padding.top /
                                                2),
                                    color: Colors.white,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: Configs.calcheight(83),
                                                  height:
                                                      Configs.calcheight(69),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                            'assets/images/ic_rightarrow.png',
                                                          ),
                                                          fit: BoxFit.fill)),
                                                  child: FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  width: Configs.calcheight(83),
                                                  height:
                                                      Configs.calcheight(69),
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                            'assets/images/ic_share_white.png',
                                                          ),
                                                          fit: BoxFit.fill)),
                                                  child: FlatButton(
                                                    onPressed: () {
                                                      Share.share(
                                                          'https://www.alodoctor.online');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: Configs.calcheight(83),
                                              height: Configs.calcheight(69),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/images/ic_menu.png',
                                                      ),
                                                      fit: BoxFit.fill)),
                                              child: FlatButton(
                                                onPressed: () {
                                                  scaffoldKey.currentState
                                                      .openEndDrawer();
                                                },
                                              ),
                                            ),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Flag(
                                              Configs.con_doctor1.country_code,
                                              height: Configs.calcheight(60),
                                              width: Configs.calcheight(90),
                                            ))
                                      ],
                                    )),
                                Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  height: Configs.calcheight(160),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  Configs.con_doctor1.fname +
                                                      ' ' +
                                                      Configs
                                                          .con_doctor1.lname +
                                                      ' ',
                                                  textDirection:
                                                      ui.TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize:
                                                        Configs.calcheight(35),
                                                    color: Color(0xff0E0E49),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  ' .د',
                                                  textDirection:
                                                      ui.TextDirection.ltr,
                                                  style: TextStyle(
                                                    fontSize:
                                                        Configs.calcheight(35),
                                                    color: Color(0xff0E0E49),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: AutoSizeText(
                                                Configs
                                                    .con_doctor1.specialization
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      Configs.calcheight(25),
                                                  color: Color(0xff0E0E49),
                                                  fontFamily: 'IRANSansWeb',
                                                ),
                                                textDirection:
                                                    ui.TextDirection.rtl,
                                                maxLines: 1,
                                              ),
                                              height: Configs.calcheight(40),
                                            ),
                                            Text(
                                              Configs.con_doctor1.degree,
                                              textDirection:
                                                  ui.TextDirection.rtl,
                                              style: TextStyle(
                                                fontSize:
                                                    Configs.calcheight(20),
                                                fontFamily: 'IRANSansWeb',
                                                color: Color(0xff0E0E49),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      Container(
                                        width: Configs.calcheight(160),
                                        height: Configs.calcheight(160),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    Configs.calcheight(20))),
                                            color: Colors.white,
                                            image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: new NetworkImage(
                                                    APIEndPoints.mediaurl +
                                                        Configs.con_doctor1
                                                            .photo))),
                                        margin: EdgeInsets.only(
                                            right: Configs.calcheight(15),
                                            left: Configs.calcheight(15)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Visibility(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: Configs.calcheight(
                                                          90),
                                                      height:
                                                          Configs.calcheight(
                                                              90),
                                                      margin: EdgeInsets.only(
                                                          left:
                                                              Configs.calcwidth(
                                                                  13 / 2),
                                                          right:
                                                              Configs.calcwidth(
                                                                  13 / 2)),
                                                      child: FlatButton(
                                                        color:
                                                            Colors.transparent,
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        onPressed: () {
                                                          maaking_consultant(
                                                              'video');
                                                        },
                                                        child: Image.asset(
                                                          'assets/images/ic_videowhite.png',
                                                          width: Configs
                                                              .calcheight(90),
                                                          height: Configs
                                                              .calcheight(90),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$' +
                                                          Configs.con_doctor1
                                                              .remain_video
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontSize:
                                                            Configs.calcheight(
                                                                25),
                                                        color:
                                                            Color(0xff0E0E49),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                visible: check_video,
                                              ),
                                              Visibility(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: Configs.calcheight(
                                                          90),
                                                      height:
                                                          Configs.calcheight(
                                                              90),
                                                      margin: EdgeInsets.only(
                                                          left:
                                                              Configs.calcwidth(
                                                                  13 / 2),
                                                          right:
                                                              Configs.calcwidth(
                                                                  13 / 2)),
                                                      child: FlatButton(
                                                        color:
                                                            Colors.transparent,
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        onPressed: () {
                                                          maaking_consultant(
                                                              'voice');
                                                        },
                                                        child: Image.asset(
                                                          'assets/images/ic_voicewhite.png',
                                                          width: Configs
                                                              .calcheight(90),
                                                          height: Configs
                                                              .calcheight(90),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$' +
                                                          Configs.con_doctor1
                                                              .remain_call
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontSize:
                                                            Configs.calcheight(
                                                                25),
                                                        color:
                                                            Color(0xff0E0E49),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                visible: check_voice,
                                              ),
                                              Visibility(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: Configs.calcheight(
                                                          90),
                                                      height:
                                                          Configs.calcheight(
                                                              90),
                                                      margin: EdgeInsets.only(
                                                          left:
                                                              Configs.calcwidth(
                                                                  13 / 2),
                                                          right:
                                                              Configs.calcwidth(
                                                                  13 / 2)),
                                                      child: FlatButton(
                                                        color:
                                                            Colors.transparent,
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        onPressed: () {
                                                          maaking_consultant(
                                                              'typing');
                                                        },
                                                        child: Image.asset(
                                                          'assets/images/ic_chat_white.png',
                                                          width: Configs
                                                              .calcheight(90),
                                                          height: Configs
                                                              .calcheight(90),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$' +
                                                          Configs.con_doctor1
                                                              .remain_chat
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontSize:
                                                            Configs.calcheight(
                                                                25),
                                                        color:
                                                            Color(0xff0E0E49),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                visible: check_chat,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: Configs.calcheight(15),
                                              top: 20),
                                          width: Configs.calcwidth(280),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      'عن الطبيب',
                                                      style: TextStyle(
                                                        fontSize:
                                                            Configs.calcheight(
                                                                30),
                                                        color:
                                                            Color(0xff0E0E49),
                                                      ),
                                                      textDirection:
                                                          ui.TextDirection.rtl,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Configs.calcheight(
                                                                25)),
                                                  ),
                                                  Container(
                                                    child: Image.asset(
                                                      'assets/images/ic_information.png',
                                                      width: Configs.calcheight(
                                                          45),
                                                      height:
                                                          Configs.calcheight(
                                                              45),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      Configs.con_doctor1
                                                          .authorization_no,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff0E0E49),
                                                        fontFamily:
                                                            'IRANSansWeb',
                                                        fontSize:
                                                            Configs.calcheight(
                                                                20),
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'ﺭﻗﻢ ﺍﻟﺘﺮﺧﻴﺺ',
                                                      textDirection:
                                                          ui.TextDirection.rtl,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff0E0E49),
                                                        fontFamily:
                                                            'IRANSansWeb',
                                                        fontSize:
                                                            Configs.calcheight(
                                                                20),
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                      maxLines: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      Configs.con_doctor1
                                                          .experience,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff0E0E49),
                                                        fontFamily:
                                                            'IRANSansWeb',
                                                        fontSize:
                                                            Configs.calcheight(
                                                                20),
                                                      ),
                                                      textDirection:
                                                          ui.TextDirection.rtl,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'ﺳﻨﻮﺍﺕ ﺍﻟﺨﺒﺮﺓ',
                                                      textDirection:
                                                          ui.TextDirection.rtl,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff0E0E49),
                                                        fontSize:
                                                            Configs.calcheight(
                                                                20),
                                                        fontFamily:
                                                            'IRANSansWeb',
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                      maxLines: 1,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                      right: Configs.calcheight(15),
                                      top: 5,
                                      bottom: 5),
                                  child: Text(
                                    Configs.con_doctor1.doctor_cv,
                                    textDirection: ui.TextDirection.rtl,
                                    style: TextStyle(
                                      color: Color(0xff0E0E49),
                                      fontFamily: 'IRANSansWeb',
                                      fontSize: Configs.calcheight(20),
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                      top: Configs.calcheight(8),
                                      bottom: Configs.calcheight(8),
                                      right: Configs.calcheight(16)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text(
                                          'مقدمة',
                                          textDirection: ui.TextDirection.rtl,
                                          style: TextStyle(
                                              color: Color(0xff0E0E49),
                                              fontSize: Configs.calcheight(30)),
                                        ),
                                        margin: EdgeInsets.only(
                                            right: Configs.calcheight(25)),
                                      ),
                                      Container(
                                        child: Image.asset(
                                          'assets/images/ic_runvideo.png',
                                          width: Configs.calcheight(70),
                                          height: Configs.calcheight(70),
                                        ),
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
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                      // initialUrl: 'https://www.youtube.com/embed/K1dmrYjeaL0',
                                      initialUrl: Configs
                                                  .con_doctor1.youtube_link
                                                  .toString()
                                                  .length ==
                                              0
                                          ? 'https://www.youtube.com/embed/P5fWpyYO5o8'
                                          : Configs.con_doctor1.youtube_link
                                              .toString(),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.all(Configs.calcheight(11)),
                                  width: double.infinity,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      right: Configs.calcheight(15)),
                                  child: Text(
                                    'طريقة الاستشارة',
                                    textDirection: ui.TextDirection.rtl,
                                    style: TextStyle(
                                        color: Color(0xff0E0E49),
                                        fontSize: Configs.calcheight(30)),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  margin: EdgeInsets.only(
                                      left: Configs.calcheight(15),
                                      right: Configs.calcheight(15)),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    '\$' +
                                                        Configs.con_doctor1
                                                            .remain_video
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          Configs.calcheight(
                                                              25),
                                                      color: Color(0xff0E0E49),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width:
                                                        Configs.calcwidth(30),
                                                    padding: EdgeInsets.all(
                                                        Configs.calcheight(7)),
                                                    child: FlatButton(
                                                      color: Colors.transparent,
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(Configs
                                                                    .calcheight(
                                                                        7)),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          video_up = !video_up;
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        !video_up
                                                            ? 'assets/images/ic_down1.png'
                                                            : 'assets/images/ic_up1.png',
                                                        width:
                                                            Configs.calcheight(
                                                                25),
                                                        height:
                                                            Configs.calcheight(
                                                                25),
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right:
                                                        Configs.calcheight(20)),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'محادثة فيديو',
                                                      style: TextStyle(
                                                        fontSize:
                                                            Configs.calcheight(
                                                                20),
                                                        color:
                                                            Color(0xff0E0E49),
                                                        fontFamily:
                                                            'IRANSansWeb',
                                                      ),
                                                      textDirection:
                                                          ui.TextDirection.rtl,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/ic_d_video.png',
                                                      width: Configs.calcheight(
                                                          50),
                                                      height:
                                                          Configs.calcheight(
                                                              50),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                      video_up
                                          ? Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              padding:
                                                  EdgeInsets.only(bottom: 25),
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        """ﺍﻟﺘﺤﺪﺙ ﻣﻊ ﺍﻟﻄﺒﻴﺐ ﻣﺒﺎﺷﺮﺓ ﻓﻴﺪﻳﻮ
ﺍﻣﻜﺎﻧﻴﺔ ﺍﺭﺳﺎﻝ ﻣﻠﻔﺎﺗﻚ ﺍﻟﻄﺒﻴﺔ ﻭﺻﻮﺭ ﻋﻦ ﺣﺎﻟﺘﻚ""",
                                                        style: TextStyle(
                                                            fontSize: Configs
                                                                .calcheight(20),
                                                            fontFamily:
                                                                'IRANSansWeb',
                                                            color: Color(
                                                                0xff0E0E49)),
                                                        textDirection: ui
                                                            .TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                      width: double.infinity,
                                                      margin: EdgeInsets.only(
                                                          top: Configs
                                                              .calcheight(15)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                Card(
                                  elevation: 3,
                                  margin: EdgeInsets.all(
                                    Configs.calcheight(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    '\$' +
                                                        Configs.con_doctor1
                                                            .remain_call
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          Configs.calcheight(
                                                              25),
                                                      color: Color(0xff0E0E49),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width:
                                                        Configs.calcwidth(30),
                                                    padding: EdgeInsets.all(
                                                        Configs.calcheight(7)),
                                                    child: FlatButton(
                                                      color: Colors.transparent,
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(Configs
                                                                    .calcheight(
                                                                        7)),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          voice_up = !voice_up;
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        !voice_up
                                                            ? 'assets/images/ic_down1.png'
                                                            : 'assets/images/ic_up1.png',
                                                        width:
                                                            Configs.calcheight(
                                                                25),
                                                        height:
                                                            Configs.calcheight(
                                                                25),
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right:
                                                        Configs.calcheight(20)),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'محادثة صوتية',
                                                      style: TextStyle(
                                                        fontSize:
                                                            Configs.calcheight(
                                                                20),
                                                        color:
                                                            Color(0xff0E0E49),
                                                        fontFamily:
                                                            'IRANSansWeb',
                                                      ),
                                                      textDirection:
                                                          ui.TextDirection.rtl,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/ic_d_voice.png',
                                                      width: Configs.calcheight(
                                                          50),
                                                      height:
                                                          Configs.calcheight(
                                                              50),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                      voice_up
                                          ? Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              padding:
                                                  EdgeInsets.only(bottom: 25),
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        """ﺍﻟﺘﺤﺪﺙ ﻣﻊ ﺍﻟﻄﺒﻴﺐ ﻣﺒﺎﺷﺮﺓ ﺑﺎﻟﺼﻮﺕ
ﺍﻣﻜﺎﻧﻴﺔ ﺍﺭﺳﺎﻝ ﻣﻠﻔﺎﺗﻚ ﺍﻟﻄﺒﻴﺔ ﻭﺻﻮﺭ ﻋﻦ ﺣﺎﻟﺘﻚ""",
                                                        style: TextStyle(
                                                          fontSize: Configs
                                                              .calcheight(20),
                                                          fontFamily:
                                                              'IRANSansWeb',
                                                          color:
                                                              Color(0xff0E0E49),
                                                        ),
                                                        textDirection: ui
                                                            .TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                      width: double.infinity,
                                                      margin: EdgeInsets.only(
                                                          top: Configs
                                                              .calcheight(15)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  margin: EdgeInsets.only(
                                      left: Configs.calcheight(15),
                                      right: Configs.calcheight(15)),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    '\$' +
                                                        Configs.con_doctor1
                                                            .remain_chat
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          Configs.calcheight(
                                                              25),
                                                      color: Color(0xff0E0E49),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width:
                                                        Configs.calcwidth(30),
                                                    padding: EdgeInsets.all(
                                                        Configs.calcheight(7)),
                                                    child: FlatButton(
                                                      color: Colors.transparent,
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(Configs
                                                                    .calcheight(
                                                                        7)),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          chat_up = !chat_up;
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        !chat_up
                                                            ? 'assets/images/ic_down1.png'
                                                            : 'assets/images/ic_up1.png',
                                                        width:
                                                            Configs.calcheight(
                                                                25),
                                                        height:
                                                            Configs.calcheight(
                                                                25),
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right:
                                                        Configs.calcheight(20)),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'محادثة نصية',
                                                      style: TextStyle(
                                                        fontSize:
                                                            Configs.calcheight(
                                                                20),
                                                        color:
                                                            Color(0xff0E0E49),
                                                        fontFamily:
                                                            'IRANSansWeb',
                                                      ),
                                                      textDirection:
                                                          ui.TextDirection.rtl,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/ic_d_chat.png',
                                                      width: Configs.calcheight(
                                                          50),
                                                      height:
                                                          Configs.calcheight(
                                                              50),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                      chat_up
                                          ? Container(
                                              color: Colors.white,
                                              padding:
                                                  EdgeInsets.only(bottom: 25),
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        """ﺍﻟﺘﺤﺪﺙ ﻣﻊ ﺍﻟﻄﺒﻴﺐ ﻣﺒﺎﺷﺮﺓ ﻛﺘﺎﺑﺔ
ﺍﻣﻜﺎﻧﻴﺔ ﺍﺭﺳﺎﻝ ﻣﻠﻔﺎﺗﻚ ﺍﻟﻄﺒﻴﺔ ﻭﺻﻮﺭ ﻋﻦ ﺣﺎﻟﺘﻚ""",
                                                        style: TextStyle(
                                                          fontSize: Configs
                                                              .calcheight(20),
                                                          color:
                                                              Color(0xff0E0E49),
                                                          fontFamily:
                                                              'IRANSansWeb',
                                                        ),
                                                        textDirection: ui
                                                            .TextDirection.rtl,
                                                      ),
                                                      width: double.infinity,
                                                      margin: EdgeInsets.only(
                                                          top: Configs
                                                              .calcheight(15)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.all(Configs.calcheight(15)),
                                  child: Text(
                                    'الاستشارة مضمونة',
                                    style: TextStyle(
                                        color: Color(0xff0E0E49),
                                        fontSize: Configs.calcheight(30)),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'متخصص موثّق',
                                                style: TextStyle(
                                                  fontSize:
                                                      Configs.calcheight(25),
                                                  color: Color(0xff0E0E49),
                                                  fontFamily: 'IRANSansWeb',
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: Configs.calcheight(15),
                                          ),
                                          Image.asset(
                                            'assets/images/ic_user.png',
                                            width: Configs.calcheight(50),
                                            height: Configs.calcheight(50),
                                          ),
                                        ],
                                      ),
                                    )),
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'ضمان الخصوصية ',
                                                    style: TextStyle(
                                                      fontSize:
                                                          Configs.calcheight(
                                                              25),
                                                      color: Color(0xff0E0E49),
                                                      fontFamily: 'IRANSansWeb',
                                                    ),
                                                    textDirection:
                                                        ui.TextDirection.rtl,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  Text(
                                                    '%100',
                                                    style: TextStyle(
                                                      fontSize:
                                                          Configs.calcheight(
                                                              25),
                                                      color: Color(0xff0E0E49),
                                                      fontFamily: 'IRANSansWeb',
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: Configs.calcheight(15),
                                          ),
                                          Image.asset(
                                            'assets/images/ic_checking.png',
                                            width: Configs.calcheight(50),
                                            height: Configs.calcheight(50),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Bottombar(1)
                ],
              ),
            ),
          ],
        ));
  }

  Future<bool> calculatemodel() async {
    List<consultantmodel> consultArr;
    List<consultantmodel> new_consultArr;

    consultArr = List();
    new_consultArr = List();

    String response = await _baseMainRepository.getconsultant();
    var result = jsonDecode(response);
    if (result['status'] == 'success') {
      Map<String, dynamic> decodedJSON = {};
      decodedJSON = jsonDecode(response) as Map<String, dynamic>;
      consultArr = decodedJSON['consultant'] != null
          ? List.from(decodedJSON['consultant'])
              .map((e) => consultantmodel.fromJSON(e))
              .toList()
          : [];
      for (int i = 0; i < consultArr.length; i++) {
        if (consultArr[i].status == 'now') {
          new_consultArr.add(consultArr[i]);
        }
      }
      for (int i = 0; i < new_consultArr.length; i++) {
        if (new_consultArr[i].doctorId == Configs.con_doctor1.id &&
            new_consultArr[i].patientId == Configs.umodel.id) {
          Configs.conmodel = new_consultArr[i];
          return true;
        }
      }
      // Configs.con.getConsultant();
    }
    return false;
  }

  Future<void> check_consultant() async {
    if (!Configs.auth_flag) {
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
    if (result['status'] == 'success') {
      Map<String, dynamic> decodedJSON = {};
      decodedJSON = jsonDecode(response) as Map<String, dynamic>;
      consultArr = decodedJSON['consultant'] != null
          ? List.from(decodedJSON['consultant'])
              .map((e) => consultantmodel.fromJSON(e))
              .toList()
          : [];
      for (int i = 0; i < consultArr.length; i++) {
        if (consultArr[i].status != 'now') {
          old_consultArr.add(consultArr[i]);
        } else {
          new_consultArr.add(consultArr[i]);
        }
      }
    }
    bool t_video = false, t_audio = false, t_chat = false;
    for (int i = 0; i < new_consultArr.length; i++) {
      if (new_consultArr[i].doctorId == Configs.con_doctor1.id &&
          new_consultArr[i].type == 'video') {
        t_video = true;
        break;
      }
      if (new_consultArr[i].doctorId == Configs.con_doctor1.id &&
          new_consultArr[i].type == 'voice') {
        t_audio = true;
        break;
      }
      if (new_consultArr[i].doctorId == Configs.con_doctor1.id &&
          new_consultArr[i].type == 'typing') {
        t_chat = true;
        break;
      }
    }
    if (!t_video && !t_audio && !t_chat) {
      setState(() {
        check_chat = true;
        check_video = true;
        check_voice = true;
      });
    }
    if (t_video) {
      setState(() {
        check_chat = false;
        check_video = true;
        check_voice = false;
      });
    }
    if (t_audio) {
      setState(() {
        check_chat = false;
        check_video = false;
        check_voice = true;
      });
    }
    if (t_chat) {
      setState(() {
        check_chat = true;
        check_video = false;
        check_voice = false;
      });
    }
  }

  Future<void> maaking_consultant(String ty) async {
    if (!Configs.auth_flag) {
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
      return;
    }
    String response = await _baseMainRepository.patient_startConsultant(
        Configs.con_doctor1.id,
        Configs.umodel.id,
        Configs.con_doctor1.menulist_id,
        ty);
    var result = jsonDecode(response);
    if (result['status'] == 'success') {
      newmodel = consultantmodel.fromJSON(result['consultant']);
      await sendwelcomemessage();
      if (ty == 'voice') {
        Configs.umodel.money =
            Configs.umodel.money - Configs.con_doctor1.remain_call;
        Configs.con.getConsultant();
        openvoicemodal();
      }
      if (ty == 'video') {
        Configs.umodel.money =
            Configs.umodel.money - Configs.con_doctor1.remain_video;
        Configs.con.getConsultant();
        openvideomodal();
      }
      if (ty == 'typing') {
        Configs.umodel.money =
            Configs.umodel.money - Configs.con_doctor1.remain_chat;
        Configs.con.getConsultant();
        openchatmodal();
      }
    } else if (result['status'] == 'noenough') {
      openpaymentmodal();
    } else {
      bool result = await calculatemodel();
      Configs.con_doctor = Configs.con_doctor1;
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatPage()));
    }
  }

  void openvoicemodal() {
    showDialog(
        barrierDismissible: true,
        context: modalcontext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(Configs.calcheight(9)))),
            child: Container(
                width: Configs.calcwidth(513),
                height: Configs.calcheight(462),
                padding: EdgeInsets.all(Configs.calcheight(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/ic_success.png',
                      width: Configs.calcheight(121),
                      height: Configs.calcheight(121),
                    ),
                    SizedBox(
                      height: Configs.calcheight(23),
                    ),
                    Image.asset(
                      'assets/images/ic_voice.png',
                      width: Configs.calcheight(40),
                      height: Configs.calcheight(40),
                    ),
                    SizedBox(
                      height: Configs.calcheight(10),
                    ),
                    Text(
                      'ﺗﻢ ﻃﻠﺐ ﺍﻷﺗﺼﺎﻝ ﺍﻟﺼﻮﺗﻲ ﻣﻊ ﺍﻟﻄﺒﻴﺐ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(25),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Configs.calcheight(10),
                          ),
                          Text(
                            Configs.con_doctor1.fname +
                                ' ' +
                                Configs.con_doctor1.lname,
                            style: TextStyle(
                                fontSize: Configs.calcheight(35),
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            ' .د',
                            style: TextStyle(
                                fontSize: Configs.calcheight(35),
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/images/ic_bright.png',
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
                )),
          );
        }).then((value) async {
      bool result = await calculatemodel();
      Configs.con_doctor = Configs.con_doctor1;
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatPage()));
    });
  }

  void openvideomodal() {
    showDialog(
        barrierDismissible: true,
        context: modalcontext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(Configs.calcheight(9)))),
            child: Container(
                width: Configs.calcwidth(513),
                height: Configs.calcheight(462),
                padding: EdgeInsets.all(Configs.calcheight(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/ic_success.png',
                      width: Configs.calcheight(121),
                      height: Configs.calcheight(121),
                    ),
                    SizedBox(
                      height: Configs.calcheight(23),
                    ),
                    Image.asset(
                      'assets/images/ic_video.png',
                      width: Configs.calcheight(40),
                      height: Configs.calcheight(40),
                    ),
                    SizedBox(
                      height: Configs.calcheight(10),
                    ),
                    Text(
                      'ﺗﻢ ﻃﻠﺐ ﺍتصال فيديو ﻣﻊ ﺍﻟﻄﺒﻴﺐ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(25),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Configs.calcheight(10),
                          ),
                          Text(
                            Configs.con_doctor1.fname +
                                ' ' +
                                Configs.con_doctor1.lname,
                            style: TextStyle(
                                fontSize: Configs.calcheight(35),
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            ' .د',
                            style: TextStyle(
                                fontSize: Configs.calcheight(35),
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/images/ic_bright.png',
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
                )),
          );
        }).then((value) async {
      bool result = await calculatemodel();
      Configs.con_doctor = Configs.con_doctor1;
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatPage()));
    });
  }

  void openchatmodal() {
    showDialog(
        barrierDismissible: true,
        context: modalcontext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(Configs.calcheight(38)))),
            child: Container(
                width: Configs.calcwidth(460),
                height: Configs.calcheight(392),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Configs.calcheight(38))),
                ),
                padding: EdgeInsets.all(Configs.calcheight(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/ic_success.png',
                      width: Configs.calcheight(171),
                      height: Configs.calcheight(171),
                    ),
                    SizedBox(
                      height: Configs.calcheight(20),
                    ),
                    Text(
                      'ﺗﻢ بدأ ﺍﻻﺳﺘﺸﺎﺭﺓ النصية ﺑﻨﺠﺎﺡ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(25),
                      ),
                    ),
                  ],
                )),
          );
        }).then((value) async {
      bool result = await calculatemodel();
      Configs.con_doctor = Configs.con_doctor1;
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatPage()));
    });
  }

  void openpaymentmodal() {
    showDialog(
        barrierDismissible: true,
        context: modalcontext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(Configs.calcheight(9)))),
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
                              fontSize: Configs.calcheight(30)),
                        ),
                        SizedBox(
                          width: Configs.calcheight(10),
                        ),
                        Image.asset(
                          'assets/images/ic_warning1.png',
                          width: Configs.calcheight(55),
                          height: Configs.calcheight(55),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Configs.calcheight(20),
                    ),
                    Text(
                      'ﻳﺮﺟﻰ ﺍﺿﺎﻓﺔ ﺭﺻﻴﺪ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Configs.calcheight(30)),
                    ),
                    Container(
                      width: Configs.calcwidth(272),
                      height: Configs.calcheight(72),
                      margin: EdgeInsets.only(top: Configs.calcheight(23)),
                      child: FlatButton(
                          color: primaryColor,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Configs.calcheight(8)),
                          ),
                          onPressed: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/consultant'));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Addpayment()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ﺍﺿﺎﻓﺔ ﺭﺻﻴﺪ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Configs.calcheight(30)),
                              ),
                              SizedBox(
                                width: Configs.calcheight(26),
                              ),
                              Image.asset(
                                'assets/images/ic_add.png',
                                width: Configs.calcheight(47),
                                height: Configs.calcheight(47),
                              ),
                            ],
                          )),
                    ),
                  ],
                )),
          );
        });
  }

  Future<void> sendwelcomemessage() async {
    chatReference = db
        .collection("chats")
        .document(newmodel.id.toString())
        .collection('messages');
    String txt1 = ' ﺃﻧﺎ ﺍﻟﻄﺒﻴﺐ ' +
        (Configs.con_doctor1.fname + ' ' + Configs.con_doctor1.lname) +
        '\n' +
        (' ﻣﺘﺨﺼﺺ ﻓﻲ ' + Configs.con_doctor1.text.toString());
    String txt2 = "ﻫﻨﺎ ﺗﺴﺘﻄﻴﻊ ﺍﻟﺘﺤﺪﺙ ﻣﻌﻲ ﻣﺒﺎﺷﺮﺓ ﻭﻃﺮﺡ ﺍﺳﺄﻟﺘﻚ";
    String txt3 =
        "ﻳﻤﻜﻨﻚ ﺍﺭﺳﺎﻝ ﺳﺆﺍﻟﻚ ﺍﻵﻥ ﻭﺗﻔﺎﺻﻴﻞ ﺣﺎﻟﺘﻚ ﻛﻤﺎ ﻳﻤﻜﻨﻚ ﺍﺭﺳﺎﻝ ﺍﻟﻤﻠﻔﺎﺕ ﺍﻭ ﺻﻮﺭﺓ عن حالتك";
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
      'text': txt3,
      'sender_id': newmodel.patientId.toString(),
      'receiver_id': newmodel.doctorId.toString(),
      'isRead': true,
      'image_url': '',
      'time': FieldValue.serverTimestamp(),
    });
  }
}
