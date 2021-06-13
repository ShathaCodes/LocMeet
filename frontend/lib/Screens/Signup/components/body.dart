import 'package:LoginFlutter/Screens/Signup/components/multi_select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:LoginFlutter/Screens/Login/login_screen.dart';
import 'package:LoginFlutter/Screens/Signup/components/background.dart';
import 'package:LoginFlutter/Screens/Signup/components/or_divider.dart';
import 'package:LoginFlutter/components/already_have_an_account_acheck.dart';
import 'package:LoginFlutter/components/rounded_button.dart';
import 'package:LoginFlutter/components/rounded_input_field.dart';
import 'package:LoginFlutter/components/rounded_password_field.dart';
import 'package:LoginFlutter/constants.dart';
import '/api_provider.dart';
import 'dart:async';

class Body extends StatefulWidget {
  @override
  BodyState createState() {
    return new BodyState();
  }
}

class BodyState extends State<Body> {
  final success = SnackBar(content: Text('Login succeded!'));
  final error = SnackBar(content: Text('Wrong credentials!'));
  final serverError = SnackBar(content: Text('Can\'t connect to the server!'));
  final ipError =
      SnackBar(content: Text('You must insert an IP! Go to settings'));

  final _formKey = GlobalKey<FormState>();

  ApiProvider apiProvider = ApiProvider();

  Future doRegistration() async {
// Try reading data from the counter key. If it does not exist, return 0.
    final ind = ApiProvider.addr;
    if (_formKey.currentState.validate()) {
      if (ind != "") {
        try {
          var res =
              await apiProvider.doRegistration(nickname, password, ind, sth);
          if (res.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(success);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
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
  String nickname = "";
  String password = "";
  List<String> interest;

  MultiSelectDialog multi;

  Future initialize() async {
    interests = [];
    sth = List();
    interests = await apiProvider.getInterests(ApiProvider.addr);
    interest = [];
    for (int i = 0; i < interests.length; i++) interest.add(interests[i].name);
    multi = new MultiSelectDialog(
        question: Text('Select Your Flavours'), answers: interest);

    setState(() {
      interests = interests;
      interest = interest;
    });
  }

  @override
  initState() {
    initialize();
    super.initState();
  }

  @override
  List<String> flavours = [];
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
                "SIGNUP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: blue_dark,
                    fontSize: 18),
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
              SizedBox(height: size.height * 0.03),

//******************************Box

              RoundedButton(
                  text: "SIGNUP",
                  press: () async {
                    flavours = await showDialog<List<String>>(
                            context: context,
                            builder: (_) => MultiSelectDialog(
                                question: Text('Select Your Interests',
                                    style: TextStyle(color: blue_dark)),
                                answers: interest)) ??
                        [];
                    print(flavours);
                    setState(() {
                      sth = flavours;
                    });
                    doRegistration();
                    // Logic to save selected flavours in the database
                  }),

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
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 3.0, color: jaunepastel.withOpacity(0.5)),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0) //                 <--- border radius here
          ),
    );
  }
}
