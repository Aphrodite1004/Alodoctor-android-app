import 'package:flutter/material.dart';
import 'package:flutter_patient/component/Bottombar.dart';
import 'package:flutter_patient/component/MainHeader.dart';
import 'package:flutter_patient/component/MainHeader1.dart';
import 'package:flutter_patient/component/NavDrawer.dart';
import 'package:flutter_patient/component/Profilecomponent.dart';
import 'package:flutter_patient/screen/Addpayment.dart';
import 'package:flutter_patient/screen/Changepassword.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: NavDrawer(scaffoldKey),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            MainHeader1('ﺍﺧﺘﺮ ﻃﺒﻴﺒﻚ ﻭﺍﺳﺘﺸﺮ', scaffoldKey),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Profilecomponent(),
                  Container(
                    child: Container(
                      width: double.infinity,
                      height: Configs.calcheight(100),
                      margin: EdgeInsets.only(left: 5, right: 5,top: 10),
                      child: FlatButton(
                        color: Gray02,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Configs.calcheight(20)),
                        ),
                        onPressed: (){
                          Navigator.popUntil(context, ModalRoute.withName('/consultant'));
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Addpayment()
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'ﺍﺿﺎﻓﺔ ﺭﺻﻴﺪ',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset('assets/images/ic_payment.png',
                              width: Configs.calcheight(45),
                              height: Configs.calcheight(45),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      width: double.infinity,
                      height: Configs.calcheight(100),
                      margin: EdgeInsets.only(left: 5, right: 5,top: 10),
                      child: FlatButton(
                        color: Gray02,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Configs.calcheight(20)),
                        ),
                        onPressed: (){
                          Navigator.popUntil(context, ModalRoute.withName('/consultant'));
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Changepassword()
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'ﺗﻐﻴﻴﺮ ﻛﻠﻤﺔ ﺍﻟﻤﺮﻭﺭ',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Image.asset('assets/images/ic_password.png',
                              width: Configs.calcheight(45),
                              height: Configs.calcheight(45),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Bottombar(2)
          ],
        ),
      ),
    );
  }
}
