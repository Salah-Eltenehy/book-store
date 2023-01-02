

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
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
  int numberofpages = 50000 ;
  int currentpage = 1;
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
              onChanged: (value){

              },
            ),
              SizedBox(
                height: 20.0,
              ),

              Text("Top Selling",style: TextStyle(
                fontSize: 20.0,
              ),
              ),
              SizedBox(
                height: 10.0,
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
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  ElevatedButton(onPressed: (){
                    setState(() {
                      if(currentpage > 1)
                        {
                          currentpage = currentpage-1;
                        }
                      else
                        {
                          currentpage = 1;
                        }

                    });
                  },
          style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
          child: const Icon(
            Icons.arrow_back,
          )),
         Text("${currentpage}",style: TextStyle(
           color: kPrimaryColor,
           fontSize: 20
         ) ,
         ),
      ElevatedButton(onPressed: (){
        setState(() {
          if(currentpage <  numberofpages)
            {
              currentpage = currentpage+1;
            }
          else
            {
              currentpage = numberofpages;
            }

        }


        );
      },
          style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
          child: const Icon(
            Icons.arrow_forward,
          )),
                  ]

              ),
              Container(
                width: double.infinity,
                height: 600.0,
                child: ListView.builder(
                   itemCount: MainApp.books.length,
                  itemBuilder:  (context,index)=> Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ListView(
                      children: [
                        showBook(MainApp.books[index], context),
                      ],
                    ),
                  ),
                  // children: [
                  //   showBook(MainApp.books[3],context),
                  //   showBook(MainApp.books[1],context),
                  //   showBook(MainApp.books[2],context),
                  //   showBook(MainApp.books[0],context),
                  //   showBook(MainApp.books[1],context),
                  //   showBook(MainApp.books[2],context),
                  //   showBook(MainApp.books[0],context),
                  //   showBook(MainApp.books[1],context),
                  //   showBook(MainApp.books[2],context),
                  //   showBook(MainApp.books[0],context),
                  // ],
                ),
              ),
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