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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart' as intl;

class Chatcomponent extends StatefulWidget {
  Chatcomponent();

  @override
  ChatcomponentState createState() => ChatcomponentState();
}

class ChatcomponentState extends State<Chatcomponent> {
  TextEditingController messagecontroller = TextEditingController();
  final db = Firestore.instance;
  CollectionReference chatReference;

  String category = '';

  BaseMainRepository _baseMainRepository;

  TextEditingController feedbackcontroller = TextEditingController();
  int ratings = 0;

  final dateformat = new intl.DateFormat('hh:mm   dd/MM/yyyy');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _baseMainRepository = BaseMainRepository();
    for (int i = 0; i < Configs.umodel.doctors.length; i++) {
      if (Configs.umodel.doctors[i].id == Configs.conmodel.doctorId) {
        Configs.con_doctor = Configs.umodel.doctors[i];
      }
    }
    for (int i = 0; i < Configs.umodel.menus.length; i++) {
      if (Configs.umodel.menus[i].id == Configs.con_doctor.menulist_id) {
        setState(() {
          category = Configs.umodel.menus[i].text;
        });
      }
    }
    print(Configs.conmodel.id.toString());
    chatReference = db
        .collection("chats")
        .document(Configs.conmodel.id.toString())
        .collection('messages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: !Configs.menu_flag
            ? Stack(
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
                                    Configs.con_doctor.fname +
                                    ' ' +
                                    Configs.con_doctor.lname,
                                style: TextStyle(
                                    color: Black02,
                                    fontSize: Configs.calcheight(26)),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                'assets/images/ic_bright.png',
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
                                  color: Black02),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
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
                                        APIEndPoints.mediaurl +
                                            Configs.con_doctor.photo,
                                      )),
                                  border: Border.all(
                                      color: Green01,
                                      width: Configs.calcheight(1)),
                                ),
                              ),
                              elevation: 10,
                              shape: CircleBorder(),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
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
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height -
                      Configs.calcheight(630),
                  width: double.infinity,
                  color: Color(0xffe8eff5),
                  child: StreamBuilder<QuerySnapshot>(
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
                            valueColor:
                            AlwaysStoppedAnimation(primaryColor),
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
                Container(
                  width: double.infinity,
                  height: Configs.calcheight(188),
                  child: Column(
                    children: [
                      Container(
                        height: Configs.calcheight(110),
                      ),
                      Container(
                        width: Configs.calcwidth(243),
                        height: Configs.calcheight(71),
                        margin:
                        EdgeInsets.only(bottom: Configs.calcheight(7)),
                        child: FlatButton(
                          color: Colors.yellow,
                          textColor: Black03,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Configs.calcheight(71 / 2)),
                          ),
                          onPressed: () {
                            endchat();
                          },
                          child: Text(
                            'ﺍﻧﻬﺎﺀ ﺍﻻﺳﺘﺸﺎﺭﺓ',
                            style: TextStyle(
                              fontSize: Configs.calcheight(30),
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height -
                  Configs.calcheight(515),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: Configs.calcheight(90),
                padding: EdgeInsets.only(
                    left: Configs.calcheight(12),
                    right: Configs.calcheight(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Configs.calcwidth(490),
                      height: Configs.calcheight(98),
                      padding: EdgeInsets.only(
                          left: Configs.calcheight(12),
                          right: Configs.calcheight(12)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Configs.calcheight(36))),
                          color: Colors.white,
                          border: Border.all(
                              color: Black04,
                              width: Configs.calcheight(2))),
                      child: Row(
                        children: [
                          Container(
                            width: Configs.calcheight(72),
                            height: Configs.calcheight(72),
                            child: FlatButton(
                              color: Blue10,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Configs.calcheight(36)),
                              ),
                              onPressed: () {
                                sendText();
                              },
                              child: Image.asset(
                                'assets/images/ic_send.png',
                                width: Configs.calcheight(42),
                                height: Configs.calcheight(42),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: messagecontroller,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: 'ﺍﻛﺘﺐ ﺍﺳﺘﺠﺎﺑﺘﻚ',
                                    border: InputBorder.none),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: Configs.calcheight(72),
                      height: Configs.calcheight(72),
                      child: FlatButton(
                        color: Blue10,
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(Configs.calcheight(36)),
                        ),
                        onPressed: () async {
                          File image;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text('Upload a clear picture'),
                                  content: Container(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        new FlatButton(
                                          child: new Text('Take Photo...'),
                                          onPressed: () async {
                                            File image =
                                            await ImagePicker.pickImage(
                                                source:
                                                ImageSource.camera);
                                            if (image != null)
                                              _sendImage(image);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                            child: new Text(
                                                'Choose from Library'),
                                            onPressed: () async {
                                              File image = await ImagePicker
                                                  .pickImage(
                                                  source: ImageSource
                                                      .gallery);
                                              if (image != null)
                                                _sendImage(image);
                                              Navigator.of(context).pop();
                                            }),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("CANCEL"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        child: Image.asset(
                          'assets/images/ic_camera.png',
                          width: Configs.calcheight(42),
                          height: Configs.calcheight(42),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
            : Menudetail(),
      ),
    );
  }

  Future<void> sendText() async {
    if (messagecontroller.text.trim().length != 0) {
      String text = messagecontroller.text.trim();
      setState(() {
        messagecontroller.text = '';
      });
      String response =
          await _baseMainRepository.sendnotification('typing', text);
      var result = jsonDecode(response);
      print('hello');
      print(result.toString());
      if (result['status'] != 'failed') {
        chatReference
            .add({
              'type': 'Msg',
              'text': text,
              'sender_id': Configs.conmodel.patientId.toString(),
              'receiver_id': Configs.conmodel.doctorId.toString(),
              'isRead': false,
              'image_url': '',
              'time': FieldValue.serverTimestamp(),
            })
            .then((documentReference) {})
            .catchError((e) {});
      } else {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Configs.calcheight(38)))),
                child: Container(
                    width: Configs.calcwidth(460),
                    height: Configs.calcheight(392),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Configs.calcheight(38))),
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
                          'ﺗﻢ ﺍﺳﺘﻼﻡ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Configs.calcheight(25),
                          ),
                        ),
                        Text(
                          'ﺷﻜﺮﺍ ﻟﺘﻘﻴﻴﻤﻚ ﺍﻻﺳﺘﺸﺎﺭﺓ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Configs.calcheight(25),
                          ),
                        ),
                      ],
                    )),
              );
            }).then((value) async {
          Navigator.popUntil(context, ModalRoute.withName('/consultant'));
        });
      }
    }
  }

  Future<void> _sendImage(File image) async {
    String response =
        await _baseMainRepository.sendnotification('photo', 'Image');
    var result = jsonDecode(response);

    if (result['status'] != 'failed') {
      int timestamp = new DateTime.now().millisecondsSinceEpoch;
      StorageReference storageReference = FirebaseStorage.instance.ref().child(
          'chats/${Configs.conmodel.id}/img_' + timestamp.toString() + '.jpg');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      String fileUrl = await storageReference.getDownloadURL();
      chatReference.add({
        'type': 'Image',
        'text': 'Photo',
        'sender_id': Configs.conmodel.patientId.toString(),
        'receiver_id': Configs.conmodel.doctorId.toString(),
        'isRead': false,
        'image_url': fileUrl,
        'time': FieldValue.serverTimestamp(),
      });
    } else {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Configs.calcheight(38)))),
              child: Container(
                  width: Configs.calcwidth(460),
                  height: Configs.calcheight(392),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Configs.calcheight(38))),
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
                        'ﺗﻢ ﺍﺳﺘﻼﻡ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Configs.calcheight(25),
                        ),
                      ),
                      Text(
                        'ﺷﻜﺮﺍ ﻟﺘﻘﻴﻴﻤﻚ ﺍﻻﺳﺘﺸﺎﺭﺓ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Configs.calcheight(25),
                        ),
                      ),
                    ],
                  )),
            );
          }).then((value) async {
        Navigator.popUntil(context, ModalRoute.withName('/consultant'));
      });
    }
  }

  generateMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map<Widget>((doc) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: doc.data['sender_id'] !=
                          Configs.conmodel.patientId.toString()
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
                        style: TextStyle(
                          color: Black04,
                          fontSize: 12.0,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
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
                              style: TextStyle(
                                color: Blue10,
                                fontSize: 20.0,
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
                  margin: EdgeInsets.only(left: 10, right: 10),
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
                  )) :documentSnapshot.data['image_url'] != ''
                  ? InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Stack(
                              children: <Widget>[
                                CachedNetworkImage(
                                  placeholder: (context, url) => Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 10,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  height:
                                      MediaQuery.of(context).size.height * .65,
                                  width: MediaQuery.of(context).size.width * .9,
                                  imageUrl: documentSnapshot.data['image_url'],
                                  fit: BoxFit.fitWidth,
                                ),
                              ],
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
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => LargeImage(
                              documentSnapshot.data['image_url'],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(left: 20.0, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
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
                          Text(
                            documentSnapshot.data["time"] != null
                                ?dateformat.format(documentSnapshot.data["time"].toDate())
                                : "",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Black04,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      )),
            ),
          ],
        ),
      ),
    ];
  }

  void endchat() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(Configs.calcheight(10)))),
            child: Container(
                width: Configs.calcwidth(460),
                height: Configs.calcheight(184),
                padding: EdgeInsets.all(Configs.calcheight(10)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'ﺘﺄﻛﻴﺪ ﺍﻧﻬﺎﺀ ﺍﻻﺳﺘﺸﺎﺭﺓ',
                        style: TextStyle(fontSize: 15),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Configs.calcwidth(187),
                          height: Configs.calcheight(70),
                          margin: EdgeInsets.only(
                              bottom: Configs.calcheight(7), right: 5),
                          child: FlatButton(
                            color: Color(0xff1861CE),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Configs.calcheight(50)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'ﺍﻟﻐﺎﺀﺍﻻﻣﺮ',
                              style: TextStyle(
                                fontSize: Configs.calcheight(30),
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        Container(
                          width: Configs.calcwidth(187),
                          height: Configs.calcheight(70),
                          margin: EdgeInsets.only(
                              bottom: Configs.calcheight(7), left: 5),
                          child: FlatButton(
                            color: Color(0xffF44336),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Configs.calcheight(50)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              openmodal3();
                            },
                            child: Text(
                              'ﺍﻧﻬﺎﺀﺍﻻﺳﺘﺸﺎﺭﺓ',
                              style: TextStyle(
                                fontSize: Configs.calcheight(30),
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
  }

  void openmodal3() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: MediaQuery.of(context).padding,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(Configs.calcheight(38)))),
            child: Container(
                width: Configs.calcwidth(513),
                height: Configs.calcheight(700),
                padding: EdgeInsets.only(top:Configs.calcheight(10), left: Configs.calcheight(10), right: Configs.calcheight(10)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/ic_success.png',
                        width: Configs.calcheight(130),
                        height: Configs.calcheight(130),
                      ),
                      SizedBox(
                        height: Configs.calcheight(23),
                      ),
                      Text(
                        'تم ﺍﻧﻬﺎﺀ ﺍﻻﺳﺘﺸﺎﺭﺓ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Configs.calcheight(25),
                        ),
                      ),
                      Text(
                        'ﻛﻴﻒ ﺗﻘﻴﻢ ﺍﻻﺳﺘﺸﺎﺭﺓ؟',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Configs.calcheight(25),
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          ratings = rating.round();
                        },
                      ),
                      Container(
                        width: Configs.calcwidth(500),
                        height: Configs.calcheight(200),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1)
                        ),
                        child: TextField(
                          controller: feedbackcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                            fontSize: Configs.calcheight(30),
                          ),
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'شارك تجربتك',
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        height: Configs.calcheight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Configs.calcwidth(187),
                            height: Configs.calcheight(70),
                            margin: EdgeInsets.only(
                                bottom: Configs.calcheight(7), left: 5),
                            child: FlatButton(
                              color: Color(0xff1861CE),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(Configs.calcheight(50)),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'ﺍﻟﻐﺎﺀ ﺍﻷﻣﺮ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: Configs.calcheight(30),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: Configs.calcwidth(187),
                            height: Configs.calcheight(70),
                            margin: EdgeInsets.only(
                                bottom: Configs.calcheight(7), left: 5),
                            child: FlatButton(
                              color: Color(0xff00A68C),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(Configs.calcheight(50)),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                sendfeedback();
                              },
                              child: Text(
                                'إرسال',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: Configs.calcheight(30),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }

  Future<void> sendfeedback() async {
    BaseMainRepository _baseMainRepository = BaseMainRepository();
    String response = await _baseMainRepository.patient_givefeedback(feedbackcontroller.text.trim(), ratings);
    var result = jsonDecode(response);
    if(result['status'] == 'success'){
      opensuccessmodal();
    }
  }

  void opensuccessmodal() {
    showDialog(
        barrierDismissible: true,
        context: context,
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
                    Image.asset('assets/images/ic_success_modal.png',
                      width: Configs.calcheight(171),
                      height: Configs.calcheight(171),),
                    SizedBox(
                      height: Configs.calcheight(20),
                    ),
                    Text(' تم الاستلام بنجاح',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(25),
                      ),),
                    Text('شكرا لتقييمك الاستشارة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Configs.calcheight(25),
                      ),),
                  ],
                )
            ),
          );
        }).then((value) async {
      Configs.con.getConsultant();
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
    });
  }
}
