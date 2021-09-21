import 'package:camera/camera.dart';
import 'package:pointage/reconaisance%20facial/pages/db/database.dart';
import 'package:pointage/reconaisance%20facial/pages/sign-in.dart';
import 'package:pointage/reconaisance%20facial/services/facenet.service.dart';
import 'package:pointage/reconaisance%20facial/services/ml_kit_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:url_launcher/url_launcher.dart';

class Locate extends StatefulWidget {
  // location
  @override
  _LocateState createState() => _LocateState();
}

class _LocateState extends State<Locate> {
  var locationMessage = '';
  String latitude;
  String longitude;

  int trouve = 0;
  FaceNetService _faceNetService = FaceNetService();
  MLKitService _mlKitService = MLKitService();
  DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

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

  // function for getting the current location
  // but before that you need to add this permission!
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";

    setState(() {
      if (lat >= 33.7970 && lat <= 35.7975 && long >= 9.7660 && long <= 11.7665)
        setState(() {
          this.trouve = 1;
          locationMessage = "Valid Location";
        });
      else {
        setState(() {
          this.trouve = 0;
          locationMessage = "Wrong Location";
        });
      }
    });
  }

  // function for opening it in google maps

  void googleMap() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");
  }

  Widget _locateButton() {
    return InkWell(
      onTap: () {
        getCurrentLocation();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
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
        child: Text(
          'Get your location',
          style: TextStyle(fontSize: 20, color: Color(0xff7C83FD)),
        ),
      ),
    );
  }

  Widget _mapButton() {
    return InkWell(
      onTap: () {
        googleMap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Text(
          'Open Google maps',
          style: TextStyle(fontSize: 20, color: Color(0xff0A043C)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                    SizedBox(
                      height: 100.0,
                    ),
                    Icon(Icons.location_on,
                        size: 45.0, color: Color(0xff0A043C)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Get User Location",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    _locateButton(),
                    SizedBox(
                      height: 80.0,
                    ),
                    Text(
                      locationMessage,
                      style: TextStyle(fontSize: 20, color: Color(0xff0A043C)),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    new Text('You can check your location at first !',
                        style: new TextStyle(color: Colors.white)),
                    SizedBox(
                      height: 20.0,
                    ),
                    _mapButton(),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    // button for taking the location
                  ])),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff0A043C).withOpacity(0.6),
                                  onPrimary: Colors.white38,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: this.trouve == 1
                                    ? null
                                    : () => setState(
                                          () => {Navigator.pop(context)},
                                        ),
                                child: const Text('BACK')),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff0A043C), // background
                              ),
                              onPressed: this.trouve == 0
                                  ? null
                                  : () => setState(() => movereconaisance()),
                              child: const Text('NEXT'),
                            ),
                          ])),
                ])));

    //floatingActionButton: ElevatedButton(
    //  style: ElevatedButton.styleFrom(
    //    primary: Color(0xff0A043C), // background
    //  ),
    //   onPressed: this.trouve == 0
    //      ? null
    //      : () => setState(() => movereconaisance()),
    //  child: const Text('NEXT'),
    //));
  }

  movereconaisance() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignIn(
            cameraDescription: cameraDescription,
          ),
        ));
  }
}
