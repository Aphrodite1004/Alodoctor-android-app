import 'package:flutter/material.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';
class MainHeader1 extends StatefulWidget {
  String label;
  GlobalKey<ScaffoldState> scaffoldKey;
  MainHeader1(this.label, this.scaffoldKey);
  @override
  _MainHeader1State createState() => _MainHeader1State();
}

class _MainHeader1State extends State<MainHeader1> {


  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: Configs.calcheight(120),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Configs.calcwidth(172),
            height: Configs.calcheight(63),
            margin: EdgeInsets.only(left: Configs.calcheight(20)),

            child: FlatButton(
              color: Blue06,
              textColor: Colors.white,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ﺍﻟﺮﺟﻮﻉ',
                      style: TextStyle(
                        fontSize: Configs.calcheight(25),
                      ),
                    ),
                    Image.asset('assets/images/ic_back.png',
                      width: Configs.calcheight(40),
                      height: Configs.calcheight(40),),
                  ],
                ),
              )
            ),
          ),
          Container(
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      'ﺍﺳﺘﺸﺎﺭﺗﻚ ﺍﻵﻥ',
                      style: TextStyle(
                          fontSize: Configs.calcheight(30),
                          color: Colors.black
                      ),
                    ),
                    Text(
                      'ﺍﺑﺪﺃ ',
                      style: TextStyle(
                          fontSize: Configs.calcheight(30),
                          color: Color(0xffE14817)
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: Configs.calcheight(83),
                  height: Configs.calcheight(69),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/ic_menu.png',),
                      fit: BoxFit.fill
                    )
                  ),
                  child: FlatButton(
                    onPressed: (){
                      widget.scaffoldKey.currentState.openEndDrawer();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}


