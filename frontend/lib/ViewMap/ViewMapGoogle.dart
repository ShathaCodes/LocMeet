import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:LoginFlutter/models/user.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/api_provider.dart';
import 'package:location/location.dart';
import 'package:flutter_pusher/pusher.dart';
import '../home.dart';
import 'Datepicker.dart';
import 'DatepickerEdit.dart';

class ViewMapGoogle extends StatefulWidget {
  final Event userSent;
  const ViewMapGoogle({Key key, this.userSent}) : super(key: key);

  @override
  _ViewMapGoogleState createState() => _ViewMapGoogleState();
}

class _ViewMapGoogleState extends State<ViewMapGoogle> {
  var x;
  User user = new User();
  ApiProvider apiProvider;

  LocationUser location;

  static var latitudepos;
  static var longitudepos;
  List<User> liste;
  Channel channel2;

  Future _getNearby() async {
    liste = await apiProvider.nearby(
        ApiProvider.addr, latitudepos, longitudepos, 5);
    var lol = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 22)),
        'assets/markers/darkbluemarker2.png');

    var lol1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 22)),
        'assets/markers/redmarker2.png');
    setState(() {
      liste = liste;

      if (liste != null)
        for (int i = 0; i < liste.length; i++) {
          var userr = liste[i];
          if (userr.id != user.id) {
            String interests = "";
            for (var interest in userr.interests)
              interests += "    " + interest.name;

            _markers.add(new Marker(
                markerId: MarkerId('iduser-' + (i + 2).toString()),
                icon: lol,
                position: LatLng(userr.location.lat, userr.location.lng),
                infoWindow: InfoWindow(
                  title: userr.nickname,
                  snippet: interests,
                ),
                onTap: () async {
                  print("Clicked: ${userr.nickname}");
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            backgroundColor: jaunepastel,
                            title: new Text("Let's connect",
                                style: TextStyle(color: blue_base)),
                            content: Container(
                                width: 70,
                                height: 90,
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Text("user:   ${userr.nickname}"),
                                    ]),
                                    Row(children: [
                                      Text(""),
                                    ]),
                                    Row(children: [
                                      Text("interests:"),
                                    ]),
                                    Row(children: [
                                      Text("${interests}"),
                                    ]),
                                  ],
                                )),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () async {
                                    channel2 = await Pusher.subscribe(
                                        "private-" + userr.nickname);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    await channel2.trigger("request",
                                        data: user.nickname);
                                  },
                                  child: Text("connect !",
                                      style: TextStyle(
                                          color: blue_dark, fontSize: 20))),
                            ],
                          ));
                  print("alerte faite");
                }));
          }
        }
      if ((liste != null) && (widget.userSent != null))
        for (int j = 0; j < liste.length; j++) {
          var listeMarkers = _markers.toList();
          var k = listeMarkers[j];
          if (liste[j].nickname == widget.userSent.data) {
            Marker m1 = new Marker(
              markerId: MarkerId('iduser-' + (j + 2).toString()),
              icon: lol1,
              position: LatLng(liste[j].location.lat, liste[j].location.lng),
              infoWindow: InfoWindow(
                title: liste[j].nickname,
                snippet: 'Your companion',
              ),
            );

            _markers.remove(k);
            _markers.add(m1);

            break;
          }
        }
    });
  }

  List joinedMeetings = new List();
  List myMeetings = new List();
  List otherMeetings = new List();
  bool test;

  Future getMeetings() async {
    List meetings = new List();
    meetings = await apiProvider.getMeetings(ApiProvider.addr);

    for (var m in meetings) {
      if (m.creator.id == user.id) {
        // put this in users created events --> myMeetings
        myMeetings.add(m);
      } else {
        test = false;
        for (User u in m.guests)
          if (u.id == user.id) {
            test = true;
            // put this in users joined events --> joinedMeetings
            joinedMeetings.add(m);
          }
        if (test == false) otherMeetings.add(m);
      }
    } // the rest of events shall remain in the original list --> meetings

    var lol = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 22)),
        'assets/markers/joinMeeting.png');
    var joinedMeeting = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 22)),
        'assets/markers/joinedMeeting.png');
    var editMeeting = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 22)),
        'assets/markers/editMeeting1.png');
    var meeting;
    var k;
    setState(() {
      for (Meeting meeting in otherMeetings) {
        k = meeting.id;
        print(meeting.location.lat.toString() + "---" + k.toString());
        _markers.add(Marker(
            markerId: MarkerId('id-' + k.toString()),
            position:
                LatLng(meeting.location.lat, meeting.location.lng), //_center,
            icon: lol,
            infoWindow: InfoWindow(
              title: 'Meeting event',
              snippet: DateFormat('EEE, d/M/y').format(meeting.date),
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                        backgroundColor: jaunepastel,
                        title: new Text("Meeting Event!",
                            style: TextStyle(color: blue_base)),
                        content: Container(
                            width: 70,
                            height: 90,
                            child: Column(
                              children: [
                                Row(children: [
                                  Text(
                                      "Creator:   ${meeting.creator.nickname}"),
                                ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: [
                                  Text("Date: " +
                                      DateFormat('EEE, d/M/y')
                                          .format(meeting.date)),
                                ]),
                              ],
                            )),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () async {
                                await apiProvider.joinMeeting(
                                    meeting.id, user.id, ApiProvider.addr);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Home(indexx: 3);
                                    },
                                  ),
                                );
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              child: Text("Join !",
                                  style: TextStyle(
                                      color: blue_dark, fontSize: 20))),
                        ],
                      ));
            }));
      }
      for (Meeting meeting in myMeetings) {
        k = meeting.id;
        print(meeting.location.lat.toString() + "---" + k.toString());
        _markers.add(Marker(
          markerId: MarkerId('id-' + k.toString()),
          position: LatLng(meeting.location.lat, meeting.location.lng),
          icon: editMeeting,
          infoWindow: InfoWindow(
              title: 'Click to edit your meeting',
              snippet: DateFormat('EEE, d/M/y').format(meeting.date),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyDatepickerEdit(
                        id: meeting.id,
                      );
                    },
                  ),
                );
              }),
        ));
      }
      for (int i = 0; i < joinedMeetings.length; i++) {
        k = i + liste.length + otherMeetings.length + myMeetings.length + 1;
        meeting = joinedMeetings[i];
        print(meeting.location.lat.toString() + "---" + k.toString());
        _markers.add(Marker(
            markerId: MarkerId('id-' + k.toString()),
            position: LatLng(meeting.location.lat, meeting.location.lng),
            icon: joinedMeeting,
            infoWindow: InfoWindow(
              title: 'Joined meeting!',
              snippet: DateFormat('EEE, d/M/y').format(meeting.date),
            ),
            onTap: () async {}));
      }
    });
  }

  BitmapDescriptor mapMarker;

  Future<void> _getCurrentUserLocation() async {
    print("CurrentUserLocation-------localization");
    var locdata = await Location().getLocation();
    print("CurrentUserLocation-------recuperation des donnees ");
    latitudepos = locdata.latitude;
    longitudepos = locdata.longitude;
    print("CurrentUserLocation-------" + latitudepos.toString());
    print("CurrentUserLocation-------" + longitudepos.toString());
    user = await user.getTokenData();
    location = user.location;
    location.lat = latitudepos;
    location.lng = longitudepos;
    apiProvider.updateLocation(location, ApiProvider.addr);
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 22)),
        'assets/markers/redmarker2.png');

    setState(() {
      latitudepos = latitudepos;
      longitudepos = longitudepos;
      user = user;
      _markers.add(Marker(
        markerId: MarkerId('iduser'),
        position: LatLng(latitudepos, longitudepos), //_center,
        icon: mapMarker,

        infoWindow: InfoWindow(
          title: 'Me',
          snippet: 'My current location',
        ),
      ));
    });
    _getNearby();
    getMeetings();
  }

  @override
  void initState() {
    apiProvider = new ApiProvider();
    liste = [];
    _getCurrentUserLocation();

    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Container(
        height: heigth,
        width: width,
        padding: EdgeInsets.fromLTRB(0, 0, 0, heigth / 15),
        child: MaterialApp(
            home: Scaffold(
                body: Center(
                    child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _handleTap,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitudepos, longitudepos), //_center,
                zoom: 12,
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomLeft,
                width: 1000,
                height: 120,
                child: Image.asset("assets/images/logoPalette.png")),
          ],
        )))));
  }

  Future _handleTap(LatLng tappedPoint) async {
    //  var meetings = await apiProvider.getMeetings(ApiProvider.addr);

    var eventMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 22)),
        'assets/markers/purplemarker2.png');

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        icon: eventMarker,
        draggable: true,
        onDragEnd: (details) {
          setState(() {
            tappedPoint = details;
          });
        },
        infoWindow: InfoWindow(
          title: 'Click here to create your event',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MyDatepicker(
                    id: user.id,
                    location: tappedPoint,
                  );
                },
              ),
            );
          },
        ),
      ));
    });
  }
}
