import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/controllers/consultantcontroller.dart';
import 'package:flutter_patient/screen/ChatPage.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';

class CurrentConsultant extends StatefulWidget {
  consultantcontroller con;
  CurrentConsultant(this.con);

  @override
  _CurrentConsultantState createState() => _CurrentConsultantState();
}

class _CurrentConsultantState extends State<CurrentConsultant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Configs.calcheight(28)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Configs.calcheight(7))),
                    color: Gray05,),
                  width: Configs.calcwidth(125),
                  height: Configs.calcheight(55),
                  padding: EdgeInsets.only(right: Configs.calcheight(15)),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ﺍﺳﺘﺠﺎﺑﺔ',
                    style: TextStyle(
                      fontSize: Configs.calcheight(27),
                      color: Gray06,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Configs.calcheight(7))),
                    color: Gray05,),
                  width: Configs.calcwidth(149),
                  height: Configs.calcheight(55),
                  padding: EdgeInsets.only(right: Configs.calcheight(15)),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ﺍﻟﺘﺎﺭﻳﺦ',
                    style: TextStyle(
                      fontSize: Configs.calcheight(27),
                      color: Gray06,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Configs.calcheight(7))),
                    color: Gray05,),
                  width: Configs.calcwidth(215),
                  height: Configs.calcheight(55),
                  padding: EdgeInsets.only(right: Configs.calcheight(15)),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ﺍﻷﺳﻢ',
                    style: TextStyle(
                      fontSize: Configs.calcheight(27),
                      color: Gray06,
                    ),
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.con.new_consultArr.length,
                itemBuilder: (context, index) {
                  String img_icon;
                  switch(widget.con.new_consultArr[index].type){
                    case 'typing':
                      img_icon = 'assets/images/ic_chat_white.png';
                      break;
                    case 'voice':
                      img_icon = 'assets/images/ic_voice_white.png';
                      break;
                    case 'video':
                      img_icon = 'assets/images/ic_video_white.png';
                      break;
                  }
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: Configs.calcheight(1), color: Colors.black),
                      ),
                    ),
                    padding: EdgeInsets.all(Configs.calcheight(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: Configs.calcwidth(125),
                              height: Configs.calcheight(72),
                              margin: EdgeInsets.only(left: Configs.calcwidth(12)
                              ),
                              child: FlatButton(
                                color: Green01,
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(Configs.calcheight(7)),
                                ),
                                onPressed: () {
                                  for(int i = 0; i < Configs.umodel.doctors.length; i++){
                                    if(Configs.umodel.doctors[i].id == widget.con.new_consultArr[index].doctorId){
                                      Configs.con_doctor1 = Configs.umodel.doctors[i];
                                    }
                                  }
                                  Configs.conmodel = widget.con.new_consultArr[index];
                                  Navigator.popUntil(context, ModalRoute.withName('/consultant'));
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ChatPage()
                                  ));
                                },
                                child: widget.con.unread_num[index] != 0 ?
                                Badge(
                                  shape: BadgeShape.circle,
                                  borderRadius: BorderRadius.circular(100),
                                  child:  Image.asset(img_icon,
                                    width: Configs.calcheight(50),
                                    height: Configs.calcheight(50),
                                  ),
                                  position: BadgePosition.topStart(top: -10 ,start: -10),
                                  badgeContent: Text(
                                    widget.con.unread_num[index].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ):
                                Image.asset(img_icon,
                                  width: Configs.calcheight(50),
                                  height: Configs.calcheight(50),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.con.new_consultArr[index].createdAt,
                                style: TextStyle(
                                    fontSize: Configs.calcheight(27),
                                    color: Gray06
                                ),
                              ),
                              margin: EdgeInsets.only(left: Configs.calcheight(12)),
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: Configs.calcheight(13)),
                            child: Text(
                              widget.con.new_consultArr[index].fname.toString() + ' ' + widget.con.new_consultArr[index].lname.toString(),
                              style: TextStyle(
                                  fontSize: Configs.calcheight(27),
                                  color: Gray06
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),

          )
        ],
      ),
    );
  }
}
