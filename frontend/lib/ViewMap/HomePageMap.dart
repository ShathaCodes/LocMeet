//import 'package:LoginFlutter/colors/colors.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:flutter/material.dart';
import '../ViewMap/ViewMapPage.dart';
import '../Calender/HomeCalendarPage.dart';
import 'package:location/location.dart';
import "package:latlong/latlong.dart";
import 'package:LoginFlutter/models/user.dart';

import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/api_provider.dart';

class HomePageMap extends StatefulWidget {
  static var lat = _HomePageMapState.latitudepos;
  static var long = _HomePageMapState.longitudepos;
  @override
  _HomePageMapState createState() => _HomePageMapState();
}

class _HomePageMapState extends State<HomePageMap> {
  User user = new User();
  ApiProvider apiProvider;
  //LocationUser location = new LocationUser();
  LocationUser location;

  static var latitudepos;
  static var longitudepos;

  /*testtt() async {
    print("test tekhdem");
    user = await user.getTokenData();
    apiProvider = ApiProvider();
    location.lat = latitudepos;
    location.lng = longitudepos;
    print("hethom location updated");
    print(location.lng);
    print(location.lat);
    apiProvider.updateLocation(location, "localhost");
    user.location = location;
    apiProvider.updateUser(user, "localhost");
    setState(() {
      user = user;
    });
  }*/

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    /*print(locData.latitude);
    print(locData.longitude);*/
    print("afffichhiiii");
    latitudepos = locData.latitude;
    longitudepos = locData.longitude;
    print("hethom location updated");
    print(latitudepos);
    print(longitudepos);

    user = await user.getTokenData();
    location = user.location;
    apiProvider = ApiProvider();
    location.lat = latitudepos;
    location.lng = longitudepos;

    apiProvider.updateLocation(location, ApiProvider.addr);

    //user.location = location;
    //apiProvider.updateUser(user, ApiProvider.addr);
    //testtt();
    //print("hethom location updated");
    setState(() {
      latitudepos = locData.latitude;
      longitudepos = locData.longitude;
      user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserLocation();
    //testtt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewMapPage(),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 500,
          ),
          FloatingActionButton(
            onPressed: () {
              _getCurrentUserLocation();
            },
            child: Container(
              width: 60,
              height: 60,
              child: Icon(Icons.search),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            heroTag: null,
          )
        ]));
  }
}
