import 'package:flutter/material.dart';
import 'package:LoginFlutter/Screens/Login/login_screen.dart';
import 'package:LoginFlutter/Screens/Signup/signup_screen.dart';
import 'package:LoginFlutter/Screens/Welcome/components/background.dart';
import 'package:LoginFlutter/components/rounded_button.dart';
import 'package:LoginFlutter/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LocMeet ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: blue_dark, fontSize: 28),
            ),
            SizedBox(height: size.height * 0.07),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: Image.asset(
                    "assets/images/friendsN.png",
                    width: size.width * 0.6,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              color: blue_base,
              textColor: jaunepastel,
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
            RoundedButton(
              text: "SIGN UP",

              color: jaunepastel,
              textColor: blue_base, //Colors.black,
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
    );
  }
}
