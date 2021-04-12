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
  var nickname;
  var intrest;

  @override
  void initState() {
    getTokenData();
    super.initState();
  }

  getTokenData() async {
    setState(() {
      TokenService tokenService = new TokenService();
      tokenService.getDecodedToken().then((decodedToken) => {
            this.nickname = decodedToken["nickname"],
          });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                ' Hello $nickname !',
                style: TextStyle(color: dark, fontFamily: 'Mont', fontSize: 25),
              )
            ],
          )
        ],
      ),
    ));
  }
}
