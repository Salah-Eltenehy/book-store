

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:order_processing/component/rounded_button.dart';
import 'package:order_processing/httprequests/signuprequest.dart';
import 'package:order_processing/screen/SearchScreen.dart';
import 'package:http/http.dart' as http;
import '../Constants.dart';
import '../component/findlocation_Map.dart';
import '../shared/DioHelper.dart';
import 'MainApp.dart';

class Account extends StatefulWidget {
  static TextEditingController Text1 = TextEditingController();
  static TextEditingController Text2 = TextEditingController();
  static TextEditingController Text3 = TextEditingController();
  static TextEditingController Text4 = TextEditingController();
  static TextEditingController Text5 = TextEditingController();
  static TextEditingController Text6 = TextEditingController();
  static TextEditingController Text7 = TextEditingController();
  static late String Oldusername;
  static late String Oldpassword;
  static late Map<String, dynamic> data;
  @override
  _AccountState  createState() => _AccountState ();
}

class _AccountState extends State<Account> {
  var obsescureText =true;

  @override
  Widget build(BuildContext context) {
    final  size  = MediaQuery.of(context).size;
     return Container(
         padding: EdgeInsets.only(left: 15,top: 20,right: 15),
         child: GestureDetector(
           onTap: (){
             FocusScope.of(context).unfocus();
           },
           child: ListView(
             children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4,color: Colors.white),
                          boxShadow:[ BoxShadow(
                            spreadRadius: 2,
                            blurRadius:10,
                            color: Colors.black.withOpacity(0.1),
                          )
                      ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://wvnpa.org/content/uploads/blank-profile-picture-973460_1280-768x768.png'
                            )
                          )
                        ),
                      )
                    ],
                  ),
                ),
               SizedBox(height: 30),
               buildtextfield("Email Address",Account.data['email'],false),
               buildtextfield2("Password",Account.data['password'],true),
               buildtextfield3("User name",Account.data['username'],false),
               buildtextfield4("First Name",Account.data['first_name'],false),
               buildtextfield5("Last Name",Account.data['last_name'],false),
               buildtextfield6("Phone Number",Account.data['phone_number'],false),
               buildtextfield7("shipping address", Account.data['shipping_address'], false),
               // Container(
               //   height: 450,
               //   width: size.width * 0.8,
               //   child: FindLocation(x: RoundedButton.User.X_axis,y: RoundedButton.User.Y_axis,),
               // ),
               SizedBox(height: 30),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   OutlinedButton(onPressed:(){
                     Account.Text1.clear();
                     Account.Text2.clear();
                     Account.Text3.clear();
                     Account.Text4.clear();
                     Account.Text5.clear();
                     Account.Text6.clear();
                     Account.Text7.clear();
                     // setState(() {
                     //   MainApp.currentPage == 0;
                     //   Navigator.popAndPushNamed(contex);
                     // });

                    // Navigator.pop(context);
                     MainApp.currentPage=0;
                     MainApp.update();

                   }, child: Text("Cancel",style: TextStyle(
                     fontSize: 15,
                     letterSpacing: 2,
                     color: Colors.black,
                   ),),
                     style: OutlinedButton.styleFrom(
                       padding: EdgeInsets.symmetric(horizontal: 50),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                     ),
                   ),
                   ElevatedButton(onPressed: ()async{
                     var email = Account.Text1.text;
                     var password = Account.Text2.text;
                     var username = Account.Text3.text;
                     var firstname = Account.Text4.text;
                     var secondname = Account.Text5.text;
                     var phonenumber = Account.Text6.text;
                     var shippingaddress = Account.Text7.text;
                     if(email.isEmpty)
                       {
                         email =Account.data['email'];
                       }
                     else if(password.isEmpty)
                       {
                         password = Account.data['password'];
                       }
                     else if(username.isEmpty)
                       {
                          username = Account.data['username'];
                       }
                     else if(firstname.isEmpty)
                       {
                         firstname = Account.data['first_name'];
                       }
                     else if(secondname.isEmpty)
                       {
                         secondname = Account.data['last_name'];
                       }
                     else if(phonenumber.isEmpty)
                       {
                         phonenumber = Account.data['phone_number'];
                       }
                     else if(shippingaddress.isEmpty)
                       {
                         shippingaddress = Account.data['shipping_address'];
                       }
                     if((Account.Text3.text.length <3)&& Account.Text3.text.isNotEmpty)
                       {
                         showAlertDialog(context,"check your username");
                         Account.Text3.clear();
                       }
                     if((Account.Text4.text.length< 3)&& Account.Text4.text.isNotEmpty )
                       {
                         showAlertDialog(context,"check your first_name");
                         Account.Text4.clear();
                       }
                     if( (Account.Text5.text.length<3) && Account.Text5.text.isNotEmpty )
                       {
                         showAlertDialog(context,"check your last_name");
                         Account.Text5.clear();
                       }
                     if((Account.Text2.text.length<6 || Account.Text2.text.length>40 ) && Account.Text2.text.isNotEmpty)
                       {
                         showAlertDialog(context,"Check your Password");
                         Account.Text2.clear();
                       }
                     else if((Account.Text6.text.length != 11) && Account.Text6.text.isNotEmpty)
                     {
                       showAlertDialog(context,"Check your Phone Number");
                       Account.Text6.clear();
                     }
                     else
                       {
                         String _url =
                             "http://${ip}:8080/bookstore/customer/editProfile";
                         var res = await http.post(Uri.parse(_url),
                             headers: {"Content-Type": "application/json"},
                             body: json.encode({
                             "oldUsername":Account.Oldusername,
                              "oldPassword":Account.Oldpassword,
                             "email" : email,
                             "password"  : password,
                             "username"  : username,
                             "first_name" :firstname,
                             "last_name"  :secondname,
                              "phone_number":phonenumber,
                             "shipping_address" :shippingaddress,
                               "is_manager": MainApp.Manger,
                             }));
                         if(res.statusCode!=200)
                           {
                             print(res.body);
                             showAlertDialog(context,"check your inputs");
                             Account.Text1.clear();
                             Account.Text2.clear();
                             Account.Text3.clear();
                             Account.Text4.clear();
                             Account.Text5.clear();
                             Account.Text6.clear();
                             Account.Text7.clear();
                           }
                         else
                           {
                             setState(() => Account.data = json.decode(res.body));
                             MainApp.update();
                             Navigator.pop(context);
                           }
                       }
                   }, child: Text("Save",style: TextStyle(
                     fontSize: 15,
                     letterSpacing: 2,
                     color: Colors.white,
                   ),),
                     style: ElevatedButton.styleFrom(
                       primary: kPrimaryColor,
                       padding: EdgeInsets.symmetric(horizontal: 30),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                     ),
                   )
                 ],
               )
             ],
           ),
         ),
       );
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
Widget buildtextfield(String label ,String placeholder, bool ispasswordTextField)
{
  return Padding(
      padding: EdgeInsets.only(bottom: 30),
     child: TextField(
       obscureText: ispasswordTextField? obsescureText :false ,
       controller: Account.Text1,
       decoration: InputDecoration(
         suffixIcon: ispasswordTextField?
             IconButton(onPressed: (){
               setState(() {
                 obsescureText =!obsescureText;
               });
             }, icon: Icon(Icons.remove_red_eye),
             ):null,
             contentPadding: EdgeInsets.only(bottom: 5),
             labelText: label,
             labelStyle: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold,
               color: kPrimaryColor,
             ),
             floatingLabelBehavior: FloatingLabelBehavior.always,
             hintText: placeholder,
             hintStyle: TextStyle(
               fontSize: 16,
               fontWeight: FontWeight.bold,
               color: Colors.grey,
             )

       ),
     ),
  );
}
  Widget buildtextfield2(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: Account.Text2,
        decoration: InputDecoration(
            suffixIcon: ispasswordTextField?
            IconButton(onPressed: (){
              setState(() {
                obsescureText =!obsescureText;
              });
            }, icon: Icon(Icons.remove_red_eye),
            ):null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )

        ),
      ),
    );
  }
  Widget buildtextfield3(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: Account.Text3,
        decoration: InputDecoration(
            suffixIcon: ispasswordTextField?
            IconButton(onPressed: (){
              setState(() {
                obsescureText =!obsescureText;
              });
            }, icon: Icon(Icons.remove_red_eye),
            ):null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )

        ),
      ),
    );
  }
  Widget buildtextfield4(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: Account.Text4,
        decoration: InputDecoration(
            suffixIcon: ispasswordTextField?
            IconButton(onPressed: (){
              setState(() {
                obsescureText =!obsescureText;
              });
            }, icon: Icon(Icons.remove_red_eye),
            ):null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )

        ),
      ),
    );
  }
  Widget buildtextfield5(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: Account.Text5,
        decoration: InputDecoration(
            suffixIcon: ispasswordTextField?
            IconButton(onPressed: (){
              setState(() {
                obsescureText =!obsescureText;
              });
            }, icon: Icon(Icons.remove_red_eye),
            ):null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )

        ),
      ),
    );
  }
  Widget buildtextfield6(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: Account.Text6,
        decoration: InputDecoration(
            suffixIcon: ispasswordTextField?
            IconButton(onPressed: (){
              setState(() {
                obsescureText =!obsescureText;
              });
            }, icon: Icon(Icons.remove_red_eye),
            ):null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )

        ),
      ),
    );
  }
  Widget buildtextfield7(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: Account.Text7,
        decoration: InputDecoration(
            suffixIcon: ispasswordTextField?
            IconButton(onPressed: (){
              setState(() {
                obsescureText =!obsescureText;
              });
            }, icon: Icon(Icons.remove_red_eye),
            ):null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )

        ),
      ),
    );
  }
}