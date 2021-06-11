import 'package:flutter/material.dart';

import 'package:LoginFlutter/Screens/Welcome/components/body.dart';
import 'package:LoginFlutter/Therapist/therapistSwipe.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginFlutter',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Body(),
        //body: TherapistSwipe(),
      ),
    );
  }
}
