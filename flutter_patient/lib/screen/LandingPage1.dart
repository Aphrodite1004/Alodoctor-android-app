import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/controllers/logincontroller.dart';
import 'package:flutter_patient/screen/Signin.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage1 extends StatefulWidget {
  LandingPage1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LandingPage1State createState() => _LandingPage1State();
}

class _LandingPage1State extends State<LandingPage1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(const Duration(seconds: 1), () {
      checklogin(context);
    });
  }
  Future<void> checklogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String t_remember = prefs.getString('rememberme');
    String t_social = prefs.getString('social');
    if(t_remember == 'true'){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Center(
                child: SpinKitCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                    );
                  },
                )
            );
          });
      logincontroller lcontroller = logincontroller();
      String result;
      if(t_social == 'true'){
        result = await lcontroller.loginwithgoogle(prefs.getString('email'), prefs.getString('name'));
      } else {
        result = await lcontroller.login(prefs.getString('email'), prefs.getString('password'));
      }

      Navigator.of(context).pop();
      if(result == 'success'){
        Navigator.pushReplacementNamed(context, '/consultant');
      } else{
        result = await lcontroller.getpatientlist();
        if(result == 'success'){
          Navigator.pushReplacementNamed(context, '/consultant');
        }
      }
    } else{
      logincontroller lcontroller = logincontroller();
      String result = await lcontroller.getpatientlist();
      if(result == 'success'){
        Navigator.pushReplacementNamed(context, '/consultant');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    Configs.calheight = MediaQuery.of(context).size.height / 1238;
    Configs.calwidth = MediaQuery.of(context).size.width / 591;

    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryColor,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_logo.png")
                )
              ),
            ),
            Positioned(
              top: Configs.calcheight(204),
              child: Container(
                width: mediaQueryData.size.width,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'الو دكتور - المستشفى الالكتروني',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Configs.calcheight(40)
                      ),
                    ),
                    Text(
                      'ﺧﺪﻣﺔ ﺍﻻﺳﺘﺸﺎﺭﺓ ﺍﻟﻄﺒﻴﺔ ﺍﻻﻟﻜﺘﺮﻭﻧﻴﺔ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Configs.calcheight(40)
                      ),
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      )
    );
  }

}