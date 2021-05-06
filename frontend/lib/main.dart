import 'package:flutter/material.dart';
import './pages/index.dart';
import 'package:LoginFlutter/Therapist/TherapistSwipe.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Node server demo',
        debugShowCheckedModeBanner: false,
        //home: TherapistSwipe());
        home: Index());
    //home: WelcomeScreen());
  }
}
/*
import 'dart:async';
//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();

//initial point sur le map MapPositionInitiale
  //static const LatLng _center = const LatLng(45.521563, -122.677433);
  static const LatLng _center = const LatLng(36.7438, 10.3099);

  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  var myItems = [
    ["jar 1", 35.6830, 10.5618],
    ["jar 2", 35.6852, 10.5343],
  ];

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/jfdn.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(35.6941, 10.5446), //_center,
        //icon: mapMarker,
        infoWindow: InfoWindow(
          title: 'darMaissa',
          snippet: 'A historical fvejdsbj ',
        ),
      ));
      for (int i = 0; i < myItems.length; i++) {
        var item = myItems[i];
        //var user = liste[i];
        _markers.add(new Marker(
          markerId: MarkerId('id-' + (i + 2).toString()),
          position: LatLng(item[1], item[2]),
          //icon: Icons.home,
          infoWindow: InfoWindow(
            title: 'JArMaissa',
            snippet: 'A historical fvejdsbj ',
          ),
        ));
      }
    });
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(35.6941, 10.5446), //_center,
            zoom: 15,
          ),
        ),
      ),
    );
  }
}*/
