import 'package:LoginFlutter/api_provider.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/edit/edit_screen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int counter = 0;
  User user = new User();
  ApiProvider apiProvider;

  @override
  void initState() {
    testtt();

    super.initState();
  }

  testtt() async {
    user = await user.getTokenData();
    apiProvider = ApiProvider();

    setState(() {
      user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(user.interests);

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(color: blue_base, height: height * 0.4, width: width),
          Container(
              height: height,
              padding: EdgeInsets.only(top: height / 6),
              color: Colors.transparent,
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(top: height / 13, left: width / 2.5),
                      child: Text(
                        user.nickname,
                        style: TextStyle(
                            fontSize: width / 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: height / 7, left: width / 20),
                      child: Text(
                        "Interests :",
                        style: TextStyle(
                            fontSize: width / 20,
                            fontWeight: FontWeight.bold,
                            color: blue_light),
                      ),
                    ),
                    Container(
                      child: Card(
                        color: jaunepastel,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: width / 20),
                                child: Row(
                                  children: [
                                    for (int i = 0;
                                        i < user.interests.length;
                                        i++)
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: AssetImage(
                                                'assets/images/' +
                                                    user.interests[i].name +
                                                    '.png'),
                                            radius: width / 10,
                                          ),
                                          SizedBox(
                                            width: width / 7,
                                          ),
                                          Container(
                                            child: Text(
                                              user.interests[i].name
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: width / 23,
                                                  fontWeight: FontWeight.bold,
                                                  color: blue_dark),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height / 50),
                                          ),
                                          SizedBox(
                                            width: width / 3.5,
                                          ),
                                        ],
                                      )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      height: height / 2.5,
                      padding: EdgeInsets.only(top: height / 5),
                    ),
                  ],
                ),
                width: width,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                  ),
                ),
                padding: EdgeInsets.only(
                  bottom: height / 8,
                  left: width / 20,
                  right: width / 20,
                ),
              )),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: jaunepastel.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(
                      width / 5.3, height / 35), // changes position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
              radius: width / 8,
            ),
            padding: EdgeInsets.only(top: height / 20, left: width / 2.6),
          ),
          Positioned(
            top: height / 25,
            right: width / 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditScreen();
                    },
                  ),
                );
              },
              child: Container(
                child: Icon(Icons.settings, color: blue_base, size: width / 15),
                padding: EdgeInsets.all(height / 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: jaunepastel,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height / 3.7,
            left: width / 15,
            child: GestureDetector(
              onTap: () {
                print("Organize meating");
              },
              child: Container(
                padding: EdgeInsets.all(height / 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 9),
                  width: width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: blue_base,
                      onPressed: () => print("Organize meating!!"),
                      child: Icon(
                        Icons.add_alert,
                        color: jaunepastel,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height / 3.7,
            right: width / 15,
            child: GestureDetector(
              onTap: () {
                print("View meetings");
              },
              child: Container(
                padding: EdgeInsets.all(height / 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 9),
                  width: width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: blue_base,
                      onPressed: () => print("new meeting!!"),
                      child: Icon(
                        Icons.event_available_rounded,
                        color: jaunepastel,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
