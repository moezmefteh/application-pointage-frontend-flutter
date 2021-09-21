import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

String adressip = '192.168.1.9';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

List<MaterialColor> colorizeColors = [
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.purple,
];

const colorizeTextStyle = TextStyle(
  fontSize: 40.0,
  fontFamily: 'SF',
);

class _WelcomePageState extends State<WelcomePage> {
  Widget _colorize() {
    return SizedBox(
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Check account',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'Pointage App',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              "Le menuisier",
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 10),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage())));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff88FFF7), Color(0xff96BAFF)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_colorize()],
          ),
        ),
      ),
    );
  }
}
