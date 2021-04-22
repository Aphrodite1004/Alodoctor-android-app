import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/models/doctor.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/base_main_repo.dart';
import 'package:flutter_patient/utils/colors.dart';

class Menulistpage extends StatefulWidget {
  Menulistpage();

  @override
  _MenulistpageState createState() => _MenulistpageState();
}

class _MenulistpageState extends State<Menulistpage> {

  BaseMainRepository _baseMainRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _baseMainRepository = BaseMainRepository();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1 , right: MediaQuery.of(context).size.width * 0.1),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: Configs.umodel.menus.length,
          itemBuilder: (context, index){
            print(Configs.umodel.menus[0].id);
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: Configs.calcheight(66),
              margin: EdgeInsets.only(top: Configs.calcheight(10)),
              color: Gray04,
              child: FlatButton(
                color: Gray04,
                textColor: Colors.white,
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Configs.calcheight(7)),
                ),
                onPressed: () async {
                  String response = await _baseMainRepository.patient_menulist(Configs.umodel.menus[index].id);
                  var result = jsonDecode(response);
                  if(result['status'] ==  'success'){
                    Map<String, dynamic> decodedJSON = {};
                    decodedJSON = jsonDecode(response) as Map<String, dynamic>;
                    Configs.menu_dotors = decodedJSON['doctor'] != null ? List.from(decodedJSON['doctor']).map((e) => doctor.fromJSON(e)).toList() : [];
                  }
                  Configs.menu_title = Configs.umodel.menus[index].text;
                  Configs.menu_flag = true;
                  if(Configs.tabController != null){
                    Configs.tabController.animateTo(3);
                  }
                  if(Configs.tabController1 != null){
                    Configs.tabController1.animateTo(3);
                  }
                },
                child: Text(
                  Configs.umodel.menus[index].text,
                  style: TextStyle(
                    fontSize: Configs.calcheight(25),
                    color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
