import 'dart:convert';

import 'package:pointage/startone/welcomePage.dart';
import 'package:pointage/user_chef/missionschef.dart';
import 'package:pointage/user_chef/profilechef.dart';
import 'package:pointage/user_chef/tacheschef.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:http/http.dart' as http;

import 'drawerchef.dart';

var datamissionchef, datapointageschef;
int nombreschef, nombrespointageschef;
const _kPages = <String, IconData>{
  'missions': Icons.task,
  'informations': Icons.home,
  'travail': Icons.location_on,
};
Future<List> importmissionschef() async {
  String url = 'http://' + adressip + ':8000/api/missions/list/';
  print(url);
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  datamissionchef = (json.decode(response.body));
  nombreschef = (datamissionchef).length;
}

Future<List> importpointageschef() async {
  String url2 = 'http://' + adressip + ':8000/api/pointages/list/';
  print(url2);
  var response2 = await http
      .get(Uri.encodeFull(url2), headers: {"Accept": "application/json"});
  datapointageschef = (json.decode(response2.body));
  nombrespointageschef = (datapointageschef).length;
}

class homePagechef extends StatefulWidget {
  homePagechef({Key key}) : super(key: key);

  @override
  _Homechef createState() => _Homechef();
}

class _Homechef extends State<homePagechef> {
  TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  Widget build(BuildContext context) {
    importmissionschef();
    importpointageschef();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_open_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
            color: Colors.black,
          ),
        ),
        // actions: [
        //   new Image.asset('images/logo.png', width: 120),
        // ],
        backgroundColor: Colors.grey[200],

        elevation: 0,
        centerTitle: false,
      ),
      body: new Container(
          child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    for (final icon in _kPages.keys)
                      if (icon == 'travail')
                        Tacheschef()
                      else if (icon == 'missions')
                        Missionschef()
                      else if (icon == 'informations')
                        Profilechef()
                  ],
                ),
              ),
            ],
          ),

          /// on peut ajouter le numero des missions afair grace aux .badge
          bottomNavigationBar: ConvexAppBar(
            style: _tabStyle,
            backgroundColor: Color(0xff8FB1E9),
            items: <TabItem>[
              TabItem(icon: Icons.dashboard),
              TabItem(icon: Icons.home),
              TabItem(icon: Icons.location_on),
            ],
          ),
        ),
      )),
      drawer: AppDrawerchef(),
    );
  }
}
