

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order_processing/screen/Account.dart';
import '../Constants.dart';
import '../component/Username.dart';
import '../component/firstname.dart';
import '../component/rounded_input.dart';
import '../component/rounded_password_input.dart';
import '../component/rounded_phone.dart';
import '../component/secondname.dart';
import '../screen/MainApp.dart';

class Login extends StatefulWidget {
  static late Map<String, dynamic> data;
  @override
  loginrequest createState() => loginrequest();
}

class loginrequest extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () async{
        if(RoundedInput.Text.text.isEmpty)
          {
            showAlertDialog(context,"Check your Email");
            RoundedInput.Text.clear();
            RoundedPasswordInput.PASSWORD.clear();
          }
        else if( RoundedPasswordInput.PASSWORD.text.isEmpty)
          {
            showAlertDialog(context,"Check your Password");
            RoundedInput.Text.clear();
            RoundedPasswordInput.PASSWORD.clear();
          }
        else
          {
            String _url =
                "http://${ip}:8080/bookstore/login";
            var res = await http.post(Uri.parse(_url),
                headers: {"Content-Type": "application/json"},
                body: json.encode({
                  "username" : RoundedInput.Text.text,
                  "password": RoundedPasswordInput.PASSWORD.text,
                }));
            print(res.statusCode);
            if(res.statusCode!=200)
            {
              print(res.body);
              showAlertDialog(context,"Check your inputs");
              RoundedInput.Text.clear();
              RoundedPasswordInput.PASSWORD.clear();
            }
            else
            {
              setState(() => Login.data = json.decode(res.body));
              Account.data = Login.data;
              print(res.body);
              Account.Oldusername = RoundedInput.Text.text;
              Account.Oldpassword =RoundedPasswordInput.PASSWORD.text;
              RoundedInput.Text.clear();
              RoundedPasswordInput.PASSWORD.clear();
              MainApp.Manger = Login.data['is_manager'];
              RoundedInput.Text.clear();
              RoundedPasswordInput.PASSWORD.clear();
              MainApp.intializeBooks();
              MainApp.update();
              Navigator.popAndPushNamed(context, "/app");
            }
          }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kPrimaryColor,
        ),

        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18
          ),
        ),
      ),
    );
  }

}
showAlertDialog(BuildContext context, text3) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert!"),
        content: Text(text3),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ));
}