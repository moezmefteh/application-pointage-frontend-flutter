import 'package:pointage/startone/welcomePage.dart';
import 'package:pointage/user_chef/homechef.dart';
import 'package:pointage/user_employe/homeemplye.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Widget/bezierContainer.dart';

final passwordController = TextEditingController();
final userController = TextEditingController();

String data0_,
    data1_,
    data2_,
    data3_,
    data4_,
    data5_,
    data6_,
    data7_,
    data8_,
    data9_;

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var data;

  Future<List> getdata() async {
    String url6 = 'http://' + adressip + ':8000/login/';
    var response6 = await http.post(Uri.encodeFull(url6), headers: {
      "Accept": "application/json"
    }, body: {
      "username": userController.text.toString(),
      "password": passwordController.text.toString()
    });
    data = (json.decode(response6.body));
    print(data["jwt"]);
    if (data["jwt"] != null) {
      data1_ = userController.text;
      data2_ = data["data"]["cin"].toString();
      data0_ = passwordController.text;
      data3_ = data["data"]["email"].toString();
      data4_ = data["data"]["telephone"].toString();
      data5_ = data["data"]["codeQR"].toString();
      data6_ = data["data"]["first_name"].toString();
      data7_ = data["data"]["last_name"].toString();
      data8_ = data["data"]["poste"].toString();
      data9_ = data["data"]["image"].toString();
      if (data["data"]["poste"] == "employe") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePage()));
        userController.clear();
        passwordController.clear();
      } else if (data["data"]["poste"] == "chef chantier") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePagechef()));
        userController.clear();
        passwordController.clear();
      }
    } else {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('invalid account!',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                content: const Text(
                  "This user is not associated with an account. Find your account and login.",
                  textAlign: TextAlign.justify,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ));
      passwordController.clear();
    }
    //  return List<Map<String, dynamic>>.from(json.decode(response.body));
  }

  Widget _entryFieldUser(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: userController,
              decoration: InputDecoration(
                  hintText: 'Enter your user name',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryFieldPass(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
            child: CircleAvatar(
                radius: 22.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('images/instagram.png'))),
        new Container(
            child: CircleAvatar(
                radius: 22.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('images/facebook.png'))),
        new Container(
            child: CircleAvatar(
                radius: 22.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('images/linkedin.png'))),
      ],
    ));
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldUser(
          "User",
        ),
        _entryFieldPass("Password", isPassword: true),
      ],
    );
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
                  SizedBox(height: height * .2),
                  new Image.asset('images/logo.png', width: 140),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      getdata();
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
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  _divider(),
                  _facebookButton(),
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
