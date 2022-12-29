

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/screen/SearchScreen.dart';
import 'package:order_processing/screen/data/book.dart';

import '../Constants.dart';
import '../component/findlocation_Map.dart';

class AddBook extends StatefulWidget {

  @override
  _AddBookState  createState() => _AddBookState ();
}

class _AddBookState extends State<AddBook> {
  var obsescureText =true;
  late BookData book ;
  @override
  Widget build(BuildContext context) {
    final  size  = MediaQuery.of(context).size;
    return Scaffold(
      appBar :AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Add Book"),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  SearchScreen()));
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
              buildtextfield("Book Name","",false),
              buildtextfield("Author","",false),
              buildtextfield("Book Price","",false),
              buildtextfield("Book ID","",false),
              buildtextfield("Book Cover Url","",false),
              buildtextfield("Book description","",false),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(onPressed:(){
                    Navigator.push(context,  MaterialPageRoute(builder: (context) =>  SearchScreen()));
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
                  ElevatedButton(onPressed: (){
                    Navigator.push(context,  MaterialPageRoute(builder: (context) =>  SearchScreen()));
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
  Widget buildtextfield(String label ,String placeholder, bool ispasswordTextField)
  {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispasswordTextField? obsescureText :false ,
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