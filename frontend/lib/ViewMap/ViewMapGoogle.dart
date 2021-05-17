import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:LoginFlutter/models/user.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/api_provider.dart';
import 'package:location/location.dart';

class ViewMapGoogle extends StatefulWidget {
  @override
  _ViewMapGoogleState createState() => _ViewMapGoogleState();
}

class _ViewMapGoogleState extends State<ViewMapGoogle> {
  User user = new User();
  ApiProvider apiProvider;

  LocationUser location;

  static var latitudepos;
  static var longitudepos;
  List<User> liste;

  Future _getNearby() async {
    liste = await apiProvider.nearby(
        ApiProvider.addr, latitudepos, longitudepos, 5);
    print("nearby------" + liste.length.toString());
    var lol = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 22)),
        'assets/markers/darkbluemarker2.png');
    setState(() {
      liste = liste;
      if (liste != null)
        for (int i = 0; i < liste.length; i++) {
          var userr = liste[i];
          if (userr.id != user.id) {
            String interests = "";
            for (var interest in userr.interests) interests += interest.name;
            print("nearby------" + userr.location.lat.toString());

            _markers.add(new Marker(
              markerId: MarkerId('id-' + (i + 2).toString()),
              icon: lol,
              position: LatLng(userr.location.lat, userr.location.lng),
              infoWindow: InfoWindow(
                title: user.nickname,
                snippet: interests,
              ),
            ));
          }
        }
    });
  }

  BitmapDescriptor mapMarker;

  Future<void> _getCurrentUserLocation() async {
    print("CurrentUserLocation-------localization");
    //var locdata = LatLng(36.7433, 10.3081);
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
        ImageConfiguration(size: Size(0.0005, 0.0007)),
        'assets/markers/redmarker2.png');

    setState(() {
      latitudepos = latitudepos;
      longitudepos = longitudepos;
      user = user;
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(latitudepos, longitudepos), //_center,
        icon: mapMarker,

        infoWindow: InfoWindow(
          title: 'Me',
          snippet: 'My current location',
        ),
      ));
    });
    _getNearby();
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
            FloatingActionButton(
              onPressed: () async {
                print("test----");
                var test = await Location().getLocation();
                print("test----" + test.toString());
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
          ],
        )))));
  }
}
