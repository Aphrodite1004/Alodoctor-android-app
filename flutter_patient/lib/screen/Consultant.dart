import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_patient/component/Bottombar.dart';
import 'package:flutter_patient/component/CurrentConsultant.dart';
import 'package:flutter_patient/component/Doctorlistpage.dart';
import 'package:flutter_patient/component/MainHeader.dart';
import 'package:flutter_patient/component/NavDrawer.dart';
import 'package:flutter_patient/component/OldConsultant.dart';
import 'package:flutter_patient/component/menulistpage.dart';
import 'package:flutter_patient/controllers/consultantcontroller.dart';
import 'package:flutter_patient/models/consultantmodel.dart';
import 'package:flutter_patient/models/doctor.dart';
import 'package:flutter_patient/screen/ChatPage.dart';
import 'package:flutter_patient/screen/VideoPage.dart';
import 'package:flutter_patient/screen/VoicePage.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:permission_handler/permission_handler.dart';

class Consultant extends StatefulWidget {
  @override
  ConsultantState createState() => ConsultantState();
}

class ConsultantState extends StateMVC<Consultant> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  TabController _controller;
  int _currentIndex = 0;

  consultantcontroller _con;


  ConsultantState() : super(consultantcontroller()){
    _con = controller;
    Configs.con = _con;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 4);
    _controller.addListener(_handleTabSelection);
    _controller.animateTo(3);

    Configs.tabController1 = _controller;

    if(Configs.auth_flag){
      _initLocalNotifications();
      configurePushNotification();
    } 
  }
  _initLocalNotifications() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  _handleTabSelection() {
    setState(() {
      _currentIndex = _controller.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Configs.con_context = context;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: NavDrawer(scaffoldKey),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MainHeader('ﺍﺧﺘﺮ ﻃﺒﻴﺒﻚ ﻭﺍﺳﺘﺸﺮ', scaffoldKey),
                Container(
                    height: MediaQuery.of(context).size.height -
                        Configs.calcheight(220),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child:  TabBar(
                              isScrollable: true,
                              controller: _controller,
                              unselectedLabelColor:
                              Colors.black.withOpacity(0.3),
                              indicatorColor: Colors.white,
                              labelPadding: EdgeInsets.only(left: 4, right: 4),
                              tabs: [
                                Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                                      color: _currentIndex == 0 ? Color(0xff0D5FC1): Colors.white,
                                      border: Border.all(
                                          color: Color(0xff0D5FC1)
                                      ),
                                    ),
                                    width: Configs.calcwidth(265),
                                    height: Configs.calcheight(72),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ﺍﺳﺘﺸﺎﺭﺍﺗﻲ ﺍﻟﺴﺎﺑﻘﺔ',
                                      style: TextStyle(
                                          fontSize: Configs.calcheight(25),
                                          color: _currentIndex == 0 ? Colors.white:Color(0xff0D5FC1)
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                                      color:  _currentIndex == 1 ? Color(0xff0D5FC1): Colors.white,
                                      border: Border.all(
                                          color: Color(0xff0D5FC1)
                                      ),
                                    ),
                                    width: Configs.calcwidth(180),
                                    height: Configs.calcheight(72),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ﺍﻻﻗﺴﺎﻡ',
                                      style: TextStyle(
                                          fontSize: Configs.calcheight(25),
                                          color: _currentIndex == 1 ? Colors.white:Color(0xff0D5FC1)
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                                        color: _currentIndex == 2 ?Color(0xff0D5FC1): Colors.white,
                                        border: Border.all(
                                            color: Color(0xff0D5FC1)
                                        ),
                                      ),
                                      width: Configs.calcwidth(250),
                                      height: Configs.calcheight(72),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'استشاراتي الحالية',
                                            style: TextStyle(
                                                fontSize: Configs.calcheight(25),
                                                color: _currentIndex == 2 ?  Colors.white:Color(0xff0D5FC1)
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset( _currentIndex == 2 ? 'assets/images/ic_chatting_2.png' :  'assets/images/ic_chatting_1.png',
                                            width: Configs.calcheight(35),
                                            height: Configs.calcheight(35),)
                                        ],
                                      )
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                                        color:  _currentIndex == 3 ? Color(0xff0D5FC1): Colors.white,
                                        border: Border.all(
                                            color: Color(0xff0D5FC1)
                                        ),
                                      ),
                                      width: Configs.calcwidth(200),
                                      height: Configs.calcheight(72),
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: (){
                                          Configs.menu_flag = false;
                                          _controller.animateTo(3);
                                          setState(() { });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'ﺍﺧﺘﺮ ﺍﻟﻄﺒﻴﺐ',
                                              style: TextStyle(
                                                  fontSize: Configs.calcheight(25),
                                                  color:  _currentIndex == 3 ? Colors.white:Color(0xff0D5FC1)
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset( _currentIndex == 3 ? 'assets/images/ic_consult_2.png' : 'assets/images/ic_consult_1.png',
                                              width: Configs.calcheight(35),
                                              height: Configs.calcheight(35),)
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _controller,
                              children: <Widget>[
                                OldConsultant(_con),
                                Menulistpage(),
                                CurrentConsultant(_con),
                                Doctorlistpage()
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                _currentIndex == 2 ? Bottombar(0) : Bottombar(1)
              ],
            ),
          )
        ),
      ),
    );
  }
  void configurePushNotification() {
    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print('===============onLaunch$message');
      },
      onMessage: (Map<String, dynamic> message) async {
        _showNotification(message);
      },
      onBackgroundMessage:
      myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('onResume$message');
      },
    );
  }
  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    _showNotification(message);
    print('AppPushs myBackgroundMessageHandler : $message');
    return Future<void>.value();
  }
  static Future _showNotification(Map<String, dynamic> message) async {
    print('_shownotification');
    print(message.toString());
    var pushTitle;
    var pushText;
    var action;
    var messages;

    if (Platform.isAndroid) {
      var nodeData = message['data'];
      pushTitle = nodeData['title'];
      pushText = nodeData['msgBody'];
      action = nodeData['action'];
      messages = nodeData['message'];
    } else {
      pushTitle = message['title'];
      pushText = message['msgBody'];
      action = message['action'];
      messages = message['message'];
    }
    if(pushText == 'update'){
      // var result = jsonDecode(action);
      // consultant_model t_model = consultant_model.fromJSON(result);
      Configs.con.getConsultant();
      Navigator.popUntil(Configs.con_context, ModalRoute.withName('/consultant'));

    } else {
      if(messages == 'typing'){
        // @formatter:off
        var platformChannelSpecificsAndroid = new AndroidNotificationDetails(
            'Patient chat',
            'Patient chat channel',
            'Message from doctor',
            playSound: true,
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high);
        // @formatter:on
        var platformChannelSpecificsIos = new IOSNotificationDetails(presentSound: false);
        var platformChannelSpecifics = new NotificationDetails(android: platformChannelSpecificsAndroid, iOS: platformChannelSpecificsIos);

        new Future.delayed(Duration.zero, () {
          _flutterLocalNotificationsPlugin.show(
            0,
            pushTitle,
            pushText,
            platformChannelSpecifics,
            payload: action,
          );
        });
      }
      if(messages == 'voice' || messages == 'video'){

        pushText = messages + ' calling';
        // @formatter:off
        var platformChannelSpecificsAndroid = new AndroidNotificationDetails(
            'Patient call',
            'Patient call channel',
            'Calling from doctor',
            enableVibration: true,
            sound: RawResourceAndroidNotificationSound('audio'),
            importance: Importance.max,
            priority: Priority.high);
        // @formatter:on
        var platformChannelSpecificsIos = new IOSNotificationDetails(presentSound: false);
        var platformChannelSpecifics = new NotificationDetails(android: platformChannelSpecificsAndroid, iOS: platformChannelSpecificsIos);

        new Future.delayed(Duration.zero, () {
          _flutterLocalNotificationsPlugin.show(
            0,
            pushTitle,
            pushText,
            platformChannelSpecifics,
            payload: action,
          );
        });
        showcalldialog(action);
      }
    }


  }
  Future onSelectNotification(String payload) {

    print('payloads');
    print(payload);
    var results = jsonDecode(payload);
    Configs.conmodel = consultantmodel.fromJSON(results);
    print(Configs.conmodel.id);
    Navigator.popUntil(context, ModalRoute.withName('/consultant'));
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ChatPage()
    ));

  }
  static Future<void> showcalldialog(action) async {

    var results = jsonDecode(action);
    Configs.callmodel = consultantmodel.fromJSON(results);
    await PermissionHandler().requestPermissions(Configs.callmodel.type == "video"
        ? [PermissionGroup.camera, PermissionGroup.microphone]
        : [PermissionGroup.microphone]);
    showDialog(
        barrierDismissible: true,
        context: Configs.con_context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(38)))),
            child: Container(
                width: Configs.calcwidth(460),
                height: Configs.calcheight(330),
                padding: EdgeInsets.all(Configs.calcheight(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Configs.calcheight(37),
                    ),
                    Text('ﻣﻜﺎﻟﻤﺔ ﻭﺍﺭﺩﺓ ﻣﻦ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(34),
                      ),),
                    SizedBox(
                      height: Configs.calcheight(37),
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [ Text(Configs.callmodel.fname + ' ' + Configs.callmodel.lname,
                       style: TextStyle(
                         color: Colors.black,
                         fontSize: Configs.calcheight(34),
                       ),),
                       SizedBox(
                         width: 5,
                       ),
                       Text( ' .د',
                         style: TextStyle(
                             fontSize: Configs.calcheight(35),
                             color: Colors.black
                         ),),],
                   ),
                    Container(
                      width: Configs.calcwidth(398),
                      margin: EdgeInsets.only(top: Configs.calcheight(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Configs.calcwidth(187),
                            height: Configs.calcheight(65),

                            child: FlatButton(
                              color: Color(0xffff005c),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Configs.calcheight(50)),
                              ),
                              onPressed: () async {
                                await Firestore.instance.collection("calls").document(Configs.callmodel.id.toString())
                                    .updateData(
                                    {'response': 'Decline'});
                                await Firestore.instance.collection("calls").document(Configs.callmodel.id.toString())
                                    .updateData({'calling': false});
                                Navigator.pop(context);
                              },
                              child: Text(
                                'ﺭﻓﺾ',
                                style: TextStyle(
                                  fontSize: Configs.calcheight(30),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: Configs.calcwidth(187),
                            height: Configs.calcheight(65),

                            child: FlatButton(
                              color: Color(0xff30BB68),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Configs.calcheight(50)),
                              ),
                              onPressed: () async {
                                await Firestore.instance.collection("calls").document(Configs.callmodel.id.toString())
                                    .updateData(
                                    {'response': "Pickup"});
                                Navigator.pop(context);
                                if(Configs.callmodel.type == 'video'){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>VideoPage(
                                          channelName: Configs.callmodel.id.toString(),
                                          role: ClientRole.Broadcaster,
                                          callType: 'VideoCall')
                                  ));
                                } else {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>VoicePage(
                                          channelName: Configs.callmodel.id.toString(),
                                          role: ClientRole.Broadcaster,
                                          callType: 'VoiceCall')
                                  ));
                                }
                              },
                              child: Text(
                                'ﻗﺒﻮﻝ',
                                style: TextStyle(
                                  fontSize: Configs.calcheight(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          );
        }).then((value) async {
      await _flutterLocalNotificationsPlugin.cancelAll();
    });
  }
}
