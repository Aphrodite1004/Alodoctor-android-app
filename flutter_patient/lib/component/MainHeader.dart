import 'package:flutter/material.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';
class MainHeader extends StatefulWidget {
  String label;
  GlobalKey<ScaffoldState> scaffoldKey;
  MainHeader(this.label, this.scaffoldKey);
  @override
  _MainHeaderState createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Configs.calcheight(120),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
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


