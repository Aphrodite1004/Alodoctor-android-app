import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/controllers/logincontroller.dart';
import 'package:flutter_patient/screen/Signin.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';

import 'package:flutter_patient/utils/colors.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends StateMVC<SignUp> {
  logincontroller _con;

  BaseMainRepository _baseMainRepository;

  _SignUpState() : super(logincontroller()) {
    _baseMainRepository = BaseMainRepository();
    _con = controller;
  }

  bool error = false;
  bool passsecure = true;
  bool confirmpasssecure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: primaryColor,
        ),
        Positioned(
          top: -Configs.calcheight(300),
          child: Image.asset(
            "assets/images/bg_logo.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height:
                    Configs.calcheight(340) + mediaQueryData.padding.top,
                  ),
                  Container(
                    width: mediaQueryData.size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: Configs.calcheight(850),
                      width: Configs.calcwidth(547),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Configs.calcheight(55))),
                          color: backColor),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding:
                            EdgeInsets.only(top: Configs.calcheight(46)),
                            child: Text(
                              'ﺍﻧﺸﺎﺀ ﺣﺴﺎﺏ',
                              style: TextStyle(
                                fontSize: Configs.calcheight(40),
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          !error
                              ? Container()
                              : Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ﻳﺮﺟﻰ ﺍﻟﺘﺄﻛﺪ ﻣﻦ ﺍﻻﻳﻤﻴﻞ ﻭ ﺍﻟﺒﺎﺳﻮﺭﺩ',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize:
                                          Configs.calcheight(30)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      'assets/images/ic_warn.png',
                                      width: Configs.calcheight(50),
                                      height: Configs.calcheight(50),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 20),
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              border: new Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: TextField(
                              controller: fullnameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Image.asset(
                                      'assets/images/ic_fullname.png',
                                      width: Configs.calcheight(50),
                                      height: Configs.calcheight(50),
                                    ),
                                  ),
                                  hintText: 'Full Name',
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 20),
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              border: new Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Image.asset(
                                      'assets/images/ic_email.png',
                                      width: Configs.calcheight(50),
                                      height: Configs.calcheight(50),
                                    ),
                                  ),
                                  hintText: 'Email',
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10, bottom: 5, left: 20, right: 20),
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              border: new Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Image.asset(
                                      'assets/images/ic_lock.png',
                                      width: Configs.calcheight(50),
                                      height: Configs.calcheight(50),
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      this.setState(() {
                                        passsecure = !passsecure;
                                      });
                                    },
                                    icon: Icon(
                                      passsecure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: 'Password',
                                  border: InputBorder.none),
                              obscureText: passsecure,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10, bottom: 5, left: 20, right: 20),
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              border: new Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: TextField(
                              controller: confirmController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Image.asset(
                                      'assets/images/ic_lock.png',
                                      width: Configs.calcheight(50),
                                      height: Configs.calcheight(50),
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      this.setState(() {
                                        confirmpasssecure =
                                        !confirmpasssecure;
                                      });
                                    },
                                    icon: Icon(
                                      confirmpasssecure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: 'Confirm Password',
                                  border: InputBorder.none),
                              obscureText: confirmpasssecure,
                            ),
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(top: Configs.calcheight(30)),
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Container(
                              width: Configs.calcwidth(248),
                              height: Configs.calcheight(71),
                              margin: EdgeInsets.only(right: 20),
                              child: FlatButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Configs.calcheight(35)),
                                ),
                                onPressed: () {
                                  signupuser();
                                },
                                child: Text(
                                  'ﺍﻧﺸﺎﺀ ﺣﺴﺎﺏ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Configs.calcheight(30)),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                            EdgeInsets.only(top: Configs.calcheight(30)),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: Text(
                                'ﻟﺪﻳﻚ ﺣﺴﺎﺏ؟ ﻗﻢ ﺑﺘﺴﺠﻴﻞ ﺍﻟﺪﺧﻮﻝ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Configs.calcheight(27)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> signupuser() async {
    String t_email = _emailController.text.trim();
    String t_pass = _passwordController.text.trim();
    String t_conpass = confirmController.text.trim();
    String t_fullname = fullnameController.text.trim();
    if (t_email.length == 0 ||
        t_pass.length == 0 ||
        t_conpass.length == 0 ||
        t_fullname.length == 0 ||
        t_pass != t_conpass) {
      setState(() {
        error = true;
      });
    } else {

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Center(child: SpinKitCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                );
              },
            ));
          });
      String response = await _baseMainRepository.patient_register(
          t_fullname, t_pass, t_email);
      Navigator.of(context).pop();
      var result = jsonDecode(response);
      if (result['status'] == 'success') {
        showsuccessmodal();
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("ملاحظة!"),
                content: new Text('البريد الالكتروني او الرمز المدخل غير صحيح'),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    }
  }

  void showsuccessmodal() {

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(55)))),
            child: Container(
                width: Configs.calcwidth(547),
                height: Configs.calcheight(339),
                padding: EdgeInsets.all(Configs.calcheight(10)),
                child: Stack(
                  children: [
                    Container(

                      padding: EdgeInsets.only(top:Configs.calcheight(30), right: Configs.calcheight(30)),
                      alignment: Alignment.topRight,
                      child: Container(
                        width: Configs.calcheight(50),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(Configs.calcheight(25)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SignIn()
                            ));
                          },
                          child: Image.asset('assets/images/ic_close_modal.png',
                            width: Configs.calcheight(50),
                            height: Configs.calcheight(50),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: Configs.calcwidth(547),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Configs.calcheight(50),
                          ),
                          Image.asset('assets/images/ic_success_modal.png',
                            width: Configs.calcheight(145),
                            height: Configs.calcheight(145),),
                          Text('تم التسجيل بنجاح يمكنك الان تسجيل الدخول',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Configs.calcheight(30),
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
          );
        }).then((value) async {
          Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => SignIn()
      ));
    });
  }
}
