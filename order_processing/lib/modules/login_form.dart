

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/modules/constants.dart';

class LoginForm extends StatelessWidget{
   const LoginForm({
   Key? key,

 }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(
       horizontal:MediaQuery.of(context).size.width* 0.13
        ),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 1,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Email address",
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
            ),
             Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.yellow.shade700,
              ),
              padding: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Text(
                'Log In',
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }


}