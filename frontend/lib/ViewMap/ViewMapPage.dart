import 'package:LoginFlutter/constants.dart';
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong/latlong.dart";

//import "package:http/http.dart" as http;
//import "dart:convert" as convert;
import 'package:location/location.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/api_provider.dart';

class ViewMapPage extends StatefulWidget {
  @override
  _ViewMapPageState createState() => _ViewMapPageState();
}

class _ViewMapPageState extends State<ViewMapPage> {
  final String apiKey = "WdAPCVBEOA5pUAPJ549Tb6L8hud8nNxK";

  double latitudepos;
  double longitudepos;
  bool _isGettingLocation;

  User user = new User();
  ApiProvider apiProvider;
  LocationUser location = new LocationUser();

  /*var latitudepos = 35.6852;
  var longitudepos = 10.5343;*/

  /*var latitudepos = 36.8065;
  var longitudepos = 10.1815; //tunis*/

  var myItems = [
    ["jar 1", 35.6830, 10.5618],
    ["jar 2", 35.6852, 10.5343],
  ];

  List<Marker> barchaMarkers = [];

  Future<void> _addMarkes() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    setState(() {
      latitudepos = locData.latitude;
      longitudepos = locData.longitude;
      _isGettingLocation = false;

      barchaMarkers.add(new Marker(
        width: 80.0,
        height: 80.0,
        point: new LatLng(latitudepos, longitudepos),
        builder: (BuildContext context) =>
            const Icon(Icons.location_on, size: 40.0, color: danger),
      ));
      for (int i = 0; i < myItems.length; i++) {
        var item = myItems[i];
        barchaMarkers.add(new Marker(
          width: 70.0,
          height: 70.0,
          point: new LatLng(item[1], item[2]),
          builder: (BuildContext context) =>
              const Icon(Icons.location_on, size: 35.0, color: blue_base),
        ));
      }
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    setState(() {
      latitudepos = locData.latitude;
      longitudepos = locData.longitude;
      _isGettingLocation = false;
    });
  }

  /* testtt() async {
    print("test tekhdem");
    user = await user.getTokenData();
    apiProvider = ApiProvider();
    location.lat = latitudepos;
    location.lng = longitudepos;
    print("hethom location updated");
    print(location.lng);
    print(location.lat);
    //apiProvider.updateLocation(location, "localhost");
    user.location = location;
    //apiProvider.updateUser(user, "localhost");
    setState(() {
      user = user;
    });
  }*/

  @override
  void initState() {
    super.initState();
    _isGettingLocation = true;
    _getCurrentUserLocation();
    //testtt();
    _addMarkes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tomtomHQ = new LatLng(latitudepos, longitudepos);
    return _isGettingLocation
        ? Center(child: CircularProgressIndicator())
        : MaterialApp(
            //return MaterialApp(
            title: "TomTom Map",
            home: Scaffold(
              body: Center(
                  child: Stack(
                children: <Widget>[
                  FlutterMap(
                    options: new MapOptions(center: tomtomHQ, zoom: 13.0),
                    layers: [
                      new TileLayerOptions(
                        urlTemplate:
                            "https://api.tomtom.com/map/1/tile/basic/main/"
                            "{z}/{x}/{y}.png?key={apiKey}",
                        additionalOptions: {"apiKey": apiKey},
                      ),
                      new MarkerLayerOptions(markers: barchaMarkers),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.bottomLeft,
                      width: 1000,
                      height: 120,
                      child: Image.asset("assets/images/logoPalette.png"))
                ],
              )),
            ),
          );
  }
}
