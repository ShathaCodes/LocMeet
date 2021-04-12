import 'package:LoginFlutter/colors/colors.dart';
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong/latlong.dart";
//import "package:http/http.dart" as http;
//import "dart:convert" as convert;
import 'package:location/location.dart';

class ViewMapPage extends StatefulWidget {
  @override
  _ViewMapPageState createState() => _ViewMapPageState();
}

class _ViewMapPageState extends State<ViewMapPage> {
  final String apiKey = "WdAPCVBEOA5pUAPJ549Tb6L8hud8nNxK";
  var latitudepos;
  var longitudepos;
  //CalendarController _controller;
  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    latitudepos = locData.latitude;
    longitudepos = locData.longitude;
    setState(() {
      latitudepos = locData.latitude;
      longitudepos = locData.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tomtomHQ = new LatLng(35.8245029, 10.634584);
    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        body: Center(
            child: Stack(
          children: <Widget>[
            FlutterMap(
              options: new MapOptions(center: tomtomHQ, zoom: 13.0),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  additionalOptions: {"apiKey": apiKey},
                ),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      width: 80.0,
                      height: 80.0,
                      point: new LatLng(35.8245029, 10.634584),
                      builder: (BuildContext context) => const Icon(
                          Icons.location_on,
                          size: 40.0,
                          color: danger),
                    ),
                  ],
                ),
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
