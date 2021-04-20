import 'package:flutter/material.dart';
//import 'package:LoginFlutter/Screens/Login/components/background.dart';
import '/Screens/Login/components/background.dart';
import '/Screens/Signup/signup_screen.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import '/components/rounded_input_field.dart';
import '/components/rounded_password_field.dart';
import '/constants.dart';

import 'dart:async';
import 'dart:convert';
//import '/colors/colors.dart';
import '/api_provider.dart';
import '/pages/home.dart';
//import '/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);
*/
class Body extends StatefulWidget {
  @override
  BodyState createState() {
    return new BodyState();
  }
}

class BodyState extends State<Body> {
  TextEditingController _crtlNickname = TextEditingController();
  TextEditingController _crtlPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final success = SnackBar(content: Text('Login succeded!'));
  final error = SnackBar(content: Text('Wrong credentials!'));
  final serverError = SnackBar(content: Text('Can\'t connect to the server!'));

  ApiProvider apiProvider = ApiProvider();

  Future doLogin() async {
    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it does not exist, return 0.
    final ind = ApiProvider.addr;
    if (_formKey.currentState.validate()) {
      if (ind != "") {
        try {
          var res = await apiProvider.doLogin(
              _crtlNickname.text, _crtlPassword.text, ind);
          if (res.statusCode == 200) {
            var jsonRes = json.decode(res.body);
            var token = jsonRes['token'];
            prefs.setString("token", token);

            Navigator.of(context).push(//pushReplacement
                MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(error);
            // Scaffold.of(context).showSnackBar(error);
          }
        } catch (err) {
          print(err);
          ScaffoldMessenger.of(context).showSnackBar(serverError);
          //Scaffold.of(context).showSnackBar(serverError);
        }
      }
    }
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
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              color: blue_base,
              textColor: jaunepastel,

              //textColor: blue_dark,
              //onPressed: () => doLogin(),
              //press: () {},
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
    );
  }

  /*@override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Stack(
          children: [
            /*Container(
              child: Image.asset(
                'assets/images/edge.PNG',
                scale: 0.5,
              ),
            ),*/
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: heigth / 14, left: width / 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Login",
                          style: new TextStyle(
                              fontFamily: 'Mont',
                              fontSize: 20,
                              color: jaunepastel),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: heigth / 10 - 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Image.asset(
                            'assets/images/logoPalette.png',
                            scale: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(width / 7, 20, width / 7, 0),
                    child: Container(
                      width: width,
                      height: heigth,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: blue_base,
                                primaryColorDark: dark,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Insert your nickname!';
                                  }
                                  return null;
                                },
                                controller: _crtlNickname,
                                style: TextStyle(fontSize: 20.0, color: dark),
                                decoration: new InputDecoration(
                                    labelText: "Nickname",
                                    fillColor: dark,
                                    prefixIcon: const Icon(
                                      Icons.verified_user,
                                      color: yellow_base,
                                    ),
                                    border: new OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: new BorderSide(
                                            color: Colors.white))),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: blue_base,
                                primaryColorDark: blue_dark,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Insert a Password!';
                                  }
                                  return null;
                                },
                                controller: _crtlPassword,
                                obscureText: true,
                                style: TextStyle(fontSize: 20.0, color: dark),
                                decoration: new InputDecoration(
                                    labelText: "Password",
                                    fillColor: dark,
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: yellow_base,
                                    ),
                                    border: new OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: new BorderSide(
                                            color: Colors.white))),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: blue_base,
                                primaryColorDark: blue_dark,
                              ),
                              child: ButtonTheme(
                                minWidth: width,
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            yellow_base),
                                  ),
                                  onPressed: () => doLogin(),
                                  child: const Text('LOGIN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'calibre',
                                          letterSpacing: 1.5,
                                          fontSize: 20)),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: new TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home())),
                                  child: Text("home page atla3",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                        fontSize: 13,
                                        color: blue_dark,
                                        fontFamily: 'calibre',
                                        decoration: TextDecoration.underline,
                                      )),

                                  //new Text(cart_prod_qty!=null?cart_prod_qty:'Default Value'),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }*/
}
