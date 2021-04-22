import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/screen/LandingPage.dart';
import 'package:flutter_patient/screen/ProfilePage.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';

class Bottombar extends StatefulWidget {
  int index;
  Bottombar(this.index);
  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  @override
  Widget build(BuildContext context) {
    int total = 0;
    for(int i = 0; i < Configs.con.unread_num.length; i++){
      total = total + Configs.con.unread_num[i];
    }
    return Container(
      height: Configs.calcheight(100),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.black),
        ),
      ),
      padding: EdgeInsets.only(
          left: Configs.calcwidth(23), right: Configs.calcwidth(23)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Configs.calcwidth(125),
            height: Configs.calcheight(75),
            margin: EdgeInsets.only(left: Configs.calcwidth(23)),
            child: FlatButton(
              color: widget.index == 0 ? Gray01 : Colors.transparent,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(Configs.calcheight(96/2)),
              ),
              onPressed: () {
                Configs.tabController1.animateTo(2);
                Navigator.popUntil(context, ModalRoute.withName('/consultant'));
              },
              child:
              total == 0? Image.asset('assets/images/ic_notification.png',
                width: Configs.calcheight(50),
                height: Configs.calcheight(50),
              ) : Badge(
                shape: BadgeShape.circle,
                borderRadius: BorderRadius.circular(100),
                child:  Image.asset('assets/images/ic_notification.png',
                  width: Configs.calcheight(50),
                  height: Configs.calcheight(50),
                ),
                position: BadgePosition.topEnd(top: -10 ,end: -10),
                badgeContent: Text(
                  total.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            width: Configs.calcwidth(125),
            height: Configs.calcheight(75),
            child: FlatButton(
              color: widget.index == 1 ? Gray01 : Colors.transparent,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(Configs.calcheight(96/2)),
              ),
              onPressed: () {
                Configs.menu_flag = false;
                Configs.con.setState((){});
                Configs.tabController1.animateTo(3);
                Navigator.popUntil(context, ModalRoute.withName('/consultant'));

              },
              child: Image.asset('assets/images/ic_home.png',
                width: Configs.calcheight(50),
                height: Configs.calcheight(50),
              ),
            ),
          ),
          Container(
            width: Configs.calcwidth(125),
            height: Configs.calcheight(75),
            margin: EdgeInsets.only(right: Configs.calcwidth(23)),
            child: FlatButton(
              color: widget.index == 2 ? Gray01 : Colors.transparent,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(Configs.calcheight(96/2)),
              ),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/consultant'));
                if(!Configs.auth_flag){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LandingPage()
                  ));
                } else {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfilePage()
                  ));
                }
              },
              child: Image.asset('assets/images/ic_profile.png',
                width: Configs.calcheight(50),
                height: Configs.calcheight(50),
              ),
            ),
          )
        ],
      ),
    );
  }
}
