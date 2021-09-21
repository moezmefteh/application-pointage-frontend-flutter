import 'package:pointage/user_chef/textmission.dart';
import 'package:pointage/user_chef/homechef.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Widget/bezierContainer.dart';

final descreptionController = TextEditingController();
final lieuController = TextEditingController();
final userController = TextEditingController();

class ajoutmissionPage extends StatefulWidget {
  _ajoutmissionPageState createState() => _ajoutmissionPageState();
}

class _ajoutmissionPageState extends State<ajoutmissionPage> {
  Widget _entryFieldlieu({bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: lieuController,
              decoration: InputDecoration(
                  hintText: 'Mission place',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  Widget _entryFieldUser({bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: userController,
              decoration: InputDecoration(
                  hintText: 'User of mission',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFielddescription({bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: descreptionController,
              decoration: InputDecoration(
                  hintText: 'Description mission',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFielddescription(),
        _entryFieldUser(),
        _entryFieldlieu(),
        SizedBox(
          height: 20,
        ),
        MyTextFieldDatePicker(
          labelText: "Mission first day",
          prefixIcon: Icon(Icons.date_range),
          suffixIcon: Icon(Icons.arrow_drop_down),
          lastDate: DateTime.now().add(Duration(days: 366)),
          firstDate: DateTime.now(),
          initialDate: DateTime.now().add(Duration(days: 1)),
          onDateChanged: (selectedDate) {
            start = selectedDate.toString().substring(0, 10);
          },
        ),
        SizedBox(
          height: 30,
        ),
        MyTextFieldDatePicker(
          labelText: "Mission last day",
          prefixIcon: Icon(Icons.date_range),
          suffixIcon: Icon(Icons.arrow_drop_down),
          lastDate: DateTime.now().add(Duration(days: 366)),
          firstDate: DateTime.now(),
          initialDate: DateTime.now().add(Duration(days: 2)),
          onDateChanged: (selectedDate2) {
            fin = selectedDate2.toString().substring(0, 10);
          },
        ),
      ],
    );
  }

  String fin, start;
  Future<List> sendmissions() async {
    String url4 = 'http://192.168.1.9:8000/api/missions/list/';

    var response4 = await http.post(Uri.encodeFull(url4), headers: {
      "Accept": "application/json"
    }, body: {
      "description": descreptionController.text.toString(),
      "date_debut": start,
      "date_fin": fin,
      "lieu": lieuController.text.toString(),
      "etat": "waited",
      "user": userController.text.toString()
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => homePagechef()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: 0, top: 10, bottom: 10),
                            child: Icon(Icons.keyboard_arrow_left,
                                color: Colors.black),
                          ),
                          Text('Back',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * .12),
                  new Text(
                    "New mission",
                    style: TextStyle(color: Color(0xff96BAFF), fontSize: 40),
                  ),
                  SizedBox(height: 15),
                  _emailPasswordWidget(),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      if (lieuController.text.isNotEmpty &&
                          userController.text.isNotEmpty &&
                          descreptionController.text.isNotEmpty &&
                          fin != null &&
                          start != null)
                        sendmissions();
                      else
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('invalid information!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  content: const Text(
                                    "Please verify your mission information",
                                    textAlign: TextAlign.justify,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Color(0xff96BAFF)),
                      child: Text(
                        'Add the mission',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),

                  //  Text('${mytext}')
                ],
              ),
            ),
          ),
          //Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
