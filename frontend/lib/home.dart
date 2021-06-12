import 'package:LoginFlutter/Calender/calendarPage.dart';
import 'package:LoginFlutter/Therapist/therapist_list.dart';
import 'package:LoginFlutter/ViewMap/ViewMapGoogle.dart';
import 'package:LoginFlutter/api_provider.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:LoginFlutter/profil.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'constants.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

var tstyle = TextStyle(color: Colors.blue.withOpacity(0.6), fontSize: 50);

class _HomeState extends State<Home> {
  User user = new User();
  ApiProvider apiProvider;
  Event lastEventRequest;
  Event lastEventAccept;
  Event lastEventRefuse;
  Event lastEventSuccess;
  String lastConnectionState;
  Channel channel;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.Max,
        playSound: true,
        showProgress: true,
        priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  Future<void> initPusher() async {
    try {
      // user = await user.getTokenData();
      //initialize Pusher
      await Pusher.init(
          "a3321ae30692703e9fe0",
          PusherOptions(
              cluster: "eu",
              auth: PusherAuth("http://192.168.43.247:3000/pusher/auth")),
          enableLogging: true);
    } on PlatformException catch (e) {
      print(e.message);
    }
    //Connect Pusher
    Pusher.connect(onConnectionStateChange: (x) async {
      if (mounted)
        setState(() {
          lastConnectionState = x.currentState;
        });
    }, onError: (x) {
      debugPrint("Error: ${x.message}");
    });
    //Subscibe to private channel of user identified by their nickname
    channel = await Pusher.subscribe("private-" + user.nickname);
    //bind to events request, accept, refuse and success
    await channel.bind("request", (x) {
      if (mounted) {
        setState(() {
          lastEventRequest = x;
        });
        showNotification("request", lastEventRequest.data);
        print("onMessage: $x");
      }
    });
    await channel.bind("accept", (x) {
      if (mounted)
        setState(() {
          lastEventAccept = x;
        });
    });
    await channel.bind("refuse", (x) {
      if (mounted)
        setState(() {
          lastEventRefuse = x;
        });
    });
    await channel.bind("success", (x) {
      if (mounted)
        setState(() {
          lastEventSuccess = x;
        });
    });
  }

  @override
  void initState() {
    print("faire iniiiiiiiiiiiiiiiiiiiit dans initstate");
    testtt();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    initPusher();
    super.initState();
  }

  @override
  void dispose() {
    Pusher.disconnect();
    super.dispose();
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

  int _index = 0;
  var padding = EdgeInsets.symmetric(horizontal: 12, vertical: 5);
  double gap = 5;
  List<GButton> buttons = [];
  List<String> list = ["Calendar", "Meeting", "Call", "Profile"];
  List<Widget> text = [
    CalendarPage(),
    ViewMapGoogle(),
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
      extendBody: false,
      appBar: AppBar(
        backgroundColor: blue_base,
        shadowColor: jaunepastel,
        foregroundColor: blue_base,
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
