import 'dart:convert';

import 'package:LoginFlutter/Screens/Signup/components/multi_select_dialog.dart';
import 'package:LoginFlutter/components/rounded_input_fieldedit.dart';
import 'package:LoginFlutter/components/rounded_password_fieldedit.dart';
import 'package:LoginFlutter/models/interest.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:LoginFlutter/pages/index.dart';

import 'package:flutter/material.dart';
import 'package:LoginFlutter/Screens/Login/login_screen.dart';
import 'package:LoginFlutter/Screens/Signup/components/background.dart';
import 'package:LoginFlutter/Screens/Signup/components/or_divider.dart';
import 'package:LoginFlutter/components/already_have_an_account_acheck.dart';
import 'package:LoginFlutter/components/rounded_button.dart';
import 'package:LoginFlutter/constants.dart';

import 'package:LoginFlutter/api_provider.dart';
import 'dart:async';
import 'package:LoginFlutter/pages/filterChip.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../home.dart';

class Body extends StatefulWidget {
  @override
  BodyState createState() {
    return new BodyState();
  }
}

class BodyState extends State<Body> {
  static User user = new User();
  ApiProvider apiProvider;
  static String nickname1;

  List sth; //choosenInterest
  static List interests;
  String nickname = "";
  String password = "";
  List<String> interest;
  List<String> myInterests;
  Future initialize() async {
    apiProvider = ApiProvider();

    interests = await apiProvider.getInterests(ApiProvider.addr);
    setState(() {
      interests = interests;
    });
  }

  @override
  void initState() {
    initialize();
    testtt();
    super.initState();
  }

  testtt() async {
    user = await user.getTokenData();

    apiProvider = ApiProvider();
    //final ind = ApiProvider.addr;
    //u = await apiProvider.nearby(ind, 30, 30, 20);
    setState(() {
      user = user;

      nickname1 = user.nickname;
    });
  }

  final success = SnackBar(content: Text('Edit succeded!'));
  final successDelete = SnackBar(content: Text('Your account got deleted!'));

  final error = SnackBar(content: Text('Wrong credentials!'));
  final serverError = SnackBar(content: Text('Can\'t connect to the server!'));
  final ipError =
      SnackBar(content: Text('You must insert an IP! Go to settings'));

  final _formKey = GlobalKey<FormState>();
  Future deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    final ind = ApiProvider.addr;
    if (ind != "") {
      try {
        print(user.id);
        print(ind);
        var res = await apiProvider.deleteUser(user.id, ind);

        if (res.statusCode == 202) {
          ScaffoldMessenger.of(context).showSnackBar(successDelete);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Index()));
        } else {
          print(res.statusCode);
          ScaffoldMessenger.of(context).showSnackBar(error);
        }
      } catch (err) {
        print(err);
        ScaffoldMessenger.of(context).showSnackBar(serverError);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(ipError);
    }
  }

  Future updateUser() async {
    final prefs = await SharedPreferences.getInstance();

    //final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it does not exist, return 0.
    final ind = ApiProvider.addr;
    if (_formKey.currentState.validate()) {
      if (ind != "") {
        try {
          if (nickname.isEmpty) nickname = nickname1;
          print(nickname);
          var res = await apiProvider.updateUser(
              user.id, nickname, password, ind, myInterests);

          if (res.statusCode == 200) {
            var jsonRes = json.decode(res.body);
            var token = jsonRes['token'];
            prefs.setString("token", token);

            ScaffoldMessenger.of(context).showSnackBar(success);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Home(
                      indexx: 3,
                    )));
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

  MultiSelectDialog multi;

  @override
  List<String> flavours = [];

  Widget build(BuildContext context) {
    myInterests = [];

    for (int i = 0; i < user.interests.length; i++) {
      myInterests.add(user.interests[i].name);
    }
    finding(myTable, interest) {
      for (int i = 0; i < myTable.length; i++) {
        if (myTable[i] == interest) return true;
      }
      return false;
    }

    Size size = MediaQuery.of(context).size;

    return Background(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "EDIT MY ACCOUNT",
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
                  initialValue: nickname1,
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
              //  SizedBox(height: size.height * 0.005),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 3),
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: Wrap(
                              spacing: 5.0,
                              runSpacing: 3.0,
                              children: <Widget>[
                            for (int i = 0; i < interests.length; i++)
                              filterChipWidget(
                                  chipName: interests[i].name,
                                  sth: myInterests,
                                  selected:
                                      finding(myInterests, interests[i].name)),
                          ])))),
//******************************Box
              SizedBox(
                height: size.height * 0.005,
              ),

              RoundedButton(
                text: "PROCEED",
                press: () => {updateUser()},
                /* press: () async {
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
                  }*/
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Do you want to delete you account! ",
                    style: TextStyle(color: blue_base),
                  ),
                  GestureDetector(
                    onTap: () => {deleteUser()},
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: blue_base,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),

              // SizedBox(height: size.height * 0.03),
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
