

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/Book.dart';
import 'package:order_processing/screen/SearchScreen.dart';
import 'package:order_processing/shared/DioHelper.dart';
import 'package:http/http.dart' as http;
import '../Constants.dart';
import '../component/findlocation_Map.dart';
import 'MainApp.dart';

class AddBook extends StatefulWidget {
  static TextEditingController Text1 = TextEditingController();
  static TextEditingController Text2 = TextEditingController();
  static TextEditingController Text3 = TextEditingController();
  static TextEditingController Text4 = TextEditingController();
  static TextEditingController Text5 = TextEditingController();
  static TextEditingController Text6 = TextEditingController();
  static TextEditingController Text7 = TextEditingController();
  static TextEditingController Text8 = TextEditingController();
  static TextEditingController Text9 = TextEditingController();
  static TextEditingController Text10 = TextEditingController();
  static TextEditingController Text11 = TextEditingController();
  static TextEditingController Text12 = TextEditingController();
  @override
  _AddBookState  createState() => _AddBookState ();
}

class _AddBookState extends State<AddBook> {
  var obsescureText =true;
  late Book book ;
  @override
  Widget build(BuildContext context) {
    final  size  = MediaQuery.of(context).size;
    return Scaffold(
      appBar :AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Add Book"),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
        },
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.book))
        ],
      ),
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
                              )
                          )
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              buildbookTitle("Book Name","",false),
              buildauthor("Author(s)","put commas between authors",false),
              buildbookprice("Book Price","",false),
              buildtextfield("Book Publisher","",false),
              buildpublishertelephone("publisher telephone", "", false),
              Container(
                height: 450,
                width: size.width * 0.8,
                child: FindLocation(x: 31.2160786,y:  29.9469253,address: "Choose publisher address"),
              ),
              SizedBox(height: 30),
              buildpublishyear("Book Publication year","",false),
              buildIsbn("Book ISBN","",false),
              buildTitleCover("Book Cover Url","",false),
              buildcategroy("Book Category","",false),
              buildbookstock("Book Stock","",false),
              buildbookThreshohold("Book Threshold","",false),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(onPressed:(){
                    AddBook.Text1.clear();
                    AddBook.Text2.clear();
                    AddBook.Text3.clear();
                    AddBook.Text4.clear();
                    AddBook.Text5.clear();
                    AddBook.Text6.clear();
                    AddBook.Text7.clear();
                    AddBook.Text8.clear();
                    AddBook.Text9.clear();
                    AddBook.Text10.clear();
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
                  ElevatedButton(onPressed: () async{
                    print(AddBook.Text6.text);
                    String _url =
                        "http://${ip}:8080/bookstore/manager/add/book";
                    print(AddBook.Text2.text);
                    var res = await http.post(Uri.parse(_url),
                        headers: {"Content-Type": "application/json"},
                        body: json.encode({
                          "ISBN": AddBook.Text2.text,
                          "title": AddBook.Text3.text,
                          "publisher": AddBook.Text1.text,
                          "authors":AddBook.Text6.text,
                          "telephone_number" :AddBook.Text11.text,
                          "address":FindLocation.Locationaddress,
                          "image_url":AddBook.Text7.text,
                          "publication_year": AddBook.Text9.text,
                          "price": AddBook.Text4.text,
                          "category": AddBook.Text10.text,
                          "stock": AddBook.Text5.text,
                          "threshold": AddBook.Text8.text,
                        }));
                    if(res.statusCode!=200)
                      {
                        showAlertDialog( context,"Check your input of books" );
                        print(res.body);
                      }
                    else
                      {
                        print(res.body);
                      }
                    // await DioHelper.postData(url: "bookstore/manager/add/book", data: {
                    //   "ISBN": AddBook.Text2,
                    //   "title": AddBook.Text3,
                    //   "publisher": AddBook.Text1,
                    //   "author":AddBook.Text6,
                    //   "coverphoto":AddBook.Text7,
                    //   "publication_year": AddBook.Text9,
                    //   "price": AddBook.Text4,
                    //   "category": AddBook.Text10,
                    //   "stock": AddBook.Text5,
                    //   "threshold": AddBook.Text8,
                    // }).catchError((Error){
                    //   showAlertDialog( context,"Check your inputs" );
                    //   AddBook.Text1.clear();
                    //   AddBook.Text2.clear();
                    //   AddBook.Text3.clear();
                    //   AddBook.Text4.clear();
                    //   AddBook.Text5.clear();
                    //   AddBook.Text6.clear();
                    //   AddBook.Text7.clear();
                    //   AddBook.Text8.clear();
                    //   AddBook.Text9.clear();
                    //   AddBook.Text10.clear();
                    // });
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
  Widget buildpublisheraddress(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: AddBook.Text12,
        keyboardType: TextInputType.number,
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
  Widget buildpublishertelephone(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: AddBook.Text11,
        keyboardType: TextInputType.number,
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
  Widget buildtextfield(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: AddBook.Text1,
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
  Widget buildIsbn(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller:AddBook.Text2,
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
  Widget buildbookTitle(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller:AddBook.Text3,
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
  Widget buildbookprice(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: AddBook.Text4,
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
  Widget buildbookstock(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),

      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller:AddBook.Text5,
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
  Widget buildauthor(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller: AddBook.Text6,
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
  Widget buildTitleCover(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller:AddBook.Text7,
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
  Widget buildbookThreshohold(String label ,String placeholder, bool ispasswordTextField)
  {

    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller:AddBook.Text8,
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
  Widget buildpublishyear(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller:AddBook.Text9,
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
  Widget buildcategroy(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
        controller:AddBook.Text10,
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