import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/component/Menudetail.dart';
import 'package:flutter_patient/screen/largeImage.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/api_endpoints.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart' as intl;

class OldChatcomponent extends StatefulWidget {

  OldChatcomponent();

  @override
  OldChatcomponentState createState() => OldChatcomponentState();
}

class OldChatcomponentState extends State<OldChatcomponent> {

  final db = Firestore.instance;
  CollectionReference chatReference;

  String category = '';

  BaseMainRepository _baseMainRepository;
  final dateformat = new intl.DateFormat('hh:mm   dd/MM/yyyy');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _baseMainRepository = BaseMainRepository();
    for (int i = 0; i < Configs.umodel.menus.length; i++) {
      if (Configs.umodel.menus[i].id ==
          Configs.con_doctor.menulist_id) {
        setState(() {
          category = Configs.umodel.menus[i].text;
        });
      }
    }
    print(Configs.conmodel.id.toString());
    chatReference =
        db.collection("chats")
            .document(Configs.conmodel.id.toString())
            .collection('messages');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: !Configs.menu_flag ?Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  height: Configs.calcheight(105),
                  width: double.infinity,
                  padding: EdgeInsets.only(right: Configs.calcheight(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "الطبيب " +
                                    Configs.con_doctor
                                        .fname + ' ' + Configs.con_doctor.lname,
                                style: TextStyle(
                                    color: Black02,
                                    fontSize: Configs.calcheight(26)
                                ),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset('assets/images/ic_bright.png',
                                width: Configs.calcheight(25),
                                height: Configs.calcheight(25),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Configs.calcheight(25) + 4),
                            child: Text(
                              category,
                              style: TextStyle(
                                  fontSize: Configs.calcheight(26),
                                  color: Black02
                              ),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: Configs.calcheight(20),
                      ),
                      Stack(
                        children: [
                          Container(
                            child: Material(
                              child: Container(
                                width: Configs.calcheight(79),
                                height: Configs.calcheight(79),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(
                                        APIEndPoints
                                            .mediaurl +
                                            Configs.con_doctor
                                                .photo,
                                      )),
                                  border: Border.all(
                                      color: Green01,
                                      width: Configs.calcheight(1)

                                  ),
                                )
                                ,
                              ),
                              elevation: 10,
                              shape: CircleBorder(),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,),
                              width: Configs.calcheight(15),
                              height: Configs.calcheight(15),
                              child: Icon(
                                Icons.brightness_1,
                                color: Configs.con_doctor.active_state == 1
                                    ? Green01
                                    : Gray04,
                                size: Configs.calcheight(15),
                              ),
                            ),
                            left: Configs.calcwidth(4),
                          )
                        ],
                      )
                    ],),
                ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - Configs.calcheight(480),
                  width: double.infinity,
                  color: Color(0xffe8eff5),
                  child:  StreamBuilder<QuerySnapshot>(
                    stream: chatReference
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(primaryColor),
                            strokeWidth: 2,
                          ),
                        );
                      return ListView(
                        reverse: true,
                        children: generateMessages(snapshot),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ) : Menudetail(),
    );
  }

  generateMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map<Widget>((doc) => Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: doc.data['sender_id'] != Configs.conmodel.patientId.toString()
              ? generateReceiverLayout(
            doc,
          )
              : generateSenderLayout(doc)),
    ))
        .toList();
  }
  List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
    if (!documentSnapshot.data['isRead']) {
      chatReference.document(documentSnapshot.documentID).updateData({
        'isRead': true,
      });

      return _messagesIsRead(documentSnapshot);
    }
    return _messagesIsRead(documentSnapshot);

  }
  _messagesIsRead(documentSnapshot) {
    final ThemeData _theme = Theme.of(context);
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: documentSnapshot.data['image_url'] != ''
                  ? InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Center(
                          child: CupertinoActivityIndicator(
                            radius: 10,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        height: MediaQuery.of(context).size.height * .65,
                        width: MediaQuery.of(context).size.width * .9,
                        imageUrl: documentSnapshot.data['image_url'],
                        fit: BoxFit.fitWidth,
                      ),
                      height: 150,
                      width: 150.0,
                      color: Colors.white,
                      padding: EdgeInsets.all(5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        documentSnapshot.data["time"] != null
                            ? dateformat.format(documentSnapshot.data["time"].toDate())
                            : "",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Black04,
                          fontSize: 12.0,
                        ),),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => LargeImage(
                      documentSnapshot.data['image_url'],
                    ),
                  ));
                },
              )
                  : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.only( left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Text(
                              documentSnapshot.data['text'],
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Blue10,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                documentSnapshot.data["time"] != null
                                    ? dateformat.format(documentSnapshot.data["time"].toDate())
                                    : "",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Black04,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ];
  }
  List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
    final ThemeData _theme = Theme.of(context);
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: documentSnapshot.data['type'] == 'Welcome'? Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Text(
                              documentSnapshot.data['text'],
                              style: TextStyle(
                                color: Green0,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                documentSnapshot.data["time"] != null
                                    ? dateformat.format(documentSnapshot.data["time"].toDate())
                                    : "",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Black04,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )) : documentSnapshot.data['image_url'] != ''
                  ? InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Center(
                          child: CupertinoActivityIndicator(
                            radius: 10,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        height: MediaQuery.of(context).size.height * .65,
                        width: MediaQuery.of(context).size.width * .9,
                        imageUrl: documentSnapshot.data['image_url'],
                        fit: BoxFit.fitWidth,
                      ),
                      height: 150,
                      width: 150.0,
                      color: Colors.white,
                      padding: EdgeInsets.all(5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        documentSnapshot.data["time"] != null
                            ? dateformat.format(documentSnapshot.data["time"].toDate())
                            : "",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Black04,
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => LargeImage(
                      documentSnapshot.data['image_url'],
                    ),
                  ));
                },
              )
                  : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Text(
                              documentSnapshot.data['text'],
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Blue10,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                documentSnapshot.data["time"] != null
                                    ? dateformat.format(documentSnapshot.data["time"].toDate())
                                    : "",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Black04,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ];
  }

}
