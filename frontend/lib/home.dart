import 'package:flutter/material.dart';
/*import 'package:tab_bar/ViewMap/ViewMapPage.dart';*/
import 'ViewMap/HomePageMap.dart';
import 'TabBar/MotionTabBarView.dart';
import 'TabBar/MotionTabController.dart';
import 'TabBar/motiontabbar.dart';
import './Calender/HomeCalendarPage.dart';
import './Profil/ProfilPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //CalendarController _controller;

  @override
  void initState() {
    super.initState();
    //_controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  MotionTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title != null ? widget.title : '')
            //Text(widget.title),
            ),
        bottomNavigationBar: MotionTabBar(
          labels: ["Account", "Home", "Dashboard"],
          initialSelectedTab: "Home",
          tabIconColor: Colors.yellow[200],
          tabSelectedColor: Colors.yellow[600],
          onTabItemSelected: (int value) {
            print(value);
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [Icons.account_box, Icons.home, Icons.menu],
          textStyle: TextStyle(color: Colors.yellowAccent),
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: ProfilPage(),
            ),
            Container(
              child: HomePageMap(),
            ),
            Container(
              child: HomeCalendarPage(),
            ),
          ],
        ));
  }
}
