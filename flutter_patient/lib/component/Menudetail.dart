import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/screen/Doctordeatil.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/api_endpoints.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Menudetail extends StatefulWidget {
  @override
  _MenudetailState createState() => _MenudetailState();
}

class _MenudetailState extends State<Menudetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Configs.calcheight(7)),
          width: double.infinity,
          color: Gray03,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Configs.calcwidth(166),
                height: Configs.calcheight(66),
                color: Gray04,
                child: OutlineButton(
                    color: Gray04,
                    textColor: Black0,
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: Configs.calcheight(3)),
                    padding: EdgeInsets.all(1),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(Configs.calcheight(7)),
                    ),
                    onPressed: () {},
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        Configs.menu_title,
                        style: TextStyle(
                            fontSize: Configs.calcheight(27),
                            color: Black0),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
              Text(
                'ﺍﺳﺄﻝ ﻭﺍﺳﺘﺸﺮ ﺍﻟﻄﺒﻴﺐ ﺍﻟﻤﺨﺘﺺ ﻓﻲ',
                style: TextStyle(
                    fontSize: Configs.calcheight(24), color: Black0),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: Configs.menu_dotors.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: Configs.calcheight(20),
                      horizontal: Configs.calcheight(10)),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: Configs.calcheight(3), color: Gray01),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Configs.calcheight(12),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    Configs.menu_dotors[index].fname +
                                        ' ' +
                                        Configs.menu_dotors[index].lname,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Configs.calcheight(26)),
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    'assets/images/ic_bright.png',
                                    width: Configs.calcheight(30),
                                    height: Configs.calcheight(30),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: Configs.calcheight(15)),
                                child: Text(
                                  Configs.menu_title,
                                  style: TextStyle(
                                      fontSize: Configs.calcheight(26),
                                      color: Black02),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Container(
                                child: RatingBar.builder(
                                  initialRating: Configs.menu_dotors[index].rate - 1,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  itemSize: Configs.calcheight(25),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 1,
                                  ),
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
                                    width: Configs.calcheight(125),
                                    height: Configs.calcheight(125),
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: new NetworkImage(
                                            APIEndPoints.mediaurl +
                                                Configs.menu_dotors[index]
                                                    .photo,
                                          )),
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
                                  width: Configs.calcheight(25),
                                  height: Configs.calcheight(25),
                                  child: Icon(
                                    Icons.brightness_1,
                                    color: Configs.menu_dotors[index]
                                        .active_state ==
                                        1
                                        ? Green01
                                        : Gray04,
                                    size: Configs.calcheight(25),
                                  ),
                                ),
                                left: Configs.calcwidth(4),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top:Configs.calcheight(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Configs.calcwidth(188),
                              height: Configs.calcheight(100),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Configs.calcheight(8))),
                                color: Gray03,),
                              padding: EdgeInsets.only(top: Configs.calcheight(10), left: Configs.calcheight(10), right: Configs.calcheight(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'ﺳﻨﻮﺍﺕ ﺍﻟﺨﺒﺮﺓ',
                                    style: TextStyle(
                                        color: Black02,
                                        fontSize: Configs.calcheight(24)
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Configs.calcheight(8))),
                                      color: Colors.white,),
                                    margin: EdgeInsets.only(top: Configs.calcheight(5)),
                                    padding: EdgeInsets.symmetric(horizontal: Configs.calcheight(21), vertical: Configs.calcheight(1)),
                                    child: Text(
                                      Configs.menu_dotors[index].experience,
                                      style: TextStyle(
                                          fontSize: Configs.calcheight(20)
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: Configs.calcwidth(188),
                              height: Configs.calcheight(100),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Configs.calcheight(8))),
                                color: Gray03,),
                              padding: EdgeInsets.only(top: Configs.calcheight(10), left: Configs.calcheight(10), right: Configs.calcheight(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'ﺭﻗﻢ ﺍﻟﺘﺮﺧﻴﺺ',
                                    style: TextStyle(
                                        color: Black02,
                                        fontSize: Configs.calcheight(24)
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Configs.calcheight(8))),
                                      color: Colors.white,),
                                    margin: EdgeInsets.only(top: Configs.calcheight(5)),
                                    padding: EdgeInsets.symmetric(horizontal: Configs.calcheight(21), vertical: Configs.calcheight(1)),
                                    child: Text(
                                      Configs.menu_dotors[index].authorization_no,
                                      style: TextStyle(
                                          fontSize: Configs.calcheight(20)
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: Configs.calcwidth(188),
                              height: Configs.calcheight(100),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Configs.calcheight(8))),
                                color: Gray03,),
                              padding: EdgeInsets.only(top: Configs.calcheight(10), left: Configs.calcheight(10), right: Configs.calcheight(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'ﺍﻟﺪﺭﺟﺔ ﺍﻟﻌﻠﻤﻴﺔ',
                                    style: TextStyle(
                                        color: Black02,
                                        fontSize: Configs.calcheight(24)
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Configs.calcheight(8))),
                                      color: Colors.white,),
                                    margin: EdgeInsets.only(top: Configs.calcheight(5)),
                                    padding: EdgeInsets.symmetric(horizontal: Configs.calcheight(21), vertical: Configs.calcheight(1)),
                                    child: Text(
                                      Configs.menu_dotors[index].degree,
                                      style: TextStyle(
                                          fontSize: Configs.calcheight(20)
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: Configs.calcheight(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: Configs.calcwidth(176),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset('assets/images/ic_chat_black.png',
                                          width: Configs.calcheight(55),
                                          height: Configs.calcheight(55),
                                        ),
                                        Image.asset('assets/images/ic_voice.png',
                                          width: Configs.calcheight(55),
                                          height: Configs.calcheight(55),
                                        ),
                                        Image.asset('assets/images/ic_video.png',
                                          width: Configs.calcheight(55),
                                          height: Configs.calcheight(55),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: Configs.calcwidth(176),
                                      height: Configs.calcheight(76),
                                      margin: EdgeInsets.only(top: Configs.calcheight(5)),
                                      child: FlatButton(
                                        color: Green01,
                                        textColor: Colors.white,
                                        padding: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(Configs.calcheight(8)),
                                        ),
                                        onPressed: () {
                                          int indexs = 0;
                                          for(int i = 0; i < Configs.umodel.doctors.length; i++){
                                            if(Configs.umodel.doctors[i].id ==  Configs.menu_dotors[index].id){
                                              indexs = i;
                                            }
                                          }
                                          Configs.con_doctor1 = Configs.umodel.doctors[indexs];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Doctordetail(
                                                      )));
                                        },
                                        child: Text(
                                          'ﺑﺪﺃ ﺍﻻﺳﺘﺸﺎﺭﺓ',
                                          style: TextStyle(
                                              fontSize: Configs.calcheight(24),
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              width: Configs.calcwidth(377),
                              height: Configs.calcheight(130),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Configs.calcheight(8))),
                                color: Gray03,),
                              padding: EdgeInsets.only(right: Configs.calcheight(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text(Configs.menu_dotors[index].satisfied.toStringAsFixed(2) + '% ﺍﺑﺪﻭﺍ ﺭﺿﺎﻳﺘﻬﻢ ﻋﻦ ﺍﻻﺳﺘﺸﺎﺭﺓ',
                                            style: TextStyle(
                                                color: Black02,
                                                fontSize: Configs.calcheight(22)
                                            ),
                                            textDirection: TextDirection.rtl,
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,),
                                          margin: EdgeInsets.only(right: Configs.calcheight(15)),
                                          padding: EdgeInsets.all(Configs.calcheight(5)),
                                        ),
                                      ),
                                      Image.asset('assets/images/ic_heart.png',
                                        width: Configs.calcheight(30),
                                        height: Configs.calcheight(30),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: Configs.calcheight(15)),
                                        padding: EdgeInsets.all(Configs.calcheight(5)),
                                        child: Text(Configs.menu_dotors[index].questioned.toString() + ' ﻋﺪﺩ ﺍﻻﺳﺌﻠﺔ',
                                          style: TextStyle(
                                              color: Black02,
                                              fontSize: Configs.calcheight(22)
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                      Image.asset('assets/images/ic_question.png',
                                        width: Configs.calcheight(30),
                                        height: Configs.calcheight(30),),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
