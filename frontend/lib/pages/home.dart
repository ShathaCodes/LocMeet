import 'package:LoginFlutter/api_provider.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:flutter/material.dart';
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
  List u;

  @override
  void initState() {
    testtt();
    super.initState();
  }

  testtt() async {
    user.getTokenData();
    ApiProvider apiProvider = ApiProvider();
    final ind = ApiProvider.addr;
    //u = await apiProvider.nearby(ind, 15, 20, 100);
    u = await apiProvider.getUsers(ind);
    setState(() {
      user = user;
      u = u;
    });
    print(u);
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
            children: <Widget>[],
          )
        ],
      ),
    ));
  }
}
