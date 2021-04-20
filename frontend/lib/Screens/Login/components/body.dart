import 'package:flutter/material.dart';
import 'package:LoginFlutter/Screens/Login/components/background.dart';
import 'package:LoginFlutter/Screens/Signup/signup_screen.dart';
import 'package:LoginFlutter/components/already_have_an_account_acheck.dart';
import 'package:LoginFlutter/components/rounded_button.dart';
import 'package:LoginFlutter/components/rounded_input_field.dart';
import 'package:LoginFlutter/components/rounded_password_field.dart';
import 'package:LoginFlutter/constants.dart';

import 'dart:async';
import 'dart:convert';
import 'package:LoginFlutter/api_provider.dart';
//import 'package:LoginFlutter/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:LoginFlutter/home.dart';

class Body extends StatefulWidget {
  @override
  BodyState createState() {
    return new BodyState();
  }
}

class BodyState extends State<Body> {
  String nickname = "";
  String password = "";

  final _formKey = GlobalKey<FormState>();

  final success = SnackBar(content: Text('Login succeded!'));
  final error = SnackBar(content: Text('Wrong credentials!'));
  final serverError = SnackBar(content: Text('Can\'t connect to the server!'));

  ApiProvider apiProvider = ApiProvider();

  Future doLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final ind = ApiProvider.addr;
    if (_formKey.currentState.validate()) {
      if (ind != "") {
        try {
          var res = await apiProvider.doLogin(nickname, password, ind);
          if (res.statusCode == 200) {
            var jsonRes = json.decode(res.body);
            var token = jsonRes['token'];
            prefs.setString("token", token);

            /* Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));*/
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(error);
          }
        } catch (err) {
          print(err);
          ScaffoldMessenger.of(context).showSnackBar(serverError);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
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
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
                hintText: "Your nickname",
                onChanged: (value) {
                  setState(() {
                    nickname = value;
                  });
                }),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            RoundedButton(
              text: "LOGIN",
              color: blue_base,
              textColor: jaunepastel,
              press: () => doLogin(),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
