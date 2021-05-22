import 'package:LoginFlutter/components/rounded_button.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pusher/pusher.dart';

class MeetingRequest extends StatefulWidget {
  @override
  _MeetingRequestState createState() => _MeetingRequestState();
}

class _MeetingRequestState extends State<MeetingRequest> {
  Event lastEventRequest;
  Event lastEventAccept;
  Event lastEventRefuse;
  Event lastEventSuccess;
  String lastConnectionState;
  Channel channel;
  Channel channel2;
  User user = new User();
  var user2 = "Maissona";

  @override
  void initState() {
    super.initState();
    initPusher();
  }

  @override
  void dispose() {
    Pusher.disconnect();
    super.dispose();
  }

  Future<void> initPusher() async {
    user = await user.getTokenData();
    try {
      // user = await user.getTokenData();
      //initialize Pusher
      await Pusher.init(
          "a3321ae30692703e9fe0",
          PusherOptions(
              cluster: "eu",
              auth: PusherAuth("http://192.168.1.3:3000/pusher/auth")),
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
      if (mounted)
        setState(() {
          lastEventRequest = x;
        });
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Connections!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: blue_dark,
                    fontSize: 18),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Connection request to " + user2,
                color: blue_base,
                textColor: jaunepastel,
                press: () async {
                  channel2 = await Pusher.subscribe("private-" + user2);
                  await channel2.trigger("request", data: user.nickname);
                },
              ),
              SizedBox(height: size.height * 0.03),
              if (lastEventRequest != null)
                Container(
                  child: Column(
                    children: [
                      Text("You have a request from " + lastEventRequest.data),
                      SizedBox(height: size.height * 0.03),
                      RoundedButton(
                        text: "Accept ",
                        color: blue_base,
                        textColor: jaunepastel,
                        press: () async {
                          channel2 = await Pusher.subscribe(
                              "private-" + lastEventRequest.data);
                          await channel2.trigger("accept", data: user.nickname);
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      RoundedButton(
                        text: "Refuse ",
                        color: blue_base,
                        textColor: jaunepastel,
                        press: () async {
                          channel2 = await Pusher.subscribe(
                              "private-" + lastEventRequest.data);
                          await channel2.trigger("refuse", data: user.nickname);
                        },
                      ),
                    ],
                  ),
                ),
              if (lastEventAccept != null)
                Container(
                    child:
                        Center(child: Text("Your request have been accepted"))),
              if (lastEventRefuse != null)
                Container(
                    child:
                        Center(child: Text("Your request have been refused")))
            ]),
      ),
    );
  }
}
