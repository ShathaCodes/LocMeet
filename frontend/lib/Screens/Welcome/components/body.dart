import 'package:LoginFlutter/Screens/Login/login_screen.dart';
import 'package:LoginFlutter/Screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:LoginFlutter/Screens/Welcome/components/background.dart';
import 'package:LoginFlutter/components/rounded_button.dart';
import 'package:LoginFlutter/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: height / 14, left: width / 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset('assets/images/logoPalette.png',
                        scale: width * 0.008),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: height / 10 - 25,
                  top: height / 10 - 45,
                ),
                child: Row(
                  children: <Widget>[
                    Text("LocMeet",
                        style: new TextStyle(
                            fontFamily: 'Mont',
                            fontSize: 25,
                            color: Colors.black54)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: height / 10 - 25,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      "I'll meet you in real life.",
                      style: new TextStyle(
                          fontFamily: 'Mont',
                          fontSize: 15,
                          color: Colors.black54),
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
                      height: height / 3 + 38.5,
                      width: width,
                      decoration: BoxDecoration(
                        // color: jaunepastel,
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
                          'assets/images/friendsN.png',
                          scale: width * 0.00205,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(width / 7, 20, width / 7, 0),
                        child: RoundedButton(
                            text: "SIGN UP",
                            color: blue_base,
                            textColor: jaunepastel,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SignUpScreen();
                                  },
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(width / 7, 20, width / 7, 0),
                        child: RoundedButton(
                          text: "LOGIN",
                          color: jaunepastel,
                          textColor: blue_base,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
