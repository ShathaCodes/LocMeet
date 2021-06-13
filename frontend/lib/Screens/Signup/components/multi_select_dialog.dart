import 'package:flutter/material.dart';
import 'package:LoginFlutter/constants.dart';

/// A Custom Dialog that displays a single question & list of answers.
class MultiSelectDialog extends StatelessWidget {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: jaunepastel,
    //primary: blue_base,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  /// List to display the answer.
  final List<String> answers;

  /// Widget to display the question.
  final Widget question;

  /// List to hold the selected answer
  /// i.e. ['a'] or ['a','b'] or ['a','b','c'] etc.
  final List<String> selectedItems = [];

  /// Map that holds selected option with a boolean value
  /// i.e. { 'a' : false}.
  static Map<String, bool> mappedItem;

  MultiSelectDialog({this.answers, this.question});

  /// Function that converts the list answer to a map.
  Map<String, bool> initMap() {
    return mappedItem = Map.fromIterable(answers,
        key: (k) => k.toString(),
        value: (v) {
          if (v != true && v != false)
            return false;
          else
            return v as bool;
        });
  }

  @override
  Widget build(BuildContext context) {
    if (mappedItem == null) {
      initMap();
    }
    return SimpleDialog(
      title: question,
      children: [
        ...mappedItem.keys.map((String key) {
          return StatefulBuilder(
            builder: (_, StateSetter setState) => CheckboxListTile(
                selectedTileColor: blue_dark,
                //checkColor: Colors.black54,
                title: Text(key), // Displays the option
                value: mappedItem[key], // Displays checked or unchecked value
                controlAffinity: ListTileControlAffinity.platform,
                onChanged: (value) => setState(() => mappedItem[key] = value)),
          );
        }).toList(),
        Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                style: raisedButtonStyle,
                child: Text(
                  'Submit',
                ),
                onPressed: () {
                  // Clear the list
                  selectedItems.clear();

                  // Traverse each map entry
                  mappedItem.forEach((key, value) {
                    if (value == true) {
                      selectedItems.add(key);
                    }
                  });

                  // Close the Dialog & return selectedItems
                  Navigator.pop(context, selectedItems);
                }))
      ],
    );
  }
}
