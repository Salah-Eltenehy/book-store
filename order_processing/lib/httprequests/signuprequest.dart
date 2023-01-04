

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order_processing/component/findlocation_Map.dart';
import '../Constants.dart';
import '../component/Username.dart';
import '../component/firstname.dart';
import '../component/rounded_input.dart';
import '../component/rounded_password_input.dart';
import '../component/rounded_phone.dart';
import '../component/secondname.dart';
import '../screen/Account.dart';
import '../screen/MainApp.dart';

class Signup extends StatefulWidget {
  static late Map<String, dynamic> data;
  @override
  signuprequest createState() => signuprequest();
}

class signuprequest extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () async{
         if(RoundedInput.Text.text.isEmpty)
           {
             showAlertDialog(context,"Check your Email");
             RoundedInput.Text.clear();
           }
         else if(RoundedPasswordInput.PASSWORD.text.isEmpty )
           {
             showAlertDialog(context,"Check your Email");
             RoundedPasswordInput.PASSWORD.clear();
           }
         else if(Username.Text.text.isEmpty || Username.Text.text.length < 3 )
         {
           showAlertDialog(context,"Check your Username");
           Username.Text.clear();
         }
         else if(FirstName.Text.text.isEmpty || FirstName.Text.text.length < 3 )
         {
           showAlertDialog(context,"Check your FirstName");
           FirstName.Text.clear();
         }
         else if(SecondName.Text.text.isEmpty || SecondName.Text.text.length < 3 )
         {
           showAlertDialog(context,"Check your SecondName");
           SecondName.Text.clear();
         }
         else if(RoundedPasswordInput.PASSWORD.text.length< 6 || RoundedPasswordInput.PASSWORD.text.length > 40)
         {
           showAlertDialog(context,"Password length should be more than 6 and less than 40 ");
           RoundedPasswordInput.PASSWORD.clear();
         }
        else if(RoundedPhoneNumber.PhoneNumber.text.isEmpty || RoundedPhoneNumber.PhoneNumber.text.length != 11)
          {
            showAlertDialog(context,"Check your Phone Number");
            RoundedPhoneNumber.PhoneNumber.clear();
          }
        else if(  FindLocation.Locationaddress.toString().isEmpty)
          {
            showAlertDialog(context,"Choose Shipping Location");
          }
        String _url =
               "http://${ip}:8080/bookstore/signup";
           var res = await http.post(Uri.parse(_url),
               headers: {"Content-Type": "application/json"},
               body: json.encode({
                 "email" : RoundedInput.Text.text,
                    "password": RoundedPasswordInput.PASSWORD.text,
                 "username": Username.Text.text,
                    "first_name":FirstName.Text.text,
                    "last_name":SecondName.Text.text,
                    "phone_number": RoundedPhoneNumber.PhoneNumber.text,
                  "shipping_address": FindLocation.Locationaddress,
             }));
        if(res.statusCode!=200)
        {
          showAlertDialog(context,"Check your inputs");
          RoundedInput.Text.clear();
          RoundedPasswordInput.PASSWORD.clear();
          Username.Text.clear();
          FirstName.Text.clear();
          SecondName.Text.clear();
          RoundedPhoneNumber.PhoneNumber.clear();
        }
        else
        {
          Account.Oldusername = Username.Text.text;
          Account.Oldpassword =RoundedPasswordInput.PASSWORD.text;
              RoundedInput.Text.clear();
          RoundedPasswordInput.PASSWORD.clear();
          Username.Text.clear();
          FirstName.Text.clear();
          SecondName.Text.clear();
          RoundedPhoneNumber.PhoneNumber.clear();
          setState(() => Signup.data = json.decode(res.body));
          Account.data = Signup.data;
          MainApp.intializeBooks();
          MainApp.Manger = Signup.data['is_manager'];
          MainApp.update();
          Navigator.popAndPushNamed(context, "/app");
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
          "SignUp",
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