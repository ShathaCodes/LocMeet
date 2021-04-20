import 'package:LoginFlutter/Calender/HomeCalendarPage.dart';
import 'package:LoginFlutter/Therapist/therapist_list.dart';
import 'package:LoginFlutter/ViewMap/HomePageMap.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/therapist.dart';
import 'package:LoginFlutter/profil.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
//import './colors/colors.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

var tstyle = TextStyle(color: Colors.blue.withOpacity(0.6), fontSize: 50);

class _HomeState extends State<Home> {
  int _index = 0;
  var padding = EdgeInsets.symmetric(horizontal: 12, vertical: 5);
  double gap = 5;
  List<GButton> buttons = [];
  List<String> list = ["Calendar", "Meeting", "Call", "Profile"];
  List<Widget> text = [
    HomeCalendarPage(),
    HomePageMap(),
    TherapistList(),
    Profile(),
  ];

  List<Color> colors = [
    Color(0xFF3788BE),
    Colors.teal,
    Colors.grey[600],
    Colors.teal
  ];
  List icons = [
    LineIcons.calendar,
    LineIcons.alternateMapMarker,
    LineIcons.phone,
    LineIcons.user
  ];

  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    buttons = [
      for (int i = 0; i < text.length; i++)
        GButton(
          gap: gap,
          icon: icons[i],
          iconColor: blue_base,
          iconActiveColor: blue_dark,
          text: list[i],
          textColor: blue_dark,
          backgroundColor: blue_dark.withOpacity(0.2),
          iconSize: 30,
          padding: padding,
        )
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: blue_base,
        shadowColor: jaunepastel,
        foregroundColor: jaunepastel,
        title: Text("haja", style: TextStyle(color: jaunepastel)),
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          for (int i = 0; i < text.length; i++) Center(child: text[i]),
        ],
        onPageChanged: (page) {
          setState(() {
            _index = page;
          });
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(0, 40),
                )
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          child: GNav(
            curve: Curves.fastOutSlowIn,
            //tabShadow: [BoxShadow(blurRadius: 8, color: colors[_index])],
            duration: Duration(microseconds: 900),
            tabs: buttons,
            selectedIndex: _index,
            onTabChange: (index) {
              setState(() {
                _index = index;
              });
              controller.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }
}
