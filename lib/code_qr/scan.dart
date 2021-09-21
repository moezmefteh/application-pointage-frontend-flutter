import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:pointage/startone/welcomePage.dart';
import '/startone/loginPage.dart';
import '/user_employe/homeemplye.dart';
import 'package:http/http.dart' as http;

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult;

  bool backCamera = true;

  var trouve = 0;

  int camera = 1;

  finish() {
    if (DateTime.now().hour.toInt() < 14) {
      sendpointage();
      importpointages();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homePage()));
    } else if ((DateTime.now().hour.toInt() < 15) &&
        (DateTime.now().minute.toInt() < 30)) {
      importpointages();
      sendpointageavecretard();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homePage()));
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('invalid pointed!',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text(
            "You exceeded the delay limit. You are absent",
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => homePage())),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<List> sendpointageavecretard() async {
    String url4 = 'http://' + adressip + ':8000/api/pointages/list/';

    var response4 = await http.post(Uri.encodeFull(url4), headers: {
      "Accept": "application/json"
    }, body: {
      "entre": DateTime.now().hour.toString() +
          ':' +
          DateTime.now().minute.toString(),
      "sortie": "13:00",
      "date": DateTime.now().day.toString() +
          '/' +
          DateTime.now().month.toString() +
          '/' +
          DateTime.now().year.toString(),
      "retard": DateTime.now().minute.toString() + 'minutes',
      "absance": "Non",
      "user": data1_.toString()
    });
  }

  Future<List> sendpointage() async {
    String url4 = 'http://' + adressip + ':8000/api/pointages/list/';

    var response4 = await http.post(Uri.encodeFull(url4), headers: {
      "Accept": "application/json"
    }, body: {
      "entre": DateTime.now().hour.toString() +
          ':' +
          DateTime.now().minute.toString(),
      "sortie": "13:00",
      "date": DateTime.now().day.toString() +
          '/' +
          DateTime.now().month.toString() +
          '/' +
          DateTime.now().year.toString(),
      "retard": "Pas de retard",
      "absance": "Non",
      "user": data1_.toString()
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'pointage',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                        Icon(Icons.qr_code,
                            size: 45.0, color: Color(0xff0A043C)),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Get QR code",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 80.0,
                        ),
                        _scanButton(),
                        SizedBox(
                          height: 70.0,
                        ),
                        Center(
                          child: Text(
                            (qrCodeResult != data5_) || (qrCodeResult == "")
                                ? "Please Scan your codeQR"
                                : "",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w900),
                          ),
                        ),
                        Center(
                          child: Text(
                            (qrCodeResult == data5_.toString())
                                ? "Right codeQR"
                                : "",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        Text("You can Check your camera at first !",
                            style: new TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 20.0,
                        ),
                        _choixCam(),
                      ])),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff0A043C), // background
                                  ),
                                  onPressed: (qrCodeResult != data5_)
                                      ? null
                                      : () => setState(() => finish()),
                                  child: const Text('MAKE POINTED'),
                                ),
                              ])),
                    ]))));
  }

  Widget _choixCam() {
    return InkWell(
        onTap: () {
          setState(() {
            backCamera = !backCamera;
            camera = backCamera ? 1 : -1;
          });
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: Wrap(children: <Widget>[
            Text(
              (backCamera ? "Front Cam" : "Back Cam"),
              style: TextStyle(fontSize: 20, color: Color(0xff0A043C)),
            ),
          ]),
        ));
  }

  Widget _scanButton() {
    return InkWell(
      onTap: () async {
        ScanResult codeSanner = await BarcodeScanner.scan(
          options: ScanOptions(
            useCamera: camera,
          ),
        ); //barcode scnner
        setState(() {
          qrCodeResult = codeSanner.rawContent;
        });
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
          'Scan your QR code',
          style: TextStyle(fontSize: 20, color: Color(0xff7C83FD)),
        ),
      ),
    );
  }
}
