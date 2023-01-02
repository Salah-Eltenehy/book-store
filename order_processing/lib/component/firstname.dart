import 'package:flutter/material.dart';
import 'input_container.dart';

import '../Constants.dart';


class FirstName extends StatelessWidget {
  const FirstName({
    Key? key,
    required this.icon,
    required this.hint
  }) : super(key: key);

  final IconData icon;
  final String hint;
  static TextEditingController Text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextField(
          cursorColor: kPrimaryColor,
          controller: Text,
          decoration: InputDecoration(
              icon: Icon(icon, color: kPrimaryColor),
              hintText: hint,
              border: InputBorder.none
          ),
        ));
  }
}