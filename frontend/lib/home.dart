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
  int indexx;
  Home({Key key, this.title, this.indexx}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

var tstyle = TextStyle(color: Colors.blue.withOpacity(0.6), fontSize: 50);

class _HomeState extends State<Home> {
  User user = new User();
  ApiProvider apiProvider;
  Event lastEventRequest;
  static Event lastEventAccept;
  Event lastEventRefuse;
  Event lastEventSuccess;
  String lastConnectionState;
  Channel channel;
  Channel channel2;
  var i = 0;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future onSelectNotification(String payload) async {
    if (payload == 'request') {
      showDialog(
        context: context,
        builder: (_) {
          return new AlertDialog(
              title: Text(
                "Accept !",
                style: TextStyle(fontWeight: FontWeight.bold, color: blue_base),
              ),
              content: Container(
                  width: 350,
                  height: 100,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          IconButton(
                              icon: const Icon(
                                Icons.check_circle_rounded,
                                size: 40,
                                color: blue_dark,
                              ),
                              tooltip: 'accept',
                              onPressed: () async {
                                channel2 = await Pusher.subscribe(
                                    "private-" + lastEventRequest.data);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewMapGoogle(
                                          userSent: lastEventAccept),
                                    ));
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                await channel2.trigger("accept",
                                    data: user.nickname);
                              }),
                          Text(
                            "let's meet ",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: blue_dark),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        children: [
                          IconButton(
                              icon: const Icon(
                                Icons.delete_forever_rounded,
                                size: 40,
                                color: blue_dark,
                              ),
                              tooltip: 'refuse',
                              onPressed: () async {
                                channel2 = await Pusher.subscribe(
                                    "private-" + lastEventRequest.data);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                await channel2.trigger("refuse",
                                    data: user.nickname);
                              }),
                          Text(
                            "not now",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: blue_dark),
                          ),
                        ],
                      ),
                    ],
                  )));
        },
      );
    } else if (payload == "accept") {
      showDialog(
          context: context,
          builder: (_) {
            return new AlertDialog(
                title: Text(
                  "Your request has been accepted",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: blue_base),
                ),
                content: Container(
                    width: 350,
                    height: 100,
                    child: FlatButton(
                        child: Text('proceed ...'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewMapGoogle(userSent: lastEventAccept)),
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                        })));
          });
    }
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    setState(() {
      k++;
      if (k == 1) {
        var initializationSettingsAndroid =
            new AndroidInitializationSettings('@mipmap/ic_launcher');
        var initializationSettingsIOS = new IOSInitializationSettings();
        var initializationSettings = new InitializationSettings(
            initializationSettingsAndroid, initializationSettingsIOS);
        flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: onSelectNotification);
      }
    });
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
        .show(0, title, body, platformChannelSpecifics, payload: title);
  }

  Future<void> initPusher() async {
    try {
      //initialize Pusher
      await Pusher.init(
          "0e149bbe91658d657887",
          PusherOptions(
              cluster: "eu",
              auth: PusherAuth("http://192.168.1.6:3000/pusher/auth")),
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
      if (mounted) {
        setState(() {
          lastEventAccept = x;
        });
        showNotification("accept", lastEventAccept.data);
      }
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

  static int e;
  Future<void> initIndex() async {
    e = widget.indexx;
  }

  static int k = 0;
  @override
  void initState() {
    //k = 0;
    testtt();
    initPusher();
    controller = PageController(initialPage: widget.indexx);

    super.initState();
  }

  @override
  void dispose() {
    Pusher.disconnect();
    lastEventAccept = null;
    setState(() {
      lastEventAccept = null;
    });
    super.dispose();
  }

  testtt() async {
    user = await user.getTokenData();
    apiProvider = ApiProvider();
    setState(() {
      user = user;
    });
  }

  var padding = EdgeInsets.symmetric(horizontal: 12, vertical: 5);
  double gap = 5;
  List<GButton> buttons = [];

  List<String> list = ["Profile", "Meeting", "Call", "Calendar"];
  List<Widget> text = [
    Profile(),
    ViewMapGoogle(userSent: lastEventAccept),
    TherapistList(),
    CalendarPage(),
  ];

  List<Color> colors = [
    Colors.teal,
    Colors.teal,
    Colors.grey[600],
    Color(0xFF3788BE),
  ];
  List icons = [
    LineIcons.user,
    LineIcons.alternateMapMarker,
    LineIcons.phone,
    LineIcons.calendar,
  ];

  PageController controller;
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
        elevation: 0.0,
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
            widget.indexx = page;
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
            duration: Duration(microseconds: 900),
            tabs: buttons,
            selectedIndex: widget.indexx,
            onTabChange: (index) {
              setState(() {
                widget.indexx = index;
              });
              controller.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }
}
