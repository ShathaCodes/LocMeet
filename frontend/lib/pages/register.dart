import 'package:flutter/material.dart';
import './../colors/colors.dart';
import './../api_provider.dart';
import '../pages/login.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
//import 'dart:convert';
import 'filterChip.dart';

class Register extends StatelessWidget {
  const Register({Key key}) : super(key: key);

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
            //Scaffold.of(context).showSnackBar(success);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          } else {
            print(res.statusCode);
            ScaffoldMessenger.of(context).showSnackBar(error);
            //Scaffold.of(context).showSnackBar(error);
          }
        } catch (err) {
          print(err);
          ScaffoldMessenger.of(context).showSnackBar(serverError);
          //Scaffold.of(context).showSnackBar(serverError);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(ipError);
      // Scaffold.of(context).showSnackBar(ipError);
    }
  }

  List sth;
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
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Registration",
                          style: new TextStyle(
                              fontFamily: 'Mont', fontSize: 20, color: dark),
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
                                    return 'Insert a Nickname!';
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
                                primaryColorDark: dark,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Insert a password!';
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
                            padding: const EdgeInsets.only(left: 8.0, top: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  child: Wrap(
                                spacing: 5.0,
                                runSpacing: 3.0,
                                children: <Widget>[
                                  for (int i = 0; i < interests.length; i++)
                                    filterChipWidget(
                                      chipName: interests[i].name,
                                      id: interests[i].id,
                                      sth: sth,
                                    )
                                ],
                              )),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: yellow_base,
                                primaryColorDark: dark,
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
                                  onPressed: () => doRegistration(),
                                  child: const Text('SIGN UP',
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
                                          builder: (context) => Login())),
                                  child: Text("Already registered? Login!",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                        fontSize: 13,
                                        color: blue_dark,
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
