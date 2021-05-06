import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:LoginFlutter/constants.dart';
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
  ApiProvider apiProvider = ApiProvider();

  ///apiProvider
  LocationUser location;

  static var latitudepos;
  static var longitudepos;
  List<User> liste;
  Future _getNearby() async {
    final locData = await Location().getLocation();
    latitudepos = locData.latitude;
    longitudepos = locData.longitude;
    print("fucccckkkkkkkkk");
    print(latitudepos);
    print(longitudepos);
    liste = await apiProvider.nearby(ApiProvider.addr, 10, 10, 30);
    print("fucccckkkkkkkkk222222222222222");
    print(liste.length);

    setState(() {
      liste = liste;
    });
    print("fucccckkkkkkkkk33333333333333333");
    print(liste.length);
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print("rcuperation des donnees ");
    latitudepos = locData.latitude;
    longitudepos = locData.longitude;
    print(latitudepos);
    print(longitudepos);
    print("update location");
    user = await user.getTokenData();
    location = user.location;
    location.lat = latitudepos;
    location.lng = longitudepos;

    apiProvider.updateLocation(location, ApiProvider.addr);

    print("jirenek ya zaaah othehrou plz ");
    //_getNearby();
    print("apres la fnct getNeraby");
    /*print(liste.length);
    var user1 = liste.first;
    var location1 = user1.location;
    print(user1.id);
    print(location1.lat);
    print(location1.lng);
    print(liste.length);*/
    setState(() {
      latitudepos = locData.latitude;
      longitudepos = locData.longitude;
      user = user;
      //liste = liste;
    });
  }

  void _initialiser() async {
    await _getCurrentUserLocation();
    await _getNearby();
    setCustomMarker();
  }

  @override
  void initState() {
    _initialiser();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();
  //static const LatLng _center = const LatLng(36.7438, 10.3099);

  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  var myItems = [
    ["jar 1", 35.6830, 10.5618],
    ["jar 2", 35.6852, 10.5343],
  ];

  /*@override
  void initState() {
    super.initState();
    setCustomMarker();
  }*/

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/jfdn.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(latitudepos, longitudepos), //_center,
        //icon: mapMarker,
        infoWindow: InfoWindow(
          title: 'darMaissa',
          snippet: 'A historical fvejdsbj ',
        ),
      ));
      for (int i = 0; i < liste.length; i++) {
        var item = liste[i];
        //var user1 = liste.first;
        var location1 = item.location;
        print(item.nickname);
        print(location1.id);

        _markers.add(new Marker(
          markerId: MarkerId('id-' + (i + 2).toString()),
          position:
              LatLng(location1.lat, location1.lng), //LatLng(item[1], item[2]),
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
              onPressed: () {
                _getNearby();
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
