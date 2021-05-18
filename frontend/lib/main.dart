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
