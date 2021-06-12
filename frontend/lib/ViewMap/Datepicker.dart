import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:LoginFlutter/colors/colors.dart';
import 'package:LoginFlutter/home.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_provider.dart';

void main() {
  runApp(Datepicker());
}

class Datepicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      // hide the debug banner
      home: Datepicker(),
    );
  }
}

class MyDatepicker extends StatefulWidget {
  final int id;
  final LatLng location;

  MyDatepicker({Key key, this.id, this.location}) : super(key: key);
  @override
  _MyDatepickerState createState() => _MyDatepickerState();
}

class _MyDatepickerState extends State<MyDatepicker> {
  ApiProvider apiProvider = new ApiProvider();

  final success = SnackBar(content: Text('Your event was created!'));

  final error = SnackBar(content: Text('Your meeting was not created!'));
  final serverError = SnackBar(content: Text('Can\'t connect to the server!'));
  final ipError =
      SnackBar(content: Text('You must insert an IP! Go to settings'));

  DateTime _chosenDateTime;

  Future createEvent() async {
    final prefs = await SharedPreferences.getInstance();

    //final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it does not exist, return 0.
    final ind = ApiProvider.addr;

    if (ind != "") {
      try {
        var res = await apiProvider.addMeeting(
            DateFormat('yyyy-MM-dd HH:mm:ss').format(_chosenDateTime),
            widget.location,
            widget.id,
            ind);

        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(success);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home()));
        } else {
          print(res.statusCode);
          ScaffoldMessenger.of(context).showSnackBar(error);
        }
      } catch (err) {
        print(err);
        ScaffoldMessenger.of(context).showSnackBar(serverError);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(ipError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
            child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 400,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTime = val;
                      });
                    }),
              ),

              // Close the modal
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                      child: Text(
                        'OK',
                        style: TextStyle(
                            color: blue_light, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => {createEvent()}),
                  CupertinoButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: blue_light, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
