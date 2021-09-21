import 'dart:convert';

import 'package:pointage/startone/loginPage.dart';
import 'package:pointage/startone/welcomePage.dart';
import 'package:pointage/user_employe/pointagesemplye.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'missionsemplye.dart';
import 'profileemplye.dart';
import 'draweremploye.dart';
import 'package:http/http.dart' as http;

var datamission, datapointages, datasalaires;
int nombres, nombrespointages, nombressalaires;
const _kPages = <String, IconData>{
  'missions': Icons.task,
  'informations': Icons.home,
  'travail': Icons.location_on,
};
Future<List> importsalaires() async {
  String urlsalaires =
      'http://' + adressip + ':8000/api/salaires/' + '${data1_}' + '/';
  var responsesalaires = await http.get(Uri.encodeFull(urlsalaires),
      headers: {"Accept": "application/json"});
  datasalaires = (json.decode(responsesalaires.body));
  nombressalaires = (datasalaires).length;
}

Future<List> importmissions() async {
  String urlmissions =
      'http://' + adressip + ':8000/api/missions/' + '${data1_}' + '/';
  var responsemissions = await http.get(Uri.encodeFull(urlmissions),
      headers: {"Accept": "application/json"});
  datamission = (json.decode(responsemissions.body));
  nombres = (datamission).length;
}

Future<List> importpointages() async {
  String urlpointages =
      'http://' + adressip + ':8000/api/pointages/' + '${data1_}' + '/';
  var responsepointages = await http.get(Uri.encodeFull(urlpointages),
      headers: {"Accept": "application/json"});
  datapointages = (json.decode(responsepointages.body));
  nombrespointages = (datapointages).length;
}

class homePage extends StatefulWidget {
  homePage({Key key}) : super(key: key);

  @override
  _Homeuser createState() => _Homeuser();
}

class _Homeuser extends State<homePage> {
  TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  Widget build(BuildContext context) {
    importmissions();
    importpointages();
    importsalaires();

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
                        Taches()
                      else if (icon == 'missions')
                        Missions()
                      else if (icon == 'informations')
                        Profile()
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
      drawer: AppDrawer(),
    );
  }
}
