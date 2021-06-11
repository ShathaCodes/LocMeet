import 'dart:async';
import 'dart:ffi';
import 'package:LoginFlutter/components/rounded_button.dart';

import 'package:LoginFlutter/home.dart';
import 'package:LoginFlutter/pages/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:LoginFlutter/Therapist/therapist_list.dart';
import 'package:LoginFlutter/Therapist/therapistSwipe.dart';
import 'package:LoginFlutter/api_provider.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import './pages/filterChip.dart';
import 'Screens/Signup/signup_screen.dart';
import 'Screens/edit/edit_screen.dart';

import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//this is the name given to the background fetch
const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification(v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High, importance: Importance.Max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await flp.show(0, 'Virtual intelligent solution', '$v', platform,
      payload: 'VIS \n $v');
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);

    /*var response= await http.post('https://seeviswork.000webhostapp.com/api/testapi.php');
   print("here================");
   print(response);
    var convert = json.decode(response.body);
      if (convert['status']  == true) {
        showNotification(convert['msg'], flp);
      } else {
      print("no messgae");
      }*/

    return Future.value(true);
  });
}

Future<void> initNotification() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher,
      isInDebugMode:
          true); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager.registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(minutes: 15), //when should it check the link
      initialDelay:
          Duration(seconds: 5), //duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
}

void main() {
  runApp(MaterialApp(
    home: Profile(),
    theme: ThemeData(fontFamily: 'Poppins'),
  ));
}

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
    initNotification();
  }

  testtt() async {
    user = await user.getTokenData();
    apiProvider = ApiProvider();
    //final ind = ApiProvider.addr;
    //u = await apiProvider.nearby(ind, 30, 30, 20);
    setState(() {
      user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(user.interests);
    //  print("password" + user.password);
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
              color: blue_base,

              // color: Theme.of(context).cardColor,
              height: height * 0.4,
              width: width),
          Container(
              height: height,
              padding: EdgeInsets.only(top: height / 6),
              color: Colors.transparent,
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(top: height / 13, left: width / 3),
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
                                //color: blue_light.withOpacity(0.2),
                                // width: width / 1.2,
                                padding: EdgeInsets.only(left: width / 20),
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.center,
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
                            /* Container(
                                width: width / 1.2,
                                padding: EdgeInsets.only(left: width / 20),
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width / 20,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                          'assets/images/baking.png'),
                                      radius: width / 10,
                                    ),
                                    SizedBox(
                                      width: width / 10,
                                    ),
                                    Container(
                                      child: Text(
                                        "BAKING",
                                        style: TextStyle(
                                            fontSize: width / 23,
                                            fontWeight: FontWeight.bold,
                                            color: blue_dark),
                                      ),
                                      padding:
                                          EdgeInsets.only(top: height / 32),
                                    )
                                  ],
                                )),
                            Container(
                                width: width / 1.2,
                                padding: EdgeInsets.only(left: width / 20),
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width / 20,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                          'assets/images/baking.png'),
                                      radius: width / 10,
                                    ),
                                    SizedBox(
                                      width: width / 10,
                                    ),
                                    Container(
                                      child: Text(
                                        "BAKING",
                                        style: TextStyle(
                                            fontSize: width / 23,
                                            fontWeight: FontWeight.bold,
                                            color: blue_dark),
                                      ),
                                      padding:
                                          EdgeInsets.only(top: height / 32),
                                    )
                                  ],
                                )),*/
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
                      width / 5.8, height / 35), // changes position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
              radius: width / 8,
            ),
            padding: EdgeInsets.only(top: height / 20, left: width / 3),
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
          /* Container(
            padding: EdgeInsets.only(
              left: 0,
              top: height / 2,
            ),
            //margin: EdgeInsets.only(left: 0, top: height / 30),
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                  padding: EdgeInsets.symmetric(
                      vertical: height / 40, horizontal: width / 20),
                  color: blue_dark.withOpacity(0.7),
                  onPressed: () {
                    print("New meeting");
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.group_add_outlined,
                            color: Colors.white, size: width / 15),
                        SizedBox(
                          width: width / 9,
                        ),
                        Text(
                          "Schedule a new meeting",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width / 20),
                        ),
                      ])),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 0,
              top: height / 1.65,
            ),
            //margin: EdgeInsets.only(left: 0, top: height / 30),
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                  padding: EdgeInsets.symmetric(
                      vertical: height / 40, horizontal: width / 20),
                  color: blue_dark.withOpacity(0.7),
                  onPressed: () {
                    print("View my meetings");
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.schedule,
                            color: Colors.white, size: width / 15),
                        SizedBox(
                          width: width / 12,
                        ),
                        Text(
                          "View my scheduled meetings",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width / 20),
                        ),
                      ])),
            ),
          ),*/
        ],
      ),
    )));
  }
}
