//import 'package:LoginFlutter/colors/colors.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:flutter/material.dart';
import '../ViewMap/ViewMapPage.dart';
import '../Calender/HomeCalendarPage.dart';
import 'package:location/location.dart';
import "package:latlong/latlong.dart";
import 'package:LoginFlutter/models/user.dart';

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
  LocationUser location;

  static var latitudepos;
  static var longitudepos;
  List liste;
  Future _getNearby() async {
    liste = await apiProvider.nearby(
        ApiProvider.addr, latitudepos, longitudepos, 2);
    setState(() {
      liste = liste;
    });

    print(liste.length);
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print("rcuperation des donnees ");
    /*print(locData.latitude);
    print(locData.longitude);*/
    //print("afffichhiiii");
    latitudepos = locData.latitude;
    longitudepos = locData.longitude;
    // print("hethom location updated");
    print(latitudepos);
    print(longitudepos);
    //liste.toString();
    //print(liste.);
    print("update location");
    user = await user.getTokenData();
    location = user.location;
    apiProvider = ApiProvider();
    location.lat = latitudepos;
    location.lng = longitudepos;

    apiProvider.updateLocation(location, ApiProvider.addr);
    print("rcuperation de la liste ");
    _getNearby();
    print(liste);
    var user1 = liste.first;
    var location1 = user.location;
    print(user1.id);
    print(location1.lat);
    print(location1.lng);
    print(liste.length);

    //user.location = location;
    //apiProvider.updateUser(user, ApiProvider.addr);
    //testtt();
    //print("hethom location updated");
    setState(() {
      latitudepos = locData.latitude;
      longitudepos = locData.longitude;
      user = user;
      liste = liste;
    });
  }

  @override
  void initState() {
    _getCurrentUserLocation();
    _getNearby();
    super.initState();

    //testtt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewMapPage(listeNearby: liste),
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
