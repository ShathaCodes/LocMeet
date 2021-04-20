import 'package:flutter/material.dart';
import './pages/index.dart';
//import './colors/colors.dart';
//import '/Screens/Welcome/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Node server demo',
        debugShowCheckedModeBanner: false,
        home: Index());
    //home: WelcomeScreen());
  }
}

/*import 'package:flutter/material.dart';
/*import 'package:tab_bar/ViewMap/ViewMapPage.dart';*/
import 'ViewMap/HomePageMap.dart';
import 'TabBar/MotionTabBarView.dart';
import 'TabBar/MotionTabController.dart';
import 'TabBar/motiontabbar.dart';
import './Calender/HomeCalendarPage.dart';
import './Profil/ProfilPage.dart';//

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motion Tab Bar Sample',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.cyan.shade200,
        accentColor: Colors.cyan[200],

        // Define the default font family.
        //fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      /*color: Colors.yellow.shade200,
      theme: new ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white))),
      */
      home: MyHomePage(title: 'Motion Tab Bar Sample'),
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
        appBar: AppBar(
          title: Text(widget.title),
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
}*/
