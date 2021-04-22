import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/models/consultantmodel.dart';
import 'package:flutter_patient/screen/VideoPage.dart';
import 'package:flutter_patient/screen/VoicePage.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:permission_handler/permission_handler.dart';

class consultantcontroller extends ControllerMVC {

  BaseMainRepository _baseMainRepository;

  List<consultantmodel> consultArr;
  List<consultantmodel> new_consultArr;
  List<consultantmodel> old_consultArr;
  List<int> unread_num;

  final db = Firestore.instance;
  CollectionReference chatReference;

  consultantcontroller() {
    _baseMainRepository = BaseMainRepository();

    getConsultant().then((value) {
      getcalling();
    });
  }

  Future<void> getConsultant() async {
    consultArr = List();
    new_consultArr = List();
    old_consultArr = List();
    unread_num = List();

    String response = await _baseMainRepository.getconsultant();
    var result = jsonDecode(response);
    if (result['status'] == 'success') {
      Map<String, dynamic> decodedJSON = {};
      decodedJSON = jsonDecode(response) as Map<String, dynamic>;
      consultArr =
      decodedJSON['consultant'] != null ? List.from(decodedJSON['consultant'])
          .map((e) => consultantmodel.fromJSON(e))
          .toList() : [];
      for (int i = 0; i < consultArr.length; i++) {
        if (consultArr[i].status != 'now') {
          old_consultArr.add(consultArr[i]);
        } else {
          new_consultArr.add(consultArr[i]);
          unread_num.add(0);
        }
      }
      setState(() {});
      for (int i = 0; i < new_consultArr.length; i++) {
        chatReference =
            db.collection("chats")
                .document(new_consultArr[i].id.toString())
                .collection('messages');
        chatReference.snapshots().listen((querySnapshot) {
          int count = 0;
          querySnapshot.documents.forEach((element) {
            if (element['receiver_id'] ==
                new_consultArr[i].patientId.toString() && !element['isRead']) {
              count++;
            }
          });
          unread_num[i] = count;
          setState(() {});
        });
      }
    }
  }

  void getcalling() {
    print('getcalling');
    print(new_consultArr.length);
    for (int i = 0; i < new_consultArr.length; i++) {
      if (new_consultArr[i].type == 'video' ||
          new_consultArr[i].type == 'voice') {
        CollectionReference callRef = Firestore.instance.collection("calls");
        callRef.where("channel_id", isEqualTo: "${new_consultArr[i].id.toString()}").getDocuments().then((value) async {
          if(value.documents.length > 0){
            print(value.documents[0]['response']);
            if(value.documents[0]['response'] == 'Awaiting'){
              print(value.documents[0]['response']);
              Configs.callmodel = new_consultArr[i];
              await PermissionHandler().requestPermissions(Configs.callmodel.type == "video"
                  ? [PermissionGroup.camera, PermissionGroup.microphone]
                  : [PermissionGroup.microphone]);
              showDialog(
                  barrierDismissible: true,
                  context: this.context,
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
                              Text(Configs.callmodel.fname + ' ' + Configs.callmodel.lname,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Configs.calcheight(34),
                                ),),
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
                  });
            }
          }
        });
      }
    }
  }
}