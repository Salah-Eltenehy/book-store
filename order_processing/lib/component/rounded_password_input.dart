import 'package:flutter/material.dart';
import '../Constants.dart';
import 'input_container.dart';

class RoundedPasswordInput extends StatefulWidget {
  static TextEditingController PASSWORD = TextEditingController();
  @override
  _RoundedPasswordInputState  createState() => _RoundedPasswordInputState ();
}

class _RoundedPasswordInputState extends State<RoundedPasswordInput> {
  var obsecuretext = true;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextField(
          cursorColor: kPrimaryColor,
          controller: RoundedPasswordInput.PASSWORD,
          decoration: InputDecoration(
              icon: Icon(Icons.lock, color: kPrimaryColor),
              suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    obsecuretext = !obsecuretext;
                  });
                },
                child: Icon(obsecuretext ? Icons.visibility : Icons.visibility_off),
              ),
              hintText: "Password",
              border: InputBorder.none
          ),
          obscureText: obsecuretext,
        )
    );
  }
}