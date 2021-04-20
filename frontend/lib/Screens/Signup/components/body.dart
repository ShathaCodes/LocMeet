import 'package:flutter/material.dart';
import 'package:LoginFlutter/Screens/Login/login_screen.dart';
import 'package:LoginFlutter/Screens/Signup/components/background.dart';
import 'package:LoginFlutter/Screens/Signup/components/or_divider.dart';
import 'package:LoginFlutter/components/already_have_an_account_acheck.dart';
import 'package:LoginFlutter/components/rounded_button.dart';
import 'package:LoginFlutter/components/rounded_input_field.dart';
import 'package:LoginFlutter/components/rounded_password_field.dart';
import 'package:LoginFlutter/constants.dart';

import '/home.dart';
import '/api_provider.dart';
import '/pages/login.dart';
import 'dart:async';
import '/pages/filterChip.dart';

class Body extends StatefulWidget {
  @override
  BodyState createState() {
    return new BodyState();
  }
}

class BodyState extends State<Body> {
  TextEditingController _crtlNickname = TextEditingController();
  TextEditingController _crtlPassword = TextEditingController();
  //TextEditingController _ctrlIp = TextEditingController();
  final success = SnackBar(content: Text('Login succeded!'));
  final error = SnackBar(content: Text('Wrong credentials!'));
  final serverError = SnackBar(content: Text('Can\'t connect to the server!'));
  final ipError =
      SnackBar(content: Text('You must insert an IP! Go to settings'));

  final _formKey = GlobalKey<FormState>();

  ApiProvider apiProvider = ApiProvider();

  Future doRegistration() async {
    //final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it does not exist, return 0.
    final ind = ApiProvider.addr;
    if (_formKey.currentState.validate()) {
      if (ind != "") {
        try {
          var res = await apiProvider.doRegistration(
              _crtlNickname.text, _crtlPassword.text, ind, sth);
          if (res.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(success);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          } else {
            print(res.statusCode);
            ScaffoldMessenger.of(context).showSnackBar(error);
          }
        } catch (err) {
          print(err);
          ScaffoldMessenger.of(context).showSnackBar(serverError);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(ipError);
    }
  }

  List sth; //choosenInterest
  List interests;

  Future initialize() async {
    interests = [];
    sth = List();
    //List();
    interests = await apiProvider.getInterests(ApiProvider.addr);
    setState(() {
      interests = interests;
    });
  }

  @override
  initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: blue_dark, fontSize: 18),
            ),
            SizedBox(height: size.height * 0.03),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: Image.asset(
                    "assets/images/logoPalette.png",
                    width: size.width * 0.3,
                  ),
                ),
              ],
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            SizedBox(height: size.height * 0.03),
            Center(
              child: Text(
                "Your interestes",
                textAlign: TextAlign.left,
                style: TextStyle(color: blue_base, fontSize: 18),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Center(
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration:
                          myBoxDecoration(), //             <--- BoxDecoration here
                      child: Container(
                          child: Wrap(
                        spacing: 16.0,
                        runSpacing: 4.0,
                        children: <Widget>[
                          for (int i = 0; i < interests.length; i++)
                            filterChipWidget(
                              chipName: interests[i].name,
                              id: interests[i].id,
                              sth: sth,
                            )
                        ],
                      )),
                    ))),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            // SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            OrDivider(),

            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",

                  // press: () {},
                  press: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home())),
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home())),
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home())),
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 3.0, color: jaunepastel.withOpacity(0.5)),
      borderRadius: BorderRadius.all(
          Radius.circular(6.0) //                 <--- border radius here
          ),
    );
  }
}
