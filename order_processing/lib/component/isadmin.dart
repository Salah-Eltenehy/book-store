

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'package:order_processing/component/input_container.dart';

class isadmin extends StatefulWidget {
  static bool? isAdmin = false;
  @override
  _isadminState  createState() => _isadminState ();
}

class _isadminState extends State <isadmin> {

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile( //checkbox positioned at left
                value: isadmin.isAdmin,
                checkColor: Colors.white,
                activeColor: kPrimaryColor,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  setState(() {
                    isadmin.isAdmin = value;
                  });
                },
                title: Text("System Admin?"),
              ),
            ],
          )
      ),
    );
  }
}
