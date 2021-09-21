import 'package:pointage/user_employe/homeemplye.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Salaires extends StatefulWidget {
  const Salaires({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _salaires();
  }
}

class _salaires extends State<Salaires> {
  final List<String> _itemssalaires =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
          .substring(0, nombressalaires)
          .split('')
          .toList();
  void setState(VoidCallback fn) {
    setState(() {
      importsalaires();
    });
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
            child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                      child:
                          Icon(Icons.keyboard_arrow_left, color: Colors.black),
                    ),
                    Text('Back',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            for (final itemsalaires in _itemssalaires)
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
                                Text(
                                    'Salary ' +
                                        (_itemssalaires.indexOf(itemsalaires) +
                                                1)
                                            .toString(),
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Month: ' +
                                              datasalaires[
                                                      _itemssalaires.indexOf(
                                                          itemsalaires)]["mois"]
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hours of work: ' +
                                              datasalaires[_itemssalaires
                                                          .indexOf(
                                                              itemsalaires)]
                                                      ["heurs_base"]
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Other hours: ' +
                                              datasalaires[_itemssalaires
                                                          .indexOf(
                                                              itemsalaires)]
                                                      ["heurs_sup"]
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Primes :' +
                                              datasalaires[_itemssalaires
                                                          .indexOf(
                                                              itemsalaires)]
                                                      ["prime"]
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total: ' +
                                              datasalaires[_itemssalaires
                                                          .indexOf(
                                                              itemsalaires)]
                                                      ["total"]
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
                                  height: 10,
                                ),
                              ],
                            ),
                          )))),
            SizedBox(
              height: 50.0,
            ),
          ],
        )));
  }
}
