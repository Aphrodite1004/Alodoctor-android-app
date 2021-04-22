import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_patient/component/Bottombar.dart';
import 'package:flutter_patient/component/MainHeader1.dart';
import 'package:flutter_patient/component/NavDrawer.dart';
import 'package:flutter_patient/component/Profilecomponent.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class Addpayment extends StatefulWidget {
  @override
  _AddpaymentState createState() => _AddpaymentState();
}

class _AddpaymentState extends State<Addpayment> {
  TextEditingController valuecontroller = TextEditingController();
  TextEditingController cardnumontroller = TextEditingController();
  TextEditingController mmcontroller = TextEditingController();
  TextEditingController yycontroller = TextEditingController();
  TextEditingController cvccontroller = TextEditingController();

  String con_value = '';
  BaseMainRepository _baseMainRepository;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool one_flag = false;
  bool two_flag = false;
  bool three_flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _baseMainRepository = BaseMainRepository();
  }

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  add_money() async {
    if (formKey.currentState.validate()) {

    } else {
      return;
    }
    String cardnums = cardNumber.replaceAll(' ', '');
    String exp_month = expiryDate.split("/").elementAt(0);
    String exp_year = '20' + expiryDate.split("/").elementAt(1);
    String cvc = cvvCode;
    print(cardnums);
    print(exp_month);
    print(exp_year);
    print(cvc);
    String amount = valuecontroller.text.trim();
    if(cardnums.length == 0 || exp_month.length == 0 || exp_year.length == 0 || cvc.length == 0 || amount.length == 0){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Alert"),
              content: new Text('يرجى التأكد من ملئ جميع الحقول'),
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
    } else{
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
      String response = await _baseMainRepository.patient_addmoney(cardnums, exp_month, exp_year, cvc, amount);
      Navigator.of(context).pop();
      var result = jsonDecode(response);
      if(result['status'] == 'success'){
        Configs.umodel.money = Configs.umodel.money + int.parse(amount);
        showsuccesmodal();
      } else{
        showerrormodal();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      key: scaffoldKey,
      endDrawer: NavDrawer(scaffoldKey),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainHeader1('ﺍﺧﺘﺮ ﻃﺒﻴﺒﻚ ﻭﺍﺳﺘﺸﺮ', scaffoldKey),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - Configs.calcheight(220),
                color: White0,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Profilecomponent(),
                      Container(
                        child: Container(
                          width: double.infinity,
                          height: Configs.calcheight(100),
                          margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                          padding: EdgeInsets.only(right: Configs.calcheight(28)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Configs.calcheight(8))),
                            color: Blue06,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'ﺍﺿﺎﻓﺔ ﺍﻟﺮﺻﻴﺪ',
                                style: TextStyle(
                                    fontSize: Configs.calcheight(30),
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/images/ic_payment.png',
                                width: Configs.calcheight(45),
                                height: Configs.calcheight(45),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: White0,
                        margin: EdgeInsets.only(top: Configs.calcheight(10)),
                        alignment: Alignment.center,
                        child: Container(
                            margin: EdgeInsets.only(top: Configs.calcheight(13)),
                            padding: EdgeInsets.symmetric(
                                horizontal: Configs.calcheight(17)),
                            width: Configs.calcwidth(577),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            width: Configs.calcwidth(102),
                                            height: Configs.calcheight(77),
                                            margin: EdgeInsets.all(
                                                Configs.calcheight(10)),
                                            child: Material(
                                              child: FlatButton(
                                                color: !three_flag?  Colors.white: Blue06,
                                                textColor: !three_flag ?  Blue06 : Colors.white,
                                                padding: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Configs.calcheight(7)),
                                                ),
                                                onPressed: () {
                                                  valuecontroller.text = '30';
                                                  setState(() {
                                                    three_flag = true;
                                                    one_flag = two_flag = false;
                                                    con_value = '30';
                                                  });
                                                },
                                                child: Text(
                                                  '\$30',
                                                  style: TextStyle(
                                                    fontSize:
                                                    Configs.calcheight(30),
                                                  ),
                                                ),
                                              ),
                                              elevation: Configs.calcheight(7),
                                            )),
                                        Container(
                                            width: Configs.calcwidth(102),
                                            height: Configs.calcheight(77),
                                            margin: EdgeInsets.all(
                                                Configs.calcheight(10)),
                                            child: Material(
                                              child: FlatButton(
                                                color: !two_flag ? Colors.white : Blue06,
                                                textColor: !two_flag ? Blue06 : Colors.white,
                                                padding: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Configs.calcheight(7)),
                                                ),
                                                onPressed: () {
                                                  valuecontroller.text = '20';
                                                  setState(() {
                                                    two_flag = true;
                                                    one_flag = three_flag = false;
                                                    con_value = '20';
                                                  });
                                                },
                                                child: Text(
                                                  '\$20',
                                                  style: TextStyle(
                                                    fontSize:
                                                    Configs.calcheight(30),
                                                  ),
                                                ),
                                              ),
                                              elevation: Configs.calcheight(7),
                                            )),
                                        Container(
                                            width: Configs.calcwidth(102),
                                            height: Configs.calcheight(77),
                                            margin: EdgeInsets.all(
                                                Configs.calcheight(10)),
                                            child: Material(
                                              child: FlatButton(
                                                color: !one_flag ? Colors.white : Blue06,
                                                textColor: !one_flag ? Blue06 : Colors.white,
                                                padding: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Configs.calcheight(7)),
                                                ),
                                                onPressed: () {
                                                  valuecontroller.text = '10';
                                                  setState(() {
                                                    one_flag = true;
                                                    two_flag = three_flag = false;
                                                    con_value = '10';
                                                  });
                                                },
                                                child: Text(
                                                  '\$10',
                                                  style: TextStyle(
                                                    fontSize:
                                                    Configs.calcheight(30),
                                                  ),
                                                ),
                                              ),
                                              elevation: Configs.calcheight(7),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: Configs.calcheight(20)),
                                      child: Text(
                                        'ﺍﺧﺘﺮ ﺍﻟﺮﺻﻴﺪ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Configs.calcheight(30)),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Configs.calcheight(10)),
                                  width: Configs.calcwidth(520),
                                  child: Row(
                                    children: [
                                     Expanded(
                                       child:  Container(
                                         height: Configs.calcheight(1),
                                         color: Gray07,
                                       ),
                                     ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: Configs.calcheight(25)),
                                        child: Text(
                                          'ﺃﻭ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Configs.calcheight(30)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: Configs.calcheight(1),
                                          color: Gray07,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Configs.calcwidth(535),
                                  margin: EdgeInsets.only(
                                      top: Configs.calcheight(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Material(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                            border: new Border.all(
                                              color: Colors.white,
                                              width: 1.0,
                                            ),
                                          ),
                                          width: Configs.calcwidth(151),
                                          height: Configs.calcheight(77),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: Configs.calcheight(25)),
                                          child: TextField(
                                            controller: valuecontroller,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                border: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.all(0)),
                                            onChanged: (text) {
                                              setState(() {
                                                con_value = text;
                                              });
                                              if(int.parse(text) == 30){
                                                setState(() {
                                                  three_flag = true;
                                                  one_flag = two_flag = false;
                                                });
                                              }
                                              else if(int.parse(text) == 20){
                                                setState(() {
                                                  two_flag = true;
                                                  one_flag = three_flag = false;
                                                });
                                              } else if(int.parse(text) == 10 ){
                                                setState(() {
                                                  one_flag = true;
                                                  three_flag = two_flag = false;
                                                });
                                              } else {
                                                three_flag = one_flag = two_flag = false;
                                              }
                                            },
                                            style: TextStyle(
                                                fontSize: Configs.calcheight(30)),
                                          ),
                                        ),
                                        elevation: Configs.calcheight(8),
                                      ),
                                      Text(
                                        'ﺍﻛﺘﺐ ﺍﻟﺮﺻﻴﺪ ﺍﻟﺬﻱ ﺗﻮﺩ ﺍﺿﺎﻓﺘﻪ',
                                        style: TextStyle(
                                            fontSize: Configs.calcheight(30),
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      Container(
                        width: Configs.calcwidth(535),
                        margin: EdgeInsets.only(top: Configs.calcheight(80)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/images/ic_expresscard.png',
                                    width: Configs.calcheight(87),
                                    height: Configs.calcheight(30),
                                  ),
                                  width: Configs.calcwidth(101),
                                  height: Configs.calcheight(60),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: Configs.calcheight(10)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Configs.calcheight(3))),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  child: Image.asset(
                                    'assets/images/ic_visacard.png',
                                    width: Configs.calcheight(87),
                                    height: Configs.calcheight(30),
                                  ),
                                  width: Configs.calcwidth(101),
                                  height: Configs.calcheight(60),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: Configs.calcheight(10)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Configs.calcheight(3))),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  child: Image.asset(
                                    'assets/images/ic_mastercard.png',
                                    width: Configs.calcheight(87),
                                    height: Configs.calcheight(30),
                                  ),
                                  width: Configs.calcwidth(101),
                                  height: Configs.calcheight(60),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: Configs.calcheight(10)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Configs.calcheight(3))),
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'ﻃﺮﻕ ﺍﻟﺪﻓﻊ',
                              style: TextStyle(
                                  color: Gray08,
                                  fontSize: Configs.calcheight(30)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Configs.calcheight(21),
                      ),
                      CreditCardWidget(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        showBackView: isCvvFocused,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                      ),
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      Container(
                        width: Configs.calcwidth(535),
                        height: Configs.calcheight(83),
                        child: FlatButton(
                            color: Blue06,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(Configs.calcheight(3)),
                            ),
                            onPressed: () {
                              add_money();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ic_confirm.png',
                                  width: Configs.calcheight(50),
                                  height: Configs.calcheight(50),
                                ),
                                SizedBox(
                                  width: Configs.calcheight(15),
                                ),
                                Text(
                                  ' ﺩﻓﻊ ' + con_value + '\$',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: Configs.calcheight(30),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        width: Configs.calcwidth(535),
                        margin: EdgeInsets.only(top: Configs.calcheight(10)),
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: 'By clicking above you agree to our ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Configs.calcheight(25)),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Terms & Conditions',
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                          fontSize: Configs.calcheight(25)),
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        opentermurl();
                                      }
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Configs.calcheight(25)),
                                  ),
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                          fontSize: Configs.calcheight(25)),
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        openpolicyurl();
                                      }
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Image.asset('assets/images/ic_license.png',
                        width: Configs.calcheight(120),
                        height: Configs.calcheight(100),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
      bottomNavigationBar:  Bottombar(2),
    );
  }

  void opentermurl() async{
    const url = 'https://alodoctor.online/legal.html';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

  void openpolicyurl() async{
    const url = 'https://alodoctor.online/privacy-and-policy.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  void showsuccesmodal() {

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(38)))),
            child: Container(
                width: Configs.calcwidth(460),
                height: Configs.calcheight(325),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Configs.calcheight(55),
                    ),
                    Image.asset('assets/images/ic_success_modal.png',
                      width: Configs.calcheight(121),
                      height: Configs.calcheight(121),),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: Configs.calcheight(15)),
                      child: Text('ﺗﻢ ﺍﺿﺎﻓﺔ ﺍﻟﺮﺻﻴﺪ ﺑﻨﺠﺎﺡ',
                        style: TextStyle(
                          color: Green03,
                          fontSize: Configs.calcheight(30),
                        ),),
                    )
                  ],
                )
            ),
          );
        }).then((value) async {
      Navigator.popUntil(context, ModalRoute.withName('/consultant'));
    });
  }

  void showerrormodal() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(38)))),
            child: Container(
                width: Configs.calcwidth(460),
                height: Configs.calcheight(402),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Configs.calcheight(55),
                    ),
                    Image.asset('assets/images/ic_failed_wallet.png',
                      width: Configs.calcheight(121),
                      height: Configs.calcheight(121),),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: Configs.calcheight(15)),
                      child: Text('ﻳﺮﺟﻰ ﺍﻟﺘﺄﻛﺪ ﻣﻦ ﺍﻟﻤﻌﻠﻮﻣﺎﺕ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Configs.calcheight(30),
                        ),),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: Configs.calcheight(15)),
                      child: Text('ﻭﺍﻟﻤﺤﺎﻭﻟﺔ ﻣﺮﺓ ﺍﺧﺮﻯ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Configs.calcheight(30),
                        ),),
                    )
                  ],
                )
            ),
          );
        });
  }
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
