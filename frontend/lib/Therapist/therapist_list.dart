//import 'package:LoginFlutter/colors/colors.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/therapist.dart';
import 'package:flutter/material.dart';

import '../api_provider.dart';

class TherapistList extends StatefulWidget {
  @override
  _TherapistListState createState() => _TherapistListState();
}

class _TherapistListState extends State<TherapistList> {
  ApiProvider apiProvider = ApiProvider();
  final ind = ApiProvider.addr;

  List therapists;

  Future initialize() async {
    therapists = await apiProvider.getTherapists(ApiProvider.addr);
    setState(() {
      therapists = therapists;
    });
  }

  @override
  initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: Column(children: <Widget>[
        if (therapists != null)
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: therapists.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: heigth,
                    width: width,
                    padding: EdgeInsets.fromLTRB(
                        heigth / 80, heigth / 80, heigth / 80, heigth / 80),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: (heigth / 30).round(),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topLeft,
                                  colors: [
                                    jaunepastel,
                                    blue_base,
                                  ],
                                )),
                                child: Column(children: [
                                  SizedBox(
                                    height: heigth / 50,
                                  ),
                                  CircleAvatar(
                                    radius: heigth / 12,
                                    backgroundImage:
                                        AssetImage('assets/images/girl.png'),
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    height: heigth / 100,
                                  ),
                                  SizedBox(
                                    width: heigth / 100,
                                  ),
                                  Text(
                                    therapists[index].name,
                                  ),
                                  SizedBox(
                                    height: heigth / 250,
                                  ),
                                  Center(
                                      child: Text(
                                    "gratuadet in france Paris",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  )),
                                  /*Center(
                                      child: Text(
                                    therapists[index].description,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  )),*/
                                ]),
                              ),
                            ),
                            Expanded(
                              flex: (heigth / 25).round(),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topLeft,
                                  colors: [
                                    jaunepastel,
                                    jaunepastel,
                                  ],
                                )),
                                //color: Colors.grey[200],
                                child: Center(
                                    child: Card(
                                        //color: Colors.grey[100],
                                        //margin: EdgeInsets.fromLTRB( 0.0, 45.0, 0.0, 0.0),
                                        child: Container(
                                            width: width / 1.5,
                                            height: heigth / 2,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(heigth / 40),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Divider(
                                                    color: Colors.grey[300],
                                                  ),
                                                  SizedBox(
                                                    height: heigth / 50, //10.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        color: blue_base,
                                                        size: heigth / 22,
                                                      ),
                                                      SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      SizedBox(
                                                        height: heigth / 50,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Phone",
                                                            style: TextStyle(
                                                              fontSize: 15.0,
                                                              //color: blue_dark,
                                                            ),
                                                          ),
                                                          Text(
                                                            therapists[index]
                                                                .number
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .grey[400],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: heigth / 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.home,
                                                        color: blue_base,
                                                        size: heigth / 22,
                                                      ),
                                                      SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      SizedBox(
                                                        height: heigth / 50,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Adresse",
                                                            style: TextStyle(
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            therapists[index]
                                                                .location,
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .grey[400],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: heigth / 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.mail,
                                                        color: blue_base,
                                                        size: heigth / 22,
                                                      ),
                                                      SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      SizedBox(
                                                        height: heigth / 50,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Email",
                                                            style: TextStyle(
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            therapists[index]
                                                                .email,
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .grey[400],
                                                            ),
                                                          )
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
                            top: heigth * 0.28,
                            left: width / 20,
                            right: width / 20,
                            child: Card(
                                child: Padding(
                              padding: EdgeInsets.all(heigth / 100),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      child: Column(
                                    children: [
                                      Text(
                                        'Battles',
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14.0),
                                      ),
                                      SizedBox(
                                        height: heigth / 200,
                                      ),
                                      FloatingActionButton(
                                        backgroundColor: jaunepastel,
                                        onPressed: () {
                                          // _getCurrentUserLocation();
                                        },
                                        child: Container(
                                          child: Icon(Icons.search,
                                              color: blue_base,
                                              size: heigth / 22),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                                  Container(
                                    child: Column(children: [
                                      Text(
                                        'Birthday',
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14.0),
                                      ),
                                      SizedBox(
                                        height: heigth / 200,
                                      ),
                                      FloatingActionButton(
                                        backgroundColor: jaunepastel,
                                        onPressed: () {
                                          // _getCurrentUserLocation();
                                        },
                                        child: Container(
                                          child: Icon(Icons.phone,
                                              color: blue_base,
                                              size: heigth / 22),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            )))
                      ],
                    ),
                  );
                }),
          ),
      ]),
    );
  }
}
