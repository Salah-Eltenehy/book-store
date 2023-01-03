import 'package:flutter/material.dart';
import 'package:order_processing/Book.dart';
import 'package:order_processing/component/rounded_input.dart';
import 'package:order_processing/component/rounded_password_input.dart';
import 'package:order_processing/component/rounded_phone.dart';
import 'package:order_processing/component/secondname.dart';
import 'package:order_processing/screen/user.dart';
import 'package:order_processing/shared/DioHelper.dart';
import 'package:order_processing/shared/network/local/Cachhelper.dart';

import '../Constants.dart';
import '../screen/MainApp.dart';
import '../screen/SearchScreen.dart';
import 'Username.dart';
import 'findlocation_Map.dart';
import 'firstname.dart';

class RoundedButton extends StatelessWidget {


   RoundedButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  static late user User;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () async{
        // int id = await CachHelper.getData(key: )
        MainApp.books= DioHelper.getData(url: "search/all/${1}") as List<Book>;
        if(title == "LOGIN")
          {
            DioHelper.postData(url:"bookstore/login" , data: {
              "email" : RoundedInput.Text.text,
              "password": RoundedPasswordInput.PASSWORD.text,

            }).then((value) async {
              String id = value.data["id"] ;
             User =  (await CachHelper.saveData(key: "id", value: id)) as user;
              MainApp.books= DioHelper.getData(url: "search/all/${1}") as List<Book>;
            } ).catchError((Error){
              showAlertDialog( context,"Check your inputs" );
              RoundedInput.Text.clear();
              RoundedPasswordInput.PASSWORD.clear();
            });
          }
        else
          {
            DioHelper.postData(url:"bookstore/signup" , data: {
              "email" : RoundedInput.Text.text,
              "password": RoundedPasswordInput.PASSWORD.text,
              "userName":Username.Text.text,
              "firstName":FirstName.Text.text,
              "lastName":SecondName.Text.text,
              "PhoneNumber": RoundedPhoneNumber.PhoneNumber.text,
              "locationAddress": FindLocation.Locationaddress,
              "xAxis": FindLocation.X_axis,
              "yAxis":FindLocation.Y_axis,
            }).then((value) async {
              String id = value.data["id"] ;
             User = (await CachHelper.saveData(key: "id", value: id)) as user;
            } ).catchError((Error){
              showAlertDialog( context,"Check your inputs" );
              RoundedInput.Text.clear();
              RoundedPasswordInput.PASSWORD.clear();
              Username.Text.clear();
              FirstName.Text.clear();
              SecondName.Text.clear();
              RoundedPhoneNumber.PhoneNumber.clear();
            });
          }

        MainApp.intializeBooks();
        MainApp.update();
        Navigator.popAndPushNamed(context, "/app");
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
          title,
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
        title: const Text("Alert"),
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