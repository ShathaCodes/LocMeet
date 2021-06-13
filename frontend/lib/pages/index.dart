import 'package:flutter/material.dart';
import 'package:LoginFlutter/Screens/Welcome/components/body.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocMeet',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Body(),
      ),
    );
  }
}
