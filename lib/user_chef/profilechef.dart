import 'package:pointage/startone/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profilechef extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors: [Colors.deepPurple[800], Colors.deepPurpleAccent],
                  //   ),
                  // ),

                  child: Column(children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      // backgroundImage: AssetImage('assets/erza.jpg'),
                      backgroundColor: Colors.blueGrey[300],
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text('${data1_}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        )),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      '${data8_}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ]),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Center(
                      child: Card(
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                          child: Container(
                              width: 310.0,
                              height: 210.0,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Information",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey[300],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.blueGrey[300],
                                          size: 35,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${data1_}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: Colors.blueGrey[300],
                                          size: 35,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${data3_}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.blueGrey[300],
                                          size: 35,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${data4_}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )))),
                ),
              ),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.28,
              left: 20.0,
              right: 20.0,
              child: Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Text(
                          'Profil',
                          style: TextStyle(
                              color: Colors.grey[900], fontSize: 14.0),
                        ),
                      ],
                    )),
                    Container(
                      child: Column(children: [
                        Text(
                          'First Name',
                          style: TextStyle(
                              color: Color(0xff8FB1E9), fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '${data6_}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        )
                      ]),
                    ),
                    Container(
                        child: Column(
                      children: [
                        Text(
                          'Last name',
                          style: TextStyle(
                              color: Color(0xff8FB1E9), fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '${data7_}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              )))
        ],
      ),
    );
  }
}
