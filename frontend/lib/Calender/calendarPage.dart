import 'package:LoginFlutter/api_provider.dart';
import 'package:LoginFlutter/models/location.dart';
import 'package:LoginFlutter/models/meeting.dart';
import 'package:LoginFlutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:LoginFlutter/constants.dart';

class CalendarPage extends StatefulWidget {
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  User user = new User();
  ApiProvider apiProvider;
  List joinedMeetings = new List();
  List myMeetings = new List();
  List showMeetings = new List();

  @override
  void initState() {
    testtt();
    super.initState();
  }

  testtt() async {
    user = await user.getTokenData();
    apiProvider = ApiProvider();

    List meetings = await apiProvider.getMeetings(ApiProvider.addr);
    for (Meeting m in meetings) {
      if (m.creator.id == user.id)
        myMeetings.add(m);
      else
        for (User u in m.guests) if (u.id == user.id) joinedMeetings.add(m);
    }
    for (Meeting m in myMeetings)
      if (m.date.month == _focusedDay.month) showMeetings.add(m);
    for (Meeting m in joinedMeetings) {
      if (m.date.month == _focusedDay.month) showMeetings.add(m);
    }
    setState(() {
      user = user;
      myMeetings = myMeetings;
      joinedMeetings = joinedMeetings;
      showMeetings = showMeetings;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final kNow = DateTime.now();
    final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
    final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 15),
            child: Column(children: [
              Stack(
                children: [
                  Positioned(
                      top: 57,
                      child: Container(
                        width: width - (width / 7.5),
                        height: height * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5.5)),
                      )),
                  TableCalendar(
                    sixWeekMonthsEnforced: true,
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: blue_base,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        selectedDecoration: BoxDecoration(
                            color: jaunepastel,
                            borderRadius: BorderRadius.circular(4)),
                        markerDecoration: BoxDecoration(
                            color: blue_dark, shape: BoxShape.circle),
                        markersAnchor: 6),

                    firstDay: kFirstDay,
                    headerStyle: HeaderStyle(
                      leftChevronIcon:
                          Icon(Icons.chevron_left, color: blue_base),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: blue_base),
                      headerPadding: EdgeInsets.symmetric(vertical: 5.0),
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    rowHeight: height / 20,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    daysOfWeekVisible: false,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      showMeetings = new List();
                      for (Meeting m in myMeetings)
                        if (m.date.month == focusedDay.month)
                          showMeetings.add(m);
                      for (Meeting m in joinedMeetings)
                        if (m.date.month == focusedDay.month)
                          showMeetings.add(m);
                      setState(() {
                        _focusedDay = focusedDay;
                        showMeetings = showMeetings;
                      });
                    },
                    //just to test the events ui
                    eventLoader: (day) {
                      List l = [];
                      for (Meeting meeting in myMeetings)
                        if (isSameDay(meeting.date, day)) l.add(meeting);
                      for (Meeting meeting in joinedMeetings)
                        if (isSameDay(meeting.date, day)) l.add(meeting);
                      return l;
                    },
                  ),
                ],
              ),
              Expanded(
                  child: Column(children: [
                SizedBox(height: height / 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(DateFormat('MMMM').format(_focusedDay) + "'s Events",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: height / 40),
                if (showMeetings.length > 0)
                  Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: showMeetings.length,
                          itemBuilder: (contexti, index) {
                            return Padding(
                                padding: EdgeInsets.only(bottom: height / 50),
                                child: Stack(children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              DateFormat('MMMM')
                                                  .format(_focusedDay),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)),
                                          SizedBox(
                                            height: height / 100,
                                          ),
                                          Text(
                                              DateFormat('d').format(
                                                  showMeetings[index].date),
                                              style: TextStyle(
                                                  color: blue_base,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))
                                        ],
                                      ),
                                      SizedBox(
                                        width: width / 50,
                                      ),
                                      Container(
                                          width: 5.5,
                                          height: 37,
                                          decoration: BoxDecoration(
                                            color: blue_base,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(2.5),
                                                bottomRight:
                                                    Radius.circular(2.5)),
                                          )),
                                      SizedBox(
                                        width: width / 30,
                                      ),
                                      if (!myMeetings
                                          .contains(showMeetings[index]))
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                showMeetings[index]
                                                        .creator
                                                        .nickname +
                                                    "'s event",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: height / 100,
                                            ),
                                            Text(
                                                DateFormat('jm').format(
                                                    showMeetings[index].date),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10)),
                                          ],
                                        ),
                                      if (myMeetings
                                          .contains(showMeetings[index]))
                                        GestureDetector(
                                          onTap: () {
                                            print("hahahahahaha");
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("My Event",
                                                  style: TextStyle(
                                                      color: blue_base,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: height / 100,
                                              ),
                                              Text(
                                                  DateFormat('jm').format(
                                                      showMeetings[index].date),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10)),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.close,
                                              color: blue_base),
                                          onPressed: () async {
                                            if (!myMeetings.contains(
                                                showMeetings[index])) {
                                              await apiProvider.abandonMeeting(
                                                  showMeetings[index].id,
                                                  user.id,
                                                  ApiProvider.addr);
                                              joinedMeetings
                                                  .remove(showMeetings[index]);
                                            } else {
                                              await apiProvider.deleteMeeting(
                                                  showMeetings[index].id,
                                                  ApiProvider.addr);
                                              myMeetings
                                                  .remove(showMeetings[index]);
                                            }

                                            showMeetings.removeAt(index);
                                            setState(() {
                                              joinedMeetings = joinedMeetings;
                                              showMeetings = showMeetings;
                                              myMeetings = myMeetings;
                                            });
                                          })
                                    ],
                                  )
                                ]));
                          })),
                SizedBox(height: height / 9)
              ])),
            ])));
  }
}
