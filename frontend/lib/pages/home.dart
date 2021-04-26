import 'dart:async';

import 'package:LoginFlutter/api_provider.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './../colors/colors.dart';
import '../token_service.dart';
//import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  User user = new User();
  Future<User> ur;
  LocationUser loc;
  List u;
  Timer timer1;
  Timer timer2;
  ApiProvider apiProvider;

  @override
  void initState() {
    testtt();
    super.initState();
    timer1 = Timer.periodic(Duration(seconds: 15), (Timer t) => increase());
    timer2 = Timer.periodic(Duration(seconds: 30), (Timer t) => changeLoc());
  }

  @override
  void dispose() {
    timer1?.cancel();
    timer2?.cancel();
    super.dispose();
  }

  void increase() async {
    setState(() {
      loc.lat++;
      loc.lng++;
    });
    print("badellll");
    await apiProvider.updateLocation(loc, ApiProvider.addr);
  }

  void changeLoc() {
    print(loc.lat.toString() + " -- " + loc.lng.toString());
    print("tbadel.");
  }

  testtt() async {
    user = await user.getTokenData();

    apiProvider = ApiProvider();
    final ind = ApiProvider.addr;
    u = await apiProvider.nearby(ind, 30, 30, 20);
    //u = await apiProvider.getUsers(ind);
    print(user.id);
    setState(() {
      user = user;
      loc = user.location;
    });
  }

  @override
  Widget build(BuildContext context) {
    var nickname = user.nickname;
    return Scaffold(
        body: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                user.nickname.toString(),
                style: new TextStyle(
                    letterSpacing: 1.5, fontSize: 40, color: dark),
              ),
              Text(
                "lat  " + loc.lat.toString(),
                style: new TextStyle(
                    letterSpacing: 1.5, fontSize: 40, color: dark),
              ),
              Text(
                "lng  " + loc.lng.toString(),
                style: new TextStyle(
                    letterSpacing: 1.5, fontSize: 40, color: dark),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
