import 'package:camera/camera.dart';
import 'package:pointage/reconaisance%20facial/pages/db/database.dart';
import 'package:pointage/reconaisance%20facial/pages/sign-up.dart';
import 'package:pointage/reconaisance%20facial/services/facenet.service.dart';
import 'package:pointage/reconaisance%20facial/services/ml_kit_service.dart';
import 'package:pointage/startone/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homeemplye.dart';

CameraDescription cameraDescription;

class Taches extends StatefulWidget {
  Taches({Key key}) : super(key: key);
  @override
  _Taches createState() => _Taches();
}

class _Taches extends State<Taches> {
  final List<String> _itemspointages = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      .substring(0, nombrespointages)
      .split('')
      .toList();

  @override
  void initState() {
    super.initState();
    importpointages();
    _startUp();
  }

  FaceNetService _faceNetService = FaceNetService();
  MLKitService _mlKitService = MLKitService();
  DataBaseService _dataBaseService = DataBaseService();

  bool loading = false;

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face net model
  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlKitService.initialize();

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
            child: SafeArea(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
              Column(children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data9_.toString() == "saved"
                              ? Column(children: [
                                  for (final itempointage in _itemspointages)
                                    Center(
                                        child: Card(
                                            margin: EdgeInsets.fromLTRB(
                                                0.0, 38.0, 0.0, 0.0),
                                            child: Container(
                                                width: 350.0,
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 90.0,
                                                            ),
                                                            Icon(
                                                              Icons.date_range,
                                                              color: Colors
                                                                      .blueGrey[
                                                                  300],
                                                              size: 25,
                                                            ),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Pointage ' +
                                                                      (_itemspointages.indexOf(itempointage) +
                                                                              1)
                                                                          .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'roboto',
                                                                    color: Colors
                                                                            .blueGrey[
                                                                        300],
                                                                    fontSize:
                                                                        24.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        Divider(
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Entry time: ' +
                                                                      datapointages[
                                                                              _itemspointages.indexOf(itempointage)]
                                                                          [
                                                                          "entre"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.0,
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Exit time: ' +
                                                                      datapointages[
                                                                              _itemspointages.indexOf(itempointage)]
                                                                          [
                                                                          "sortie"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.0,
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Check-in time : ' +
                                                                      datapointages[
                                                                              _itemspointages.indexOf(itempointage)]
                                                                          [
                                                                          "date"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.0,
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Dealy time: ' +
                                                                      datapointages[
                                                                              _itemspointages.indexOf(itempointage)]
                                                                          [
                                                                          "retard"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.0,
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Absence: ' +
                                                                      datapointages[
                                                                              _itemspointages.indexOf(itempointage)]
                                                                          [
                                                                          "absance"],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                      ],
                                                    ))))),
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                ])
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignUp(
                                          cameraDescription: cameraDescription,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.grey.shade200,
                                              offset: Offset(2, 4),
                                              blurRadius: 5,
                                              spreadRadius: 2)
                                        ],
                                        color: Color(0xff96BAFF)),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Check your face only one time',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.person_add,
                                            color: Colors.white)
                                      ],
                                    ),
                                  ),
                                )
                        ]))
              ])
            ])))));
  }
}
