import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/api_endpoints.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class Profilecomponent extends StatefulWidget {
  @override
  _ProfilecomponentState createState() => _ProfilecomponentState();
}

class _ProfilecomponentState extends State<Profilecomponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Configs.calcheight(235),
      width: Configs.calcwidth(573),
      margin: EdgeInsets.only(top: Configs.calcheight(13),),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(20))),
        color: Gray02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all( Configs.calcheight(7)),
                margin: EdgeInsets.all( Configs.calcheight(12)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                  color: Colors.white,
                ),
                child: Text(
                  ' الرصيد ' + Configs.umodel.money.toString() + '\$',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: Configs.calcheight(30)
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: Configs.calcheight(47), bottom: Configs.calcheight(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Configs.calcheight(75))),
                      color: Gray02,
                      border: Border.all(
                          color: Colors.white, width: Configs.calcheight(7))),
                  margin: EdgeInsets.only(top: Configs.calcheight(20)),
                  height: Configs.calcheight(150),
                  width: Configs.calcheight(150),
                  alignment: Alignment.center,
                  child: Container(
                      width: Configs.calcheight(118),
                      height: Configs.calcheight(118),
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(APIEndPoints.mediaurl + Configs.umodel.photo)))),
                ),
                Container(
                  child: Container(
                    width: Configs.calcwidth(145),
                    height: Configs.calcheight(44),
                    child: FlatButton(
                      color: Gray06,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Configs.calcheight(20)),
                      ),
                      onPressed: (){
                        File image;
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: new Text('Upload a clear picture'),
                                content: Container(
                                  height: 100,
                                  child:  Column(
                                    children: [
                                      new FlatButton(
                                        child: new Text('Take Photo...'),
                                        onPressed: () async {
                                          File image = await ImagePicker.pickImage(
                                              source: ImageSource.camera
                                          );
                                          if(image != null) ChangeImage(image);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      new FlatButton(
                                          child: new Text('Choose from Library'),
                                          onPressed: () async {
                                            File image = await  ImagePicker.pickImage(
                                                source: ImageSource.gallery
                                            );
                                            if(image != null) ChangeImage(image);
                                            Navigator.of(context).pop();
                                          }),


                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("CANCEL"),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    }, )
                                ],
                              );
                            }
                        );
                      },
                      child: Text(
                        'ﺗﺤﺪﻳﺚ ﺍﻟﺼﻮﺭﺓ',
                        style: TextStyle(
                          fontSize: Configs.calcheight(25),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<void> ChangeImage(File file) async {
    String fileName = file.path
        .split('/')
        .last;

    FormData data = FormData.fromMap({
      "patient_id": Configs.umodel.id,
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();

    dio.post(APIEndPoints.kApiBase + 'patient_photo_update', data: data)
        .then((response) {
      var result = jsonDecode(response.toString());
      if (result['status'] == 'success') {
        Configs.umodel.photo = result['patient']['photo'];
        setState(() {});
      }
    })
        .catchError((error) => print(error));
  }
}
