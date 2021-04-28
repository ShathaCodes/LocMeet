import 'package:LoginFlutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../api_provider.dart';

class TherapistSwipe extends StatefulWidget {
  List therapists;
  TherapistSwipe({Key key, this.therapists}) : super(key: key);
  @override
  _TherapistSwipeState createState() => _TherapistSwipeState();
}

class _TherapistSwipeState extends State<TherapistSwipe> {
  ApiProvider apiProvider = ApiProvider();
  final ind = ApiProvider.addr;
  List therapists; // = widget.therapists;
  var pages1;
  var pagess;

  Future initialize() async {
    therapists = await apiProvider.getTherapists(ApiProvider.addr);
    setState(() {
      therapists = therapists;
    });
  }

  static const TextStyle goldcoinGreyStyle = TextStyle(
      color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold);
  //fontFamily: "Product Sans");

  static const TextStyle goldCoinWhiteStyle = TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);
  //fontFamily: "Product Sans");

  static const TextStyle greyStyle = TextStyle(
      fontSize: 40.0, color: Colors.grey); //fontFamily: "Product Sans");
  static const TextStyle whiteStyle = TextStyle(
      fontSize: 40.0, color: Colors.white); //, fontFamily: "Product Sans");

  static const TextStyle boldStyle = TextStyle(
    fontSize: 50.0,
    color: Colors.black,
    //fontFamily: "Product Sans",
    fontWeight: FontWeight.bold,
  );

  static const TextStyle descriptionGreyStyle = TextStyle(
    color: Colors.grey,
    fontSize: 20.0,
    // fontFamily: "Product Sans",
  );

  static const TextStyle descriptionWhiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    //fontFamily: "Product Sans",
  );
  //final ,

  var pages = [
    //if (therapists != null)
    Container(
      color: jaunepastel,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "GoldCoin",
                  style: goldcoinGreyStyle,
                ),
                Text(
                  "Skip",
                  style: goldcoinGreyStyle,
                ),
              ],
            ),
          ),
          Image.asset('assets/images/girl.png'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Online",
                  style: greyStyle,
                ),
                Text(
                  "Gambling",
                  style: boldStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Temporibus autem aut\n"
                  "officiis debitis aut rerum\n"
                  "necessitatibus",
                  style: descriptionGreyStyle,
                ),
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: blue_base,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "GoldCoin",
                  style: goldCoinWhiteStyle,
                ),
                Text(
                  "Skip",
                  style: goldCoinWhiteStyle,
                ),
              ],
            ),
          ),
          Image.asset('assets/images/girl.png'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Online",
                  style: whiteStyle,
                ),
                Text(
                  "Gaming",
                  style: boldStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Excepteur sint occaecat cupidatat\n"
                  "non proident, sunt in\n"
                  "culpa qui officia",
                  style: descriptionWhiteStyle,
                ),
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: jaunepastel, // Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "GoldCoin",
                  style: goldCoinWhiteStyle,
                ),
                Text(
                  "Skip",
                  style: goldCoinWhiteStyle,
                ),
              ],
            ),
          ),
          Image.asset('assets/images/girl.png'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Online",
                  style: whiteStyle,
                ),
                Text(
                  "Gambling",
                  style: boldStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Temporibus autem aut\n"
                  "officiis debitis aut rerum\n"
                  "necessitatibus",
                  style: descriptionWhiteStyle,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  ];

  @override
  void initState() {
    initialize();
    pages1 = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: therapists.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: double.maxFinite,
              //width: width,
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
                              setState(() {});
                            },
                            child: new Align(
                                child: Container(
                              margin: EdgeInsets.only(left: 30),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: blue_base,
                              ),
                              child: Icon(Icons.call,
                                  color: Colors.white, size: 35),
                            )),
                          ),
                          SizedBox(
                              //width: (width - 170) / 3 - 30,
                              ),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: new Align(
                                child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: blue_base,
                              ),
                              child: Icon(Icons.place,
                                  color: Colors.white, size: 35),
                            )),
                          ),
                          SizedBox(
                              //width: (width - 170) / 3 - 30,
                              ),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: new Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
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
                                //height: heigth / 5,
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
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
                        ],
                      ),
                    ]),
              ));
        });
    //);
    /*if (pages1 != null) {
      pagess = pages1;
    } else {
      pagess = pages;
    }*/

    pagess = pages;
    print(therapists.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    therapists = widget.therapists;
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            child: LiquidSwipe(
              pages: pagess,
              enableLoop: true,
              fullTransitionValue: 300,
              enableSlideIcon: true,
              waveType: WaveType.liquidReveal,
              positionSlideIcon: 0.5,
            ),
          ),
        // ]),
        /*Scaffold(
          body: //Column(children: <Widget>
              //if (therapists != null)
              LiquidSwipe(
            pages: pagess,
            enableLoop: true,
            fullTransitionValue: 300,
            enableSlideIcon: true,
            waveType: WaveType.liquidReveal,
            positionSlideIcon: 0.5,
          ),*/
        // ]),
      ])),
    );
  }
}
