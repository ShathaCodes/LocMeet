import 'package:LoginFlutter/colors/colors.dart';
import 'package:LoginFlutter/models/therapist.dart';
import 'package:flutter/material.dart';

import '../api_provider.dart';

class TherapistList extends StatefulWidget {
  @override
  _TherapistListState createState() => _TherapistListState();
}

class _TherapistListState extends State<TherapistList> {
  ApiProvider apiProvider = ApiProvider();
  final ind = ApiProvider.addr;

  List therapists;

  Future initialize() async {
    therapists = await apiProvider.getTherapists(ApiProvider.addr);
    setState(() {
      therapists = therapists;
      showemail = new List(therapists.length);
      showloc = new List(therapists.length);
      shownum = new List(therapists.length);
    });
  }

  @override
  initState() {
    initialize();
    super.initState();
  }

  Widget showdetails(String details, int i) {
    return Row(
        mainAxisAlignment: (i == 0)
            ? MainAxisAlignment.start
            : (i == 1)
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: blue_base,
            ),
            child: Center(
              child: Text(
                details,
                style: new TextStyle(
                    fontFamily: 'calibre',
                    letterSpacing: 1.5,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          )
        ]);
  }

  List<bool> shownum;
  List<bool> showloc;
  List<bool> showemail;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: Column(children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: heigth / 14, left: width / 20, bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Call one of our trusty therapists!",
                style: new TextStyle(
                    fontFamily: 'Mont', fontSize: 20, color: blue_dark),
              ),
            ],
          ),
        ),
        if (therapists != null)
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: therapists.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: double.maxFinite,
                      width: width,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Image.asset(
                                      'assets/images/girl.png',
                                      scale: 4,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                therapists[index].name,
                                style: new TextStyle(
                                    fontFamily: 'calibre',
                                    letterSpacing: 1.5,
                                    fontSize: 15,
                                    color: dark),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showemail[index] = false;
                                        showloc[index] = false;
                                        if (shownum[index] == true)
                                          shownum[index] = false;
                                        else
                                          shownum[index] = true;
                                      });
                                    },
                                    child: new Align(
                                        child: Container(
                                      margin: EdgeInsets.only(left: 30),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: blue_base,
                                      ),
                                      child: Icon(Icons.call,
                                          color: Colors.white, size: 35),
                                    )),
                                  ),
                                  SizedBox(
                                    width: (width - 170) / 3 - 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showemail[index] = false;
                                        shownum[index] = false;
                                        if (showloc[index] == true)
                                          showloc[index] = false;
                                        else
                                          showloc[index] = true;
                                      });
                                    },
                                    child: new Align(
                                        child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: blue_base,
                                      ),
                                      child: Icon(Icons.place,
                                          color: Colors.white, size: 35),
                                    )),
                                  ),
                                  SizedBox(
                                    width: (width - 170) / 3 - 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        shownum[index] = false;
                                        showloc[index] = false;
                                        if (showemail[index] == true)
                                          showemail[index] = false;
                                        else
                                          showemail[index] = true;
                                      });
                                    },
                                    child: new Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(right: 30),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: blue_base,
                                          ),
                                          child: Icon(Icons.email,
                                              color: Colors.white, size: 35),
                                        )),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Container(
                                        height: heigth / 5,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: blue_dark,
                                        ),
                                        child: Center(
                                          child: Text(
                                            therapists[index].description,
                                            style: new TextStyle(
                                                fontFamily: 'calibre',
                                                letterSpacing: 1.5,
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (shownum[index] == true)
                                    showdetails(
                                        therapists[index].number.toString(), 0),
                                  if (showloc[index] == true)
                                    showdetails(therapists[index].location, 1),
                                  if (showemail[index] == true)
                                    showdetails(therapists[index].email, 2),
                                ],
                              ),
                            ]),
                      ));
                }),
          ),
      ]),
    );
  }
}
