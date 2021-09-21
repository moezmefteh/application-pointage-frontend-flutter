import 'package:pointage/feedback/app_theme.dart';
import 'package:pointage/feedback/feedback_screen.dart';
import 'package:pointage/startone/loginPage.dart';
import 'package:flutter/material.dart';

class AppDrawerchef extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          ListTile(
            selected: true,
            title: Row(
              children: <Widget>[
                Icon(Icons.home),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Home"),
                )
              ],
            ),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.feedback),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("FeedBack"),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen()));
            },
          ),
          ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.group_work),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("About US"),
                  )
                ],
              ),
              onTap: () {}
////////json            ,
              ),
          SizedBox(
            height: 340,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  return UserAccountsDrawerHeader(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color(0xff000000).withAlpha(20),
            offset: Offset(2, 4),
            blurRadius: 8,
            spreadRadius: 2)
      ],
    ),
    accountName: Text(
      '${data1_}',
      style: TextStyle(color: Colors.black),
    ),
    accountEmail: Text('${data3_}', style: TextStyle(color: Colors.black)),
    currentAccountPicture: CircleAvatar(
      backgroundColor: Colors.black,
      child: FlutterLogo(size: 42.0),
    ),
  );
}
