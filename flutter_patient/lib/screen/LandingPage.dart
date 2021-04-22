import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_patient/controllers/logincontroller.dart';
import 'package:flutter_patient/screen/Signin.dart';
import 'package:flutter_patient/screen/Signup.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);
class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
                top: Configs.calcheight(150),
                child: Container(
                  width: mediaQueryData.size.width,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ic_icon.png',
                        width: Configs.calcheight(250),
                        height: Configs.calcheight(250),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Image.asset(
                                'assets/images/ic_blue_chat.png',
                                width: Configs.calcheight(80),
                                height: Configs.calcheight(80),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Image.asset(
                                'assets/images/ic_blue_voice.png',
                                width: Configs.calcheight(80),
                                height: Configs.calcheight(80),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Image.asset(
                                'assets/images/ic_blue_video.png',
                                width: Configs.calcheight(80),
                                height: Configs.calcheight(80),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
            Positioned(
              top: Configs.calcheight(600),
              child: Container(
                width: mediaQueryData.size.width,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'الو دكتور',
                      style: TextStyle(
                        color: Color(0xff474747),
                        fontSize: Configs.calcheight(40)
                      ),
                    ),
                    SizedBox(
                      height:  Configs.calcheight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ﺍﺳﺘﺸﺎﺭﺗﻚ ﺍﻵﻥ',
                          style: TextStyle(
                              color:Color(0xff474747),
                              fontSize: Configs.calcheight(45)
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          width: 5
                        ),
                        Text(
                          'ﺍﺑﺪﺃ',
                          style: TextStyle(
                              color:Color(0xffF54337),
                              fontSize: Configs.calcheight(45)
                          ),
                          textDirection: TextDirection.rtl,
                        ),

                      ],
                    ),
                  ],
                ),
              )
            ),
            Container(
              padding: EdgeInsets.only(top: Configs.calcheight(900)),
              child: Container(
                width: mediaQueryData.size.width,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Configs.calcwidth(183),
                          height: Configs.calcheight(71),
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffA39200)),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: FlatButton(
                            color: Color(0xffFFF384),
                            textColor: Color(0xff465453),
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SignUp()
                              ));
                            },
                            child: Text(
                              'ﺍﻧﺸﺎﺀ ﺣﺴﺎﺏ',
                              style: TextStyle(
                                fontSize: Configs.calcheight(25),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: Configs.calcwidth(210),
                          height: Configs.calcheight(71),
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff00BA88)),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: FlatButton(
                            color: Color(0xffF2FFFB),
                            textColor: Color(0xff00966D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SignIn()
                              ));
                            },
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'ﺗﺴﺠﻴﻞ ﺍﻟﺪﺧﻮﻝ',
                              style: TextStyle(
                                fontSize: Configs.calcheight(25),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:  Container(
                            height: Configs.calcheight(1),
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Configs.calcheight(25)),
                          child: Text(
                            'ﺃﻭ',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: Configs.calcheight(30)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Configs.calcheight(1),
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Material(
                      child: Container(
                        width: Configs.calcwidth(450),
                        height: Configs.calcheight(71),
                        child: FlatButton(
                            color: Color(0xff0069D0),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(99.0),
                            ),
                            onPressed: () async {
                              try {
                                GoogleSignInAccount res = await _googleSignIn.signIn();
                                print('hello');
                                if(res != null){
                                  GoogleSignInAuthentication auth = await res.authentication;
                                  // showDialog(
                                  //     barrierDismissible: false,
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return Center(
                                  //           child: SpinKitCircle(
                                  //             itemBuilder: (BuildContext context, int index) {
                                  //               return DecoratedBox(
                                  //                 decoration: BoxDecoration(
                                  //                   borderRadius: BorderRadius.all(Radius.circular(20)),
                                  //                   color: Colors.white,
                                  //                 ),
                                  //               );
                                  //             },
                                  //           )
                                  //       );
                                  //     });
                                  logincontroller _con = logincontroller();
                                  String result = await _con.loginwithgoogle(res.email, res.displayName);
                                  // Navigator.of(context).pop();
                                  if(result == 'success'){
                                    _con.saveParamwithgoogle(res.email, res.displayName);
                                    Navigator.pushNamed(context, '/consultant');
                                  } else {
                                  }
                                } else{
                                  print('hellos');
                                }
                              } catch (error) {
                                print(error);
                              }
                            },
                            padding: EdgeInsets.all(0),
                            child: Stack(
                              children: [
                                Align(
                                  child: Text(
                                    'Login with Google',
                                    style: TextStyle(
                                      fontSize: Configs.calcheight(25),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              Positioned(
                                right: 20, top: 0, bottom: 0,
                                child:  Align(
                                  child: Container(
                                    child: Image.asset('assets/images/ic_google.png',
                                      width: Configs.calcheight(50),
                                      height: Configs.calcheight(50),),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              )
                              ],
                            )
                        ),
                      ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99.0)),
                    )
                  ],
                )
              )
            ),

          ],
        ),
      )
    );
  }

}