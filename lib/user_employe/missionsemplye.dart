import 'dart:convert';

import 'package:pointage/startone/loginPage.dart';
import 'package:pointage/startone/welcomePage.dart';
import 'package:pointage/user_employe/homeemplye.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Missions extends StatefulWidget {
  const Missions({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Mission();
  }
}

class _Mission extends State<Missions> {
  @override
  void initState() {
    super.initState();
    importmissions();
    importpointages();
  }

  final List<String> _items =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(0, nombres).split('').toList();

  Future<List> sendstart(int j) async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => homePage()),
        (Route<dynamic> route) => false);
    int h = datamission[j]["id"];
    String url4 =
        'http://' + adressip + ':8000/api/mission/' + '${h}' + '/start/';

    var response4 = await http.put(Uri.encodeFull(url4), headers: {
      "Accept": "application/json"
    }, body: {
      "description": (datamission[j]["description"]).toString(),
      "date_debut": (datamission[j]["date_debut"]).toString(),
      "date_fin": (datamission[j]["date_fin"]).toString(),
      "lieu": (datamission[j]["lieu"]).toString(),
      "etat": "started",
      "user": data1_.toString()
    });
  }

  Widget _sartedbutton(int istart) {
    return InkWell(
      onTap: () {
        sendstart(istart);
        importmissions();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePage()));
      },
      child: Container(
        width: 180.0,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.green,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Colors.green),
        child: Text(
          'Start the mission',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
            child: Column(
          children: [
            for (final item in _items)
              Center(
                  child: Card(
                      margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                      child: Container(
                          width: 350.0,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Mission $item',
                                    style: TextStyle(
                                      fontFamily: 'roboto',
                                      color: Colors.blueGrey[300],
                                      fontSize: 24.0,
                                    )),
                                Divider(
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.description,
                                      color: Colors.blueGrey[300],
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Description: ' +
                                              datamission[_items.indexOf(item)]
                                                      ["description"]
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.blueGrey[300],
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Started day: ' +
                                              datamission[_items.indexOf(item)]
                                                      ["date_debut"]
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.blueGrey[300],
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Last day: ' +
                                              datamission[_items.indexOf(item)]
                                                      ["date_debut"]
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.ev_station,
                                      color: Colors.blueGrey[300],
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Etat :' +
                                              datamission[_items.indexOf(item)]
                                                      ["etat"]
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.place,
                                      color: Colors.blueGrey[300],
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'The place: ' +
                                              datamission[_items.indexOf(item)]
                                                      ["lieu"]
                                                  .toString(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (datamission[_items.indexOf(item)]["etat"]
                                        .toString() ==
                                    'waited')
                                  _sartedbutton(_items.indexOf(item)),
                              ],
                            ),
                          )))),
            SizedBox(
              height: 50.0,
            ),
          ],
        )));
  }
}
