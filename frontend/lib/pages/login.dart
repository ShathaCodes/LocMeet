import 'dart:async';
import 'dart:convert';

//import 'package:LoginFlutter/Calender/HomeCalendarPage.dart';
import 'package:flutter/material.dart';
import './../colors/colors.dart';
import './../api_provider.dart';
import './../pages/home.dart';
//import '../pages/register.dart';
import '../home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

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
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              child: Image.asset(
                'assets/images/edge.PNG',
                scale: 0.5,
              ),
            ),
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
                              fontFamily: 'Mont', fontSize: 20, color: kohl),
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
                            'assets/images/logo.png',
                            scale: 2.5,
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
                                primaryColor: blue,
                                primaryColorDark: darkred,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Insert your nickname!';
                                  }
                                  return null;
                                },
                                controller: _crtlNickname,
                                style: TextStyle(fontSize: 20.0, color: kohl),
                                decoration: new InputDecoration(
                                    labelText: "Nickname",
                                    fillColor: kohl,
                                    prefixIcon: const Icon(
                                      Icons.verified_user,
                                      color: blue,
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
                                primaryColor: blue,
                                primaryColorDark: darkred,
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
                                style: TextStyle(fontSize: 20.0, color: kohl),
                                decoration: new InputDecoration(
                                    labelText: "Password",
                                    fillColor: kohl,
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: blue,
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
                                primaryColor: blue,
                                primaryColorDark: darkred,
                              ),
                              child: ButtonTheme(
                                minWidth: width,
                                height: 50.0,
                                child: ElevatedButton(
                                  //onPressed: () => Home(),
                                  // context,
                                  //MaterialPageRoute(
                                  //  builder: (context) => Home())),

                                  onPressed: () => doLogin(),
                                  child: const Text('LOGIN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'calibre',
                                          letterSpacing: 1.5,
                                          fontSize: 20)),
                                  /* color: blue,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0))*/
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
                                        color: blue,
                                        fontFamily: 'calibre',
                                        decoration: TextDecoration.underline,
                                      )),
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
  }
}
