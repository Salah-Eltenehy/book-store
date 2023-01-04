

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:order_processing/Book.dart';
import 'package:order_processing/screen/SearchScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Constants.dart';
import '../component/findlocation_Map.dart';
import '../shared/DioHelper.dart';
import 'AddBook.dart';
import 'MainApp.dart';
import 'component/topBarBooks.dart';
import 'data/BookShow.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  static TextEditingController Text1 = TextEditingController();
  static late List<dynamic> booksdynamic =[];
  @override
  _SearchScreenState  createState() => _SearchScreenState ();
}

class _SearchScreenState extends State<SearchScreen> {
  var obsescureText =true;
  int numberofpages = 50000;
  int currentpage = 1;
  int selectedValue = 1;
  late String field;
  @override
  Widget build(BuildContext context) {
    print(MainApp.books[0].title);
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
            children: [
              Row(
               children: [
                 Text("choose Search Field : ",
                 style: TextStyle(
                   fontSize: 18,
                 ),
                 ),
                 DropdownButton(
                     value:  selectedValue,
                     iconEnabledColor: kPrimaryColor,
                     iconDisabledColor: kPrimaryColor,
                     focusColor: kPrimaryColor,
                     items: [
                       DropdownMenuItem(
                         child: Text("all"),
                         value: 1,
                       ),
                       DropdownMenuItem(
                         child: Text("Book Name"),
                         value: 2,
                       ),
                       DropdownMenuItem(
                         child: Text("Book ISBN"),
                         value: 3,
                       ),
                       DropdownMenuItem(
                           child: Text("Book Author"),
                           value: 4
                       ),
                       DropdownMenuItem(
                           child: Text("Category"),
                           value: 5
                       ),
                       DropdownMenuItem(
                           child: Text("Book Publisher"),
                           value: 6
                       ),
                     ],
                     onChanged: (value) {
                       setState(()  {
                         selectedValue = value!;
                         if(value ==1)
                           {
                             field = "all";
                           }
                         else if(value ==2)
                           {
                             field ="title";
                           }
                         else if(value ==3)
                           {
                             field = "isbn";
                           }
                         else if( value == 4)
                           {
                             field = "author";
                           }
                         else if(value ==5)
                           {
                             field = "category";
                           }
                         else
                           {
                             field = "publisher";
                           }

                       });
                     }),
               ],
              ),
              TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: kBackgroundColor,
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(8.0),
                hintText: "Search your favorite Book... ",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) async {
                if(field == "all")
                {
                  String _url = "http://${ip}:8080/search/all?offset=${1}";
                  var response = await http.get(Uri.parse(_url));
                  print(response.body);
                }
                else
                {
                  String _url = "http://${ip}:8080/search/${field}? keyword=${SearchScreen.Text1.text} &offset=${currentpage}";
                  var response = await http.get(Uri.parse(_url));
                  print(response.body);
                }
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: MainApp.books.length,
                  itemBuilder:  (context,index)=> Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                     child: topBarBook(MainApp.books[index]),
                    // child: ListView(
                    //   children: [
                    //     showBook(MainApp.books[index], context),
                    //   ],
                    // ),
                  ),
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
                  ElevatedButton(onPressed: () async{
                    setState(() async {
                      if(currentpage > 1 )
                        {
                          currentpage = currentpage-1;
                          if(field == "all")
                          {
                            String _url = "http://${ip}:8080/search/all?offset=${1}";
                            var response = await http.get(Uri.parse(_url));
                            print(response.body);
                          }
                          else
                          {
                            String _url = "http://${ip}:8080/search/${field}? keyword=${SearchScreen.Text1.text} &offset=${currentpage}";
                            var response = await http.get(Uri.parse(_url));
                            print(response.body);
                          }
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
      ElevatedButton(onPressed: () {
        setState(() async{
          if(currentpage < numberofpages && SearchScreen.booksdynamic.length!=0)
            {
              currentpage = currentpage+1;
              if(field == "all")
              {
                String _url = "http://${ip}:8080/search/all?offset=${1}";
                var response = await http.get(Uri.parse(_url));
                print(response.body);
              }
              else
              {
                String _url = "http://${ip}:8080/search/all? keyword=${field} &offset=${currentpage}";
                var response = await http.get(Uri.parse(_url));
                print(response.body);
              }
            }
         // MainApp.books = await DioHelper.getData(url: "search/${field}/${currentpage}") as List<Book>;
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
                    child: showBook(SearchScreen.booksdynamic[index], context),
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