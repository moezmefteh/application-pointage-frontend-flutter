import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pointage/code_qr/scan.dart';
import 'package:pointage/reconaisance%20facial/pages/db/database.dart';
import 'package:pointage/reconaisance%20facial/pages/models/user.model.dart';
import 'package:pointage/reconaisance%20facial/pages/widgets/app_button.dart';
import 'package:pointage/reconaisance%20facial/services/camera.service.dart';
import 'package:pointage/reconaisance%20facial/services/facenet.service.dart';
import 'package:pointage/startone/loginPage.dart';
import 'package:pointage/startone/welcomePage.dart';
import 'package:pointage/user_employe/homeemplye.dart';
import 'package:flutter/material.dart';

class AuthActionButton extends StatefulWidget {
  AuthActionButton(this._initializeControllerFuture,
      {Key key, @required this.onPressed, @required this.isLogin, this.reload});
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;
  final Function reload;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  final FaceNetService _faceNetService = FaceNetService();
  final DataBaseService _dataBaseService = DataBaseService();
  final CameraService _cameraService = CameraService();

  User predictedUser;
  Future<List> modifData() async {
    String url2 = 'http://' + adressip + ':8000/update/' + '${data1_}' + '/';
    var response2 = await http.put(Uri.encodeFull(url2),
        headers: {"Accept": "application/json"},
        body: jsonEncode(<String, String>{
          "first_name": data6_,
          "last_name": data7_,
          "cin": data2_,
          "codeQR": data5_,
          "poste": data8_,
          "image": "saved",
          "email": data3_,
          "telephone": data4_
        }));
  }

  Future _signUp(context) async {
    /// gets predicted data from facenet service (user face detected)
    List predictedData = _faceNetService.predictedData;

    /// creates a new user in the 'database'
    await _dataBaseService.saveData(data1_, data0_, predictedData);
    data9_ = 'saved';

    /// resets the face stored in the face net sevice
    this._faceNetService.setPredictedData(null);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => homePage()));
  }

  Future _signIn(context) async {
    if (this.predictedUser.password == data0_) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => ScanPage()));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Wrong User!'),
          );
        },
      );
    }
  }

  String _predictUser() {
    String userAndPass = _faceNetService.predict();
    return userAndPass ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          // Ensure that the camera is initialized.
          await widget._initializeControllerFuture;
          // onShot event (takes the image and predict output)
          bool faceDetected = await widget.onPressed();

          if (faceDetected) {
            if (widget.isLogin) {
              var userAndPass = _predictUser();
              if (userAndPass != null) {
                this.predictedUser = User.fromDB(userAndPass);
              }
            }
            PersistentBottomSheetController bottomSheetController =
                Scaffold.of(context)
                    .showBottomSheet((context) => signSheet(context));

            bottomSheetController.closed.whenComplete(() => widget.reload());
          }
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xff7C83FD).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CAPTURE',
              style: TextStyle(fontSize: 20, color: Color(0xff0A043C)),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.camera_alt, color: Color(0xff0A043C))
          ],
        ),
      ),
    );
  }

  signSheet(context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isLogin && predictedUser != null
              ? Container()
              : widget.isLogin
                  ? Container(
                      child: Text(
                      'User not found 😞',
                      style: TextStyle(fontSize: 20, color: Color(0xff0A043C)),
                    ))
                  : Container(),
          Container(
            child: Column(
              children: [
                !widget.isLogin ? Container() : Container(),
                SizedBox(height: 10),
                widget.isLogin && predictedUser == null
                    ? Container()
                    : Container(),
                widget.isLogin && predictedUser != null
                    ? predictedUser.user == data1_
                        ? AppButton(
                            text: 'CONTINUE',
                            onPressed: () async {
                              _signIn(context);
                            },
                            icon: Icon(
                              Icons.login,
                              color: Color(0xff0A043C),
                            ),
                          )
                        : Container(
                            child: Text('You are an other User 😞',
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff0A043C))))
                    : !widget.isLogin
                        ? AppButton(
                            text: 'ADD YOUR FACE',
                            onPressed: () async {
                              await _signUp(context);
                              await modifData();
                            },
                            icon: Icon(
                              Icons.person_add,
                              color: Color(0xff0A043C),
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
