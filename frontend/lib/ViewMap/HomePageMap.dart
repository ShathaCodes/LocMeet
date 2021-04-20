//import 'package:LoginFlutter/colors/colors.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:flutter/material.dart';
import '../ViewMap/ViewMapPage.dart';
import '../Calender/HomeCalendarPage.dart';

class HomePageMap extends StatefulWidget {
  @override
  _HomePageMapState createState() => _HomePageMapState();
}

class _HomePageMapState extends State<HomePageMap> {
  //CalendarController _controller;

  @override
  void initState() {
    super.initState();
    //_controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewMapPage(),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          /*FloatingActionButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeCalendarPage())),
            /* onPressed: () {
              HomeCalendarPage();
              setState(() {
                //counter = counter + 1;
              });
            },*/
            child: Container(
              width: 60,
              height: 60,
              child: Icon(Icons.calendar_today_rounded),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [jaunepastel, jaunepastel],
                  )),
            ),
            heroTag: null,
          ),*/
          SizedBox(
            height: 500,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                //counter = counter + 1;
              });
            },
            child: Container(
              width: 60,
              height: 60,
              child: Icon(Icons.search),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [blue_base],
                  )),
            ),
            heroTag: null,
          )
        ]));
  }
}
