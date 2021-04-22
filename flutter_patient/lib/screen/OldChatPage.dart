import 'package:flutter/material.dart';
import 'package:flutter_patient/component/Bottombar.dart';
import 'package:flutter_patient/component/Chatcomponent.dart';
import 'package:flutter_patient/component/CurrentConsultant.dart';
import 'package:flutter_patient/component/MainHeader.dart';
import 'package:flutter_patient/component/NavDrawer.dart';
import 'package:flutter_patient/component/OldChatcomponent.dart';
import 'package:flutter_patient/component/OldConsultant.dart';
import 'package:flutter_patient/component/menulistpage.dart';
import 'package:flutter_patient/controllers/consultantcontroller.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class OldChatPage extends StatefulWidget {
  OldChatPage();

  @override
  _OldChatPageState createState() => _OldChatPageState();
}

class _OldChatPageState extends StateMVC<OldChatPage> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _controller;
  int _currentIndex = 0;

  consultantcontroller _con;

  _OldChatPageState() : super(consultantcontroller()){
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 4);
    _controller.addListener(_handleTabSelection);
    _controller.animateTo(3);

    Configs.tabController = _controller;
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  _handleTabSelection() {
    setState(() {
      _currentIndex = _controller.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: NavDrawer(scaffoldKey),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child:SingleChildScrollView(
            child:  Column(
              children: [
                MainHeader('ﺍﺧﺘﺮ ﻃﺒﻴﺒﻚ ﻭﺍﺳﺘﺸﺮ', scaffoldKey),
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - Configs.calcheight(220),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child:  TabBar(
                              isScrollable: true,
                              controller: _controller,
                              unselectedLabelColor:
                              Colors.black.withOpacity(0.3),
                              indicatorColor: Colors.white,
                              labelPadding: EdgeInsets.only(left: 4, right: 4),
                              tabs: [
                                Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                                      color: _currentIndex == 0 ? Color(0xff0D5FC1): Colors.white,
                                      border: Border.all(
                                          color: Color(0xff0D5FC1)
                                      ),
                                    ),
                                    width: Configs.calcwidth(265),
                                    height: Configs.calcheight(72),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ﺍﺳﺘﺸﺎﺭﺍﺗﻲ ﺍﻟﺴﺎﺑﻘﺔ',
                                      style: TextStyle(
                                          fontSize: Configs.calcheight(25),
                                          color: _currentIndex == 0 ? Colors.white:Color(0xff0D5FC1)
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                                      color:  _currentIndex == 1 ? Color(0xff0D5FC1): Colors.white,
                                      border: Border.all(
                                          color: Color(0xff0D5FC1)
                                      ),
                                    ),
                                    width: Configs.calcwidth(180),
                                    height: Configs.calcheight(72),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ﺍﻻﻗﺴﺎﻡ',
                                      style: TextStyle(
                                          fontSize: Configs.calcheight(25),
                                          color: _currentIndex == 1 ? Colors.white:Color(0xff0D5FC1)
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                                        color: _currentIndex == 2 ?Color(0xff0D5FC1): Colors.white,
                                        border: Border.all(
                                            color: Color(0xff0D5FC1)
                                        ),
                                      ),
                                      width: Configs.calcwidth(250),
                                      height: Configs.calcheight(72),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'استشاراتي الحالية',
                                            style: TextStyle(
                                                fontSize: Configs.calcheight(25),
                                                color: _currentIndex == 2 ?  Colors.white:Color(0xff0D5FC1)
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset( _currentIndex == 2 ? 'assets/images/ic_chatting_2.png' :  'assets/images/ic_chatting_1.png',
                                            width: Configs.calcheight(35),
                                            height: Configs.calcheight(35),)
                                        ],
                                      )
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(Configs.calcheight(20))),
                                        color:  _currentIndex == 3 ? Color(0xff0D5FC1): Colors.white,
                                        border: Border.all(
                                            color: Color(0xff0D5FC1)
                                        ),
                                      ),
                                      width: Configs.calcwidth(200),
                                      height: Configs.calcheight(72),
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: (){
                                          Configs.menu_flag = false;
                                          _controller.animateTo(3);
                                          setState(() { });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'ﺍﺧﺘﺮ ﺍﻟﻄﺒﻴﺐ',
                                              style: TextStyle(
                                                  fontSize: Configs.calcheight(25),
                                                  color:  _currentIndex == 3 ? Colors.white:Color(0xff0D5FC1)
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset( _currentIndex == 3 ? 'assets/images/ic_consult_2.png' : 'assets/images/ic_consult_1.png',
                                              width: Configs.calcheight(35),
                                              height: Configs.calcheight(35),)
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _controller,
                              children: <Widget>[
                                OldConsultant(_con),
                                Menulistpage(),
                                CurrentConsultant(_con),
                                OldChatcomponent()
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                Bottombar(1)
              ],
            ),
          )
        ),
      ),
    );
  }
}
