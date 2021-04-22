import 'dart:convert';

import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/component/Menudetail.dart';
import 'package:flutter_patient/screen/Doctordeatil.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/api_endpoints.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_patient/models/doctor.dart';

class Doctorlistpage extends StatefulWidget {
  Doctorlistpage();

  @override
  DoctorlistpageState createState() => DoctorlistpageState();
}

class DoctorlistpageState extends State<Doctorlistpage> {
  BaseMainRepository _baseMainRepository;

  TextEditingController searchcontroller = TextEditingController();
  bool search_flag = false;

  List<doctor> search_list = List();
  List<Widget> widgetlist = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _baseMainRepository = BaseMainRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: !Configs.menu_flag
          ? Column(
              children: [
                Container(
                  width: Configs.calcwidth(580),
                  height: Configs.calcheight(160),
                  padding: EdgeInsets.only(left: 5, right: 5, top: Configs.calcheight(6)),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: Configs.calcheight(80),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                    border: new Border(
                                      bottom: BorderSide(
                                        color: Color(0xffEEEEEE),
                                        width: 1.0,
                                      )
                                    ),
                                  ),
                                  padding: EdgeInsets.only(right: 5),
                                  child: TextField(
                                    controller: searchcontroller,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      hintText: 'ابحث عن طبيب',
                                      hintStyle: TextStyle(
                                        fontSize: Configs.calcheight(25),
                                        fontFamily: 'IRANSansWeb',
                                        color: Color(0xffA2A2A2)
                                      ),
                                      contentPadding:
                                      EdgeInsets.all(0),),
                                    onChanged: (text) {
                                      if(text.length == 0){
                                        setState(() {
                                          search_flag = false;
                                        });
                                      } else{
                                        calculatesearch(text);
                                        setState(() {
                                          search_flag = true;
                                        });
                                      }
                                    },
                                    style: TextStyle(
                                        fontSize: Configs.calcheight(30)),
                                  ),
                                  width: double.infinity,
                                )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: Configs
                                  .calcheight(
                                  70),
                              height: Configs
                                  .calcheight(
                                  70),
                              padding: EdgeInsets.all(Configs.calcheight(10)),
                              decoration: BoxDecoration(
                                color: Color(0xffF5F6FA),
                                  border: Border.all(
                                    color: Color(0xffE7E9F2),
                                    width: 2
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/ic_search.png',
                                width: Configs
                                    .calcheight(
                                    40),
                                height: Configs
                                    .calcheight(
                                    40),
                                color: Color(0xff3D4C9A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Configs.calcheight(5),
                      ),
                      Container(
                          width: double.infinity,
                          height: Configs.calcheight(65),
                          padding: EdgeInsets.only(left: 5, right: 5),
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'ﺍﺳﺄﻝ ﻭﺍﺳﺘﺸﺮ ﺍﻟﻄﺒﻴﺐ ﺍﻟﻤﺨﺘﺺ ﻓﻲ',
                              style: TextStyle(
                                fontSize: Configs.calcheight(25),
                                color: Color(0xff0E0E49),
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          )
                      ),
                    ],
                  )
                ),
                !search_flag? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Configs.umodel.menus.length,
                    itemBuilder: (context, index) {
                      ScrollController _controller = ScrollController();
                      // _controller.animateTo(2, duration: Duration (milliseconds: 500), curve: Curves.linear);
                      return Container(
                        width: Configs.calcwidth(570),
                        height: Configs.calcheight(420),
                        decoration: BoxDecoration(
                            color: Colors.white,),
                        margin: EdgeInsets.only(left: Configs.calcheight(10), right: Configs.calcheight(10), bottom: Configs.calcheight(10)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: Configs.calcheight(70),
                                      height: Configs.calcheight(60),
                                      margin: EdgeInsets.only(right: Configs.calcheight(15)),
                                      child: FlatButton(
                                          color: Blue06,
                                          textColor: Colors.white,
                                          padding: EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          onPressed: (){
                                            print(_controller.offset);
                                            _controller.animateTo(_controller.offset - Configs.calcwidth(285),
                                                curve: Curves.linear, duration: Duration(milliseconds: 500));
                                          },
                                          child: Icon(
                                            Icons.keyboard_arrow_left,
                                            size: 30,
                                          )
                                      ),
                                    ),
                                    Container(
                                      width: Configs.calcheight(70),
                                      height: Configs.calcheight(60),
                                      child: FlatButton(
                                          color: Blue06,
                                          textColor: Colors.white,
                                          padding: EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          onPressed: (){
                                            _controller.animateTo(_controller.offset + Configs.calcwidth(285),
                                                curve: Curves.linear, duration: Duration(milliseconds: 500));
                                          },
                                          child: Icon(
                                              Icons.keyboard_arrow_right,
                                            size: 30,
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: Configs.calcheight(66),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(width: 4.0, color:Color(0xff0D5FC1)),
                                      ),
                                      color: Color(0xffFCFCFC),
                                    ),
                                    padding: EdgeInsets.only(
                                        right: Configs.calcwidth(12)),
                                    margin: EdgeInsets.only(
                                        top: Configs.calcheight(10),
                                        left: Configs.calcwidth(12)),
                                    alignment: Alignment.centerRight,
                                    child: FlatButton(
                                      color: Color(0xffFCFCFC),
                                      textColor: Color(0xff0D5FC1),
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Configs.calcheight(7)),
                                      ),
                                      onPressed: () async {
                                        String response =
                                        await _baseMainRepository
                                            .patient_menulist(Configs
                                            .umodel.menus[index].id);
                                        var result = jsonDecode(response);
                                        if (result['status'] == 'success') {
                                          Map<String, dynamic> decodedJSON = {};
                                          decodedJSON = jsonDecode(response)
                                          as Map<String, dynamic>;
                                          Configs.menu_dotors = decodedJSON[
                                          'doctor'] !=
                                              null
                                              ? List.from(decodedJSON['doctor'])
                                              .map(
                                                  (e) => doctor.fromJSON(e))
                                              .toList()
                                              : [];
                                        }
                                        Configs.menu_title =
                                            Configs.umodel.menus[index].text;
                                        Configs.menu_flag = true;
                                        setState(() {});
                                      },
                                      child: Text(
                                        Configs.umodel.menus[index].text,
                                        style: TextStyle(
                                          fontSize: Configs.calcheight(27),
                                          color: Color(0xff0D5FC1),),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                      ),),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xffEBECF4),
                                            width: Configs.calcheight(4)
                                        )
                                          )),

                                  child: ListView.builder(
                                    controller: _controller,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: Configs.umodel.doctors.length,
                                    itemBuilder: (context, indexs) {
                                      return Container(
                                        width: Configs.umodel.menus[index].id !=
                                            Configs.umodel.doctors[indexs]
                                                .menulist_id
                                            ? 0
                                            : Configs.calcwidth(285),
                                        height: Configs.calcheight(330),
                                        padding: EdgeInsets.only(
                                            right: Configs.calcwidth(12),
                                            left: Configs.calcwidth(12)),

                                        child: Container(
                                            height: Configs.calcheight(330),
                                            width: Configs.calcwidth(285),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    top: Configs.calcheight(60),
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all( Radius.circular(10) ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Color(0xffD1D9E6),
                                                            spreadRadius: 0,
                                                            blurRadius: 5,
                                                            offset: Offset(4, 5), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Configs.con_doctor1 = Configs.umodel.doctors[indexs];
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      Doctordetail(
                                                                      )));
                                                        },
                                                        child: Container(
                                                          width: Configs.calcwidth(
                                                              220),
                                                          height:
                                                          Configs.calcheight(
                                                              250),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(Radius.circular(
                                                                Configs
                                                                    .calcheight(
                                                                    7))),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(0xffFFFFFF).withOpacity(0.51),
                                                                spreadRadius: 0,
                                                                blurRadius: 8,
                                                                offset: Offset(8, 7), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                top: 0,
                                                                right: 0,
                                                                child: Flag(
                                                                    Configs
                                                                        .umodel
                                                                        .doctors[
                                                                    indexs].country_code,
                                                                    height: Configs
                                                                        .calcheight(
                                                                        40),
                                                                    width: Configs
                                                                        .calcheight(
                                                                        60),
                                                                    fit: BoxFit
                                                                        .fill),
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Container(
                                                                    margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                      top: Configs
                                                                          .calcheight(
                                                                          80),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Text(
                                                                          Configs
                                                                              .umodel
                                                                              .doctors[
                                                                          indexs]
                                                                              .fname +
                                                                              ' ' +
                                                                              Configs
                                                                                  .umodel
                                                                                  .doctors[indexs]
                                                                                  .lname +
                                                                              ' ',
                                                                          textDirection: TextDirection.rtl,
                                                                          style:
                                                                          TextStyle(
                                                                            fontSize:
                                                                            Configs.calcheight(23),
                                                                            color:
                                                                            Black02,
                                                                          ),
                                                                          maxLines:
                                                                          1,
                                                                        ),
                                                                        Text(
                                                                          ' .د ',
                                                                          textDirection: TextDirection.ltr,
                                                                          style:
                                                                          TextStyle(
                                                                            fontSize:
                                                                            Configs.calcheight(23),
                                                                            color:
                                                                            Black02,
                                                                          ),
                                                                        ),
                                                                        Image.asset(
                                                                          'assets/images/ic_bright.png',
                                                                          width: Configs
                                                                              .calcheight(
                                                                              20),
                                                                          height: Configs
                                                                              .calcheight(
                                                                              20),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: Configs
                                                                            .calcheight(
                                                                            3)),
                                                                    child: Text(
                                                                      Configs
                                                                          .umodel
                                                                          .doctors[
                                                                      indexs]
                                                                          .specialization.toString(),
                                                                      textAlign: TextAlign.center,
                                                                      maxLines: 2,
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                        Configs.calcheight(
                                                                            14),
                                                                        fontFamily: 'IRANSansWeb',
                                                                        color:
                                                                        Color(0xff0E0E49),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: Configs
                                                                            .calcheight(
                                                                            2)),
                                                                    child: Text(
                                                                      Configs
                                                                          .umodel
                                                                          .doctors[
                                                                      indexs]
                                                                          .degree,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          Configs.calcheight(
                                                                              14),
                                                                          fontFamily: 'IRANSansWeb',
                                                                          color:
                                                                          Color(0xff0E0E49)),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: Configs
                                                                        .calcwidth(
                                                                        152),
                                                                    height: Configs
                                                                        .calcheight(
                                                                        41),
                                                                    margin: EdgeInsets.only(
                                                                        top: Configs
                                                                            .calcheight(
                                                                            5)),
                                                                    child:
                                                                    FlatButton(
                                                                      color: Colors.white,
                                                                      textColor:
                                                                      Color(0xff3480E7),
                                                                      padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                          0),
                                                                      shape:
                                                                      RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            Configs.calcheight(11)),
                                                                        side: BorderSide(width: 0.5, color: Color(0xffED1846)),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Configs.con_doctor1 = Configs.umodel.doctors[indexs];
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    Doctordetail()));
                                                                      },
                                                                      child: Text(
                                                                        'ﻃﻠﺐ ﺍﺳﺘﺸﺎﺭﺓ',
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                          Configs.calcheight(
                                                                              14),
                                                                          fontFamily: 'IRANSansWeb',
                                                                          color: Color(0xffED1846),),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                Container(
                                                    width: double.infinity,
                                                    alignment: Alignment.topCenter,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(left: Configs.calcheight(4), top: Configs
                                                              .calcheight(8)),
                                                          child: Container(
                                                            width: Configs
                                                                .calcheight(130),
                                                            height: Configs
                                                                .calcheight(130),
                                                            decoration: new BoxDecoration(
                                                                borderRadius: BorderRadius.all( Radius.circular(10) ),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Color(0xffD1D9E6),
                                                                    spreadRadius: 0,
                                                                    blurRadius: 5,
                                                                    offset: Offset(4, 5), // changes position of shadow
                                                                  ),
                                                                ],
                                                                ),
                                                            child: Container(
                                                              width: double.infinity,
                                                              height: double.infinity,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all( Radius.circular(10) ),
                                                                  border: Border.all(color: Colors.white, width: 5),
                                                                  image: new DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: new NetworkImage(
                                                                        APIEndPoints
                                                                            .mediaurl +
                                                                            Configs
                                                                                .umodel
                                                                                .doctors[indexs]
                                                                                .photo,
                                                                      )),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Color(0xffFFFFFF).withOpacity(0.51),
                                                                    spreadRadius: 0,
                                                                    blurRadius: 8,
                                                                    offset: Offset(8, 7), // changes position of shadow
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          child: Container(
                                                            decoration:
                                                            new BoxDecoration(
                                                              color: Colors.white,
                                                              shape:
                                                              BoxShape.circle,
                                                            ),
                                                            width:
                                                            Configs.calcheight(
                                                                20),
                                                            height:
                                                            Configs.calcheight(
                                                                20),
                                                            child: Icon(
                                                              Icons.brightness_1,
                                                              color: Configs
                                                                  .umodel
                                                                  .doctors[
                                                              indexs]
                                                                  .active_state ==
                                                                  1
                                                                  ? Color(0xff0DD15B)
                                                                  : Gray04,
                                                              size: Configs
                                                                  .calcheight(20),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            )),
                                      );
                                    },
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(
                                      bottom: Configs.calcheight(5)),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ):
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Configs.calcheight(8))),
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.white,
                                width: Configs.calcheight(7))),
                        child: ListView(
                          children: widgetlist.map((element) {
                            return element;
                          }).toList(),
                        ),
                      ),
                    )
              ],
            )
          : Menudetail(),
    );
  }

  void calculatesearch(String text) {
    search_list = List();
    widgetlist = List();
    for(int i = 0; i < Configs.umodel.doctors.length; i++){
      String t_name =  Configs.umodel.doctors[i].fname + ' ' + Configs.umodel.doctors[i].lname;
      print('he');
      print(text);
      print(Configs.umodel.doctors[i].fname);
      print(t_name.toLowerCase().contains(text.toLowerCase()) || Configs.umodel.doctors[i].fname.toLowerCase().contains(text.toLowerCase()) || Configs.umodel.doctors[i].lname.toLowerCase().contains(text.toLowerCase()) || t_name == text || Configs.umodel.doctors[i].lname == text || Configs.umodel.doctors[i].fname == text);
      if(t_name.toLowerCase().contains(text.toLowerCase()) || Configs.umodel.doctors[i].fname.toLowerCase().contains(text.toLowerCase()) || Configs.umodel.doctors[i].lname.toLowerCase().contains(text.toLowerCase()) || t_name == text || Configs.umodel.doctors[i].lname == text || Configs.umodel.doctors[i].fname == text){
        search_list.add(Configs.umodel.doctors[i]);
        setState(() {

        });
      }
    }
    for(int i = 0; i < (search_list.length / 2).round() + 1; i+= 2 ){
      widgetlist.add(Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getdoctoritem(i*2),
            getdoctoritem(i*2 + 1)
          ],
        )
      ));
    }
    setState(() {

    });
  }
  Widget getdoctoritem(int d_index){
    if(d_index >= search_list.length){
      return Container(
        width: Configs.calcwidth(280),
        height: Configs.calcheight(330),
      );
    }
    return Container(
      width: Configs.calcwidth(280),
      height: Configs.calcheight(330),
      padding: EdgeInsets.only(
          right: Configs.calcwidth(12),
          left: Configs.calcwidth(12)),
      child: Container(
          height: Configs.calcheight(300),
          width: Configs.calcwidth(166),
          child: Stack(
            children: [
              Positioned(
                  top: Configs.calcheight(60),
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all( Radius.circular(10) ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffD1D9E6),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(4, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Configs.con_doctor1 = search_list[d_index];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Doctordetail(
                                    )));
                      },
                      child: Container(
                        width: Configs.calcwidth(
                            220),
                        height:
                        Configs.calcheight(
                            250),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffFFFFFF).withOpacity(0.51),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset: Offset(8, 7), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius
                              .all(Radius.circular(
                              Configs
                                  .calcheight(
                                  7))),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Flag(
                                  search_list[d_index].country_code,
                                  height: Configs
                                      .calcheight(
                                      40),
                                  width: Configs
                                      .calcheight(
                                      60),
                                  fit: BoxFit
                                      .fill),
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .start,
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                              children: [
                                Container(
                                  margin:
                                  EdgeInsets
                                      .only(
                                    top: Configs
                                        .calcheight(
                                        75),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Container(
                                        child:  Text(
                                          search_list[d_index]
                                              .fname +
                                              ' ' +
                                              search_list[d_index].lname +
                                              ' ',
                                          style:
                                          TextStyle(
                                            fontSize:
                                            Configs.calcheight(25),
                                            color:
                                            Black02,
                                          ),
                                          maxLines:
                                          1,
                                        ),
                                      ),
                                      Text(
                                        ' .د ',
                                        style:
                                        TextStyle(
                                          fontSize:
                                          Configs.calcheight(25),
                                          color:
                                          Black02,
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/ic_bright.png',
                                        width: Configs
                                            .calcheight(
                                            20),
                                        height: Configs
                                            .calcheight(
                                            20),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Configs
                                          .calcheight(
                                          3)),
                                  child: Text(
                                    search_list[d_index]
                                        .specialization.toString(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize:
                                        Configs.calcheight(
                                            14),
                                      fontFamily: 'IRANSansWeb',
                                      color:
                                      Color(0xff0E0E49),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Configs
                                          .calcheight(
                                          2)),
                                  child: Text(
                                    search_list[d_index]
                                        .degree,
                                    style: TextStyle(
                                        fontSize:
                                        Configs.calcheight(
                                            14),
                                        fontFamily: 'IRANSansWeb',
                                        color:
                                        Color(0xff0E0E49)),
                                  ),
                                ),
                                Container(
                                  width: Configs
                                      .calcwidth(
                                      152),
                                  height: Configs
                                      .calcheight(
                                      41),
                                  margin: EdgeInsets.only(
                                      top: Configs
                                          .calcheight(
                                          5)),
                                  child:
                                  FlatButton(
                                    color: Colors.white,
                                    textColor:
                                    Color(0xff3480E7),
                                    padding:
                                    EdgeInsets
                                        .all(
                                        0),
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          Configs.calcheight(11)),
                                      side: BorderSide(width: 0.5, color: Color(0xffED1846)),
                                    ),
                                    onPressed:
                                        () {
                                      Configs.con_doctor1 = search_list[d_index];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Doctordetail()));
                                    },
                                    child: Text(
                                      'ﻃﻠﺐ ﺍﺳﺘﺸﺎﺭﺓ',
                                      style: TextStyle(
                                          fontSize:
                                          Configs.calcheight(
                                              14),
                                        fontFamily: 'IRANSansWeb',
                                        color: Color(0xffED1846),),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: Configs.calcheight(4), top: Configs
                            .calcheight(8)),
                        width: Configs
                            .calcheight(130),
                        height: Configs
                            .calcheight(130),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all( Radius.circular(10) ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffD1D9E6),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: Offset(4, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all( Radius.circular(10) ),
                            border: Border.all(color: Colors.white, width: 5),
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(
                                  APIEndPoints
                                      .mediaurl +
                                      search_list[d_index]
                                          .photo,
                                )),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffFFFFFF).withOpacity(0.51),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: Offset(8, 7), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          decoration:
                          new BoxDecoration(
                            color: Colors.white,
                            shape:
                            BoxShape.circle,
                          ),
                          width:
                          Configs.calcheight(
                              20),
                          height:
                          Configs.calcheight(
                              20),
                          child: Icon(
                            Icons.brightness_1,
                            color: search_list[d_index]
                                .active_state ==
                                1
                                ? Color(0xff0DD15B)
                                : Gray04,
                            size: Configs
                                .calcheight(20),
                          ),
                        ),
                        left:
                        Configs.calcwidth(4),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
