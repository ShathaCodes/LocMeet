import 'package:flutter/material.dart';
import './../colors/colors.dart';
import '../pages/register.dart';
import '../pages/login.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginFlutter',
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
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: heigth / 14, left: width / 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    'assets/images/faza.png',
                    scale: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: heigth / 10 - 20,
                top: heigth / 10 - 45,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "LocMeet",
                    style: new TextStyle(
                        fontFamily: 'Mont', fontSize: 25, color: kohl),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: heigth / 10 - 25,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "I'll meet you in real life.",
                    style: new TextStyle(
                        fontFamily: 'Mont', fontSize: 15, color: kohl),
                  ),
                ],
              ),
            ),
            Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 175,
                  ),
                  Container(
                    height: heigth / 3 + 38.5,
                    width: width,
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23)),
                    ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/images/friends.png',
                        scale: 2.3,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width / 7, 20, width / 7, 0),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: kohl,
                          primaryColorDark: darkred,
                        ),
                        child: ButtonTheme(
                          minWidth: width,
                          height: 50.0,
                          child: RaisedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register())),
                              child: const Text('REGISTER',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'calibre',
                                      letterSpacing: 1.5,
                                      fontSize: 20)),
                              color: blue,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width / 7, 20, width / 7, 0),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: kohl,
                          primaryColorDark: darkred,
                        ),
                        child: ButtonTheme(
                          minWidth: width,
                          height: 50.0,
                          child: RaisedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login())),
                              child: const Text('LOGIN',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kohl,
                                      fontFamily: 'calibre',
                                      letterSpacing: 1.5,
                                      fontSize: 20)),
                              color: Colors.white,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
