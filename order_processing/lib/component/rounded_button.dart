// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:order_processing/Book.dart';
// import 'package:order_processing/component/rounded_input.dart';
// import 'package:order_processing/component/rounded_password_input.dart';
// import 'package:order_processing/component/rounded_phone.dart';
// import 'package:order_processing/component/secondname.dart';
// import 'package:order_processing/screen/user.dart';
// import 'package:order_processing/shared/DioHelper.dart';
// import 'package:order_processing/shared/network/local/Cachhelper.dart';
// import 'package:http/http.dart' as http;
// import '../Constants.dart';
// import '../screen/MainApp.dart';
// import '../screen/SearchScreen.dart';
// import 'Username.dart';
// import 'findlocation_Map.dart';
// import 'firstname.dart';
//
// class RoundedButton extends StatelessWidget {
//
//
//    RoundedButton({
//     Key? key,
//     required this.title,
//   }) : super(key: key);
//
//   final String title;
//   static late user User ;
//    static late Map<String, dynamic> data;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return InkWell(
//       onTap: () async{
//         // int id = await CachHelper.getData(key: )
//         // MainApp.books= await DioHelper.getData(url: "search/all/${1}") as List<Book>;
//         if(title == "LOGIN")
//           {
//             await DioHelper.postData(url:"bookstore/login" , data: {
//               "username" : RoundedInput.Text.text,
//               "password": RoundedPasswordInput.PASSWORD.text,
//
//             }).then((value) async {
//               String id = value.data["id"] ;
//              User =  (await CachHelper.saveData(key: "id", value: id)) as user;
//               MainApp.books= await DioHelper.getData(url: "search/all?offset=${1}") as List<Book>;
//             } ).catchError((Error){
//               showAlertDialog( context,"Check your inputs" );
//               RoundedInput.Text.clear();
//               RoundedPasswordInput.PASSWORD.clear();
//             });
//           }
//         else if(title == "SIGN UP" )
//           {
//              String _url =
//                 "http://${ip}:8080/bookstore/signup";
//              var res = await http.post(Uri.parse(_url),
//                  headers: {"Content-Type": "application/json"},
//                  body: json.encode({
//                    "email": email.toLowerCase(),
//                    "password": pass,
//                  }));
//
//              setState(() => profileData = json.decode(res.body));
//             // await DioHelper.postData(url:"bookstore/signup" , data: {
//             //   "email" : RoundedInput.Text.text,
//             //   "password": RoundedPasswordInput.PASSWORD.text,
//             //   "username":Username.Text.text,
//             //   "first_name":FirstName.Text.text,
//             //   "last_name":SecondName.Text.text,
//             //   "phone_number": RoundedPhoneNumber.PhoneNumber.text,
//             //   "shipping_address": "s",
//             // }).then((value) async  {
//             //  // String id = value.data["id"] ;
//             //   print("hello000000000000000000o");
//             //   print(value.data);
//             //   // data = value.data;
//             //   data = value.data;
//             //   User = new user(value.data['email'], value.data['username'], value.data['first_name'], value.data['last_name'],value.data['phone_number'], value.data['shipping_address'],value.data['is_manager'] );
//             // // User = (await CachHelper.saveData(key: "id", value: id)) as user;
//             //   MainApp.books= await DioHelper.getData(url: "search/all?offset=${1}") as List<Book>;
//             // } ).catchError((Error){
//             //   print(Error);
//             //   showAlertDialog( context,"Check your inputs" );
//             //   RoundedInput.Text.clear();
//             //   RoundedPasswordInput.PASSWORD.clear();
//             //   Username.Text.clear();
//             //   FirstName.Text.clear();
//             //   SecondName.Text.clear();
//             //   RoundedPhoneNumber.PhoneNumber.clear();
//             // });
//           }
//
//         MainApp.intializeBooks();
//         MainApp.update();
//         Navigator.popAndPushNamed(context, "/app");
//       },
//       borderRadius: BorderRadius.circular(30),
//       child: Container(
//         width: size.width * 0.8,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           color: kPrimaryColor,
//         ),
//
//         padding: EdgeInsets.symmetric(vertical: 20),
//         alignment: Alignment.center,
//         child: Text(
//           title,
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 18
//           ),
//         ),
//       ),
//     );
//   }
// }
// showAlertDialog(BuildContext context, text3) {
//   return showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Alert"),
//         content: Text(text3),
//         actions: [
//           TextButton(
//             child: const Text("OK"),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           ),
//         ],
//       ));
// }