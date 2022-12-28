import 'package:flutter/material.dart';

import 'input_container.dart';

class RoundedPhoneNumber extends StatelessWidget {
  const RoundedPhoneNumber({Key? key, required this.icon,required this.color, required this.hint})
      : super(key: key);
  final Color color;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        cursorColor: color,
        decoration: InputDecoration(
            icon: Icon(icon, color: color),
            hintText: hint,
            border: InputBorder.none),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
