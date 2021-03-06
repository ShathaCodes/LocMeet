import 'package:LoginFlutter/constants.dart';
import 'package:flutter/material.dart';

class FilterChipDisplay extends StatefulWidget {
  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}),
        title: Text(
          "Filter Result",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {
            //
          }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer("Choose amenities"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Wrap(
                spacing: 5.0,
                runSpacing: 3.0,
                children: <Widget>[
                  filterChipWidget(chipName: 'Elevator'),
                  filterChipWidget(chipName: 'Washer/Dryer'),
                  filterChipWidget(chipName: 'Fireplace'),
                  filterChipWidget(chipName: 'Dogs ok'),
                  filterChipWidget(chipName: 'Cats ok'),
                  filterChipWidget(chipName: 'Wheelchair access'),
                ],
              )),
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer('Choose Neighborhoods'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: <Widget>[
                    filterChipWidget(chipName: 'Upper Manhattan'),
                    filterChipWidget(chipName: 'Manhattanville'),
                    filterChipWidget(chipName: 'Harlem'),
                    filterChipWidget(chipName: 'Washington Heights'),
                    filterChipWidget(chipName: 'Inwood'),
                    filterChipWidget(chipName: 'Morningside Heights'),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;
  bool selected;
  final int id;
  List sth = [];

  filterChipWidget({Key key, this.chipName, this.id, this.sth, this.selected})
      : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      selected: widget.selected,
      labelStyle: TextStyle(
          color: blue_dark, fontSize: 23, fontWeight: FontWeight.bold),
      disabledColor: jaunepastel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      avatar: CircleAvatar(
        backgroundImage:
            AssetImage('assets/images/' + widget.chipName.trim() + '.png'),
        backgroundColor: Colors.white,
      ),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          if (widget.selected == false) {
            widget.sth.add(widget.chipName);
            print(widget.sth);

            widget.selected = true;
          } else {
            widget.selected = false;
            widget.sth.remove(widget.chipName);
            print(widget.sth);
          }
        });
      },
      selectedColor: blue_base,
      checkmarkColor: jaunepastel,
      backgroundColor: jaunepastel,
    );
  }
}
