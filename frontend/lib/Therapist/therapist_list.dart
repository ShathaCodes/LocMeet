//import 'package:LoginFlutter/colors/colors.dart';
import 'package:LoginFlutter/constants.dart';
import 'package:LoginFlutter/models/therapist.dart';
import 'package:flutter/material.dart';

import '../api_provider.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

//import 'package:url_launcher/url_launcher.dart';

const _url = 'https://flutter.dev';

class TherapistList extends StatefulWidget {
  @override
  _TherapistListState createState() => _TherapistListState();
}

class _TherapistListState extends State<TherapistList> {
  TextEditingController _numberCtrl = new TextEditingController();
  Future<void> _launched;
  ApiProvider apiProvider = ApiProvider();
  final ind = ApiProvider.addr;

  List therapists;

  Future initialize() async {
    therapists = await apiProvider.getTherapists(ApiProvider.addr);
    setState(() {
      therapists = therapists;
    });
  }

  /*launchUrl(url) {
    launch(url);
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  @override
  initState() {
    initialize();
    super.initState();
    _numberCtrl.text = "085921191121";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
        body: Column(
      children: <Widget>[
        if (therapists != null)
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: therapists.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                            color: blue_base,

                            // color: Theme.of(context).cardColor,
                            height: height * 0.4,
                            width: width),
                        Container(
                            height: height,
                            padding: EdgeInsets.only(top: height / 6),
                            color: Colors.transparent,
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: height / 13, left: width / 3),
                                    child: Text(
                                      therapists[index].name,
                                      style: TextStyle(
                                          color: blue_dark,
                                          fontSize: width / 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 2,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: height / 6.5, left: width / 20),
                                    child: Text(
                                      "Description :",
                                      style: TextStyle(
                                          fontSize: width / 22,
                                          fontWeight: FontWeight.bold,
                                          color: blue_base),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: height / 5.2, left: width / 20),
                                    child: Text(
                                      therapists[index].description,
                                      style: TextStyle(
                                        fontSize: width / 30,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: height / 3.9, left: width / 20),
                                    child: Center(
                                        child: Card(
                                            //color: Colors.grey[100],
                                            //margin: EdgeInsets.fromLTRB( 0.0, 45.0, 0.0, 0.0),
                                            child: Container(
                                                width: width / 1.2,
                                                height: height / 2,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      height / 40),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.phone,
                                                            color: blue_base,
                                                            size: height / 22,
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          SizedBox(
                                                            height: height / 50,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Phone",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  //color: blue_dark,
                                                                ),
                                                              ),
                                                              Text(
                                                                therapists[
                                                                        index]
                                                                    .number
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: height / 40,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.home,
                                                            color: blue_base,
                                                            size: height / 22,
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          SizedBox(
                                                            height: height / 50,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Adresse",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                therapists[
                                                                        index]
                                                                    .location,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: height / 40,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.mail,
                                                            color: blue_base,
                                                            size: height / 22,
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          SizedBox(
                                                            height: height / 50,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Email",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                therapists[
                                                                        index]
                                                                    .email,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )))),
                                  ),
                                ],
                              ),
                              width: width,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(40.0),
                                  topRight: const Radius.circular(40.0),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                bottom: height / 8,
                                left: width / 20,
                                right: width / 20,
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: jaunepastel.withOpacity(0.8),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(width / 5.3,
                                    height / 35), // changes position of shadow
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/girl.png'),
                            radius: width / 8,
                          ),
                          padding: EdgeInsets.only(
                              top: height / 20, left: width / 2.6),
                        ),
                      ],
                    );
                  }))
      ],
    ));
  }
}
