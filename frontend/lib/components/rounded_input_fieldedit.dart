import 'package:flutter/material.dart';
import 'package:LoginFlutter/components/text_field_container.dart';
import 'package:LoginFlutter/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String> onChanged;
  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        cursorColor: blue_base,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: blue_base,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
