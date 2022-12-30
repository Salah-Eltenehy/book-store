

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/screen/SearchScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Constants.dart';
import '../component/findlocation_Map.dart';
import 'AddBook.dart';
import 'MainApp.dart';
import 'component/topBarBooks.dart';
import 'data/BookShow.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState  createState() => _SearchScreenState ();
}

class _SearchScreenState extends State<SearchScreen> {
  var obsescureText =true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 16.0,horizontal: 18.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: kBackgroundColor,
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(8.0),
                hintText: "Search your favorite Book... ",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                )
                ,
              ),
            ),
              SizedBox(
                height: 20.0,
              ),

              Text("Top Selling",style: TextStyle(
                fontSize: 20.0,
              ),
              ),
              SizedBox(
                height: 12.0,
              ),

              Container(
                width: double.infinity,
                height: 280.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    topBarBook(MainApp.books[0]),
                    topBarBook(MainApp.books[1]),
                    topBarBook(MainApp.books[2]),
                    topBarBook(MainApp.books[3]),
                    topBarBook(MainApp.books[0]),
                  ],
                ),
              ),
              Text("See Also...",style: TextStyle(
                fontSize: 20.0,
              ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                width: double.infinity,
                height: 600.0,
                child: ListView(
                  children: [
                    showBook(MainApp.books[3],context),
                    showBook(MainApp.books[1],context),
                    showBook(MainApp.books[2],context),
                    showBook(MainApp.books[0],context),
                    showBook(MainApp.books[1],context),
                    showBook(MainApp.books[2],context),
                    showBook(MainApp.books[0],context),
                    showBook(MainApp.books[1],context),
                    showBook(MainApp.books[2],context),
                    showBook(MainApp.books[0],context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: MainApp.Manger?FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add, size: 35),
          onPressed: () =>{
            Navigator.push(context,  MaterialPageRoute(builder: (context) =>  AddBook()))
          }
      ):Container(),
    );

  }
}