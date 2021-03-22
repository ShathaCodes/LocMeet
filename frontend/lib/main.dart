import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './pages/login.dart';
import './colors/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Node server demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: accentColor,
        ),
        home: Login());
  }
}
