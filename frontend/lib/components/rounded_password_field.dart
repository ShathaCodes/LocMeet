import 'package:flutter/material.dart';
import 'package:LoginFlutter/components/text_field_container.dart';
import 'package:LoginFlutter/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: blue_base,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: blue_base,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: blue_base,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
