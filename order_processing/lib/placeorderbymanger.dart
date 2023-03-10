

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/httprequests/loginrequest.dart';
import 'package:order_processing/screen/MainApp.dart';
import '../Book.dart';
import '../Constants.dart';
import '../shared/DioHelper.dart';
import 'package:http/http.dart' as http;


class Placeorder extends StatefulWidget {
  static TextEditingController Text1 = TextEditingController();
  static TextEditingController Text2 = TextEditingController();
  @override
  _PlaceorderState  createState() => _PlaceorderState();
}

class _PlaceorderState extends State<Placeorder> {
  var obsescureText =true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar :AppBar(
      //   backgroundColor: kPrimaryColor,
      //   centerTitle: true,
      //   title: Text("Place order"),
      //   leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
      //     Navigator.pop(context);
      //   },
      //   ),
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(Icons.book))
      //   ],
      // ),
      body: Container(
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
                                  'https://cdn3.iconfinder.com/data/icons/ios-web-user-interface-flat-circle-vol-3/512/Book_books_education_library_reading_open_book_study-512.png'
                                // "https://cdn3.iconfinder.com/data/icons/ios-web-user-interface-flat-circle-vol-3/512/Book_books_education_library_reading_open_book_study-512.png"
                              )
                          )
                      ),
                    )
                  ],
                ),
              ),
              buildtextfield("Book ISBN","",false),
              buildtextfield2("Book quantity","",false),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(onPressed:(){
                    Placeorder.Text1.clear();
                    Navigator.pop(context);
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
                    // http://localhost:8080/bookstore/manager/modify/book/1234567890123/50

                    String _url = "http://${ip}:8080/bookstore/manager/place/order/book";
                    print(_url);
                    var response = await http.post(Uri.parse(_url),
                        headers: {"Content-Type": "application/json"},
                        body: json.encode({
                          "ISBN" : Placeorder.Text1.text,
                          "quantity": Placeorder.Text2.text,
                        }));
                    if(response.statusCode!=200)
                    {
                      print(response.body);
                      showAlertDialog( context,"Check your inputs" );
                      Placeorder.Text1.clear();
                      Placeorder.Text2.clear();
                    }
                    else
                    {
                      Placeorder.Text1.clear();
                      Placeorder.Text2.clear();
                      MainApp.currentPage=0;
                      await Login.sendsearchrequest();
                      MainApp.update();
                      print(response.body);
                    }
                    // Navigator.push(context,  MaterialPageRoute(builder: (context) =>  MainApp()));
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
        controller: Placeorder.Text1,
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
        controller: Placeorder.Text2,
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