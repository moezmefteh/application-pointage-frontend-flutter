import 'package:pointage/startone/loginPage.dart';
import 'package:pointage/startone/welcomePage.dart';
import 'package:pointage/user_chef/ajpoutermission.dart';
import 'package:pointage/user_chef/homechef.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Missionschef extends StatefulWidget {
  const Missionschef({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Missionchef();
  }
}

class _Missionchef extends State<Missionschef> {
  final List<String> _items =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(0, nombreschef).split('').toList();

  @override
  void initState() {
    super.initState();
    importmissionschef();
  }

  Future<List> sendanulle(int j) async {
    importmissionschef();

    int h = datamissionchef[j]["id"];
    String url4 =
        'http://' + adressip + ':8000/api/mission/' + '${h}' + '/finish/';

    var response4 = await http.put(Uri.encodeFull(url4), headers: {
      "Accept": "application/json"
    }, body: {
      "description": (datamissionchef[j]["description"]).toString(),
      "date_debut": (datamissionchef[j]["date_debut"]).toString(),
      "date_fin": (datamissionchef[j]["date_fin"]).toString(),
      "lieu": (datamissionchef[j]["lieu"]).toString(),
      "etat": "droped",
      "user": data1_.toString()
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => homePagechef()),
        (Route<dynamic> route) => false);
  }

  Widget _annulebutton(int idstart) {
    return InkWell(
      onTap: () {
        sendanulle(idstart);
        importmissionschef();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePagechef()));
      },
      child: Container(
        width: 180.0,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Colors.grey),
        child: Text(
          'drop mission',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Future<List> sendfinish(int j) async {
    importmissionschef();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => homePagechef()),
        (Route<dynamic> route) => false);
    int h = datamissionchef[j]["id"];
    String url5 =
        'http://' + adressip + ':8000/api/mission/' + '${h}' + '/finish/';

    var response5 = await http.put(Uri.encodeFull(url5), headers: {
      "Accept": "application/json"
    }, body: {
      "description": (datamissionchef[j]["description"]).toString(),
      "date_debut": (datamissionchef[j]["date_debut"]).toString(),
      "date_fin": (datamissionchef[j]["date_fin"]).toString(),
      "lieu": (datamissionchef[j]["lieu"]).toString(),
      "etat": "finished",
      "user": data1_.toString()
    });
  }

  Widget _finishbutton(int idstart) {
    return InkWell(
      onTap: () {
        sendfinish(idstart);
        importmissionschef();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePagechef()));
      },
      child: Container(
        width: 180.0,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.red,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Colors.red),
        child: Text(
          'finish mission',
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
                                            datamissionchef[
                                                        _items.indexOf(item)]
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
                                            datamissionchef[
                                                        _items.indexOf(item)]
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
                                            datamissionchef[
                                                        _items.indexOf(item)]
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
                                            datamissionchef[_items
                                                    .indexOf(item)]["etat"]
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
                                            datamissionchef[_items
                                                    .indexOf(item)]["lieu"]
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
                              if (datamissionchef[_items.indexOf(item)]["etat"]
                                      .toString() ==
                                  'started')
                                _finishbutton(_items.indexOf(item)),
                              if (datamissionchef[_items.indexOf(item)]["etat"]
                                      .toString() ==
                                  'waited')
                                _annulebutton(_items.indexOf(item))
                            ],
                          ),
                        )))),
          SizedBox(
            height: 50.0,
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ajoutmissionPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xff96BAFF),
      ),
    );
  }
}
