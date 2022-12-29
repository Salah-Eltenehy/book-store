import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'package:order_processing/screen/login.dart';

import 'Account.dart';
import 'component/Showingbook.dart';
import 'data/book.dart';
import 'data/newbooks.dart';
class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<BookData> books = [
    new BookData("https://imgv2-2-f.scribdassets.com/img/word_document/353388341/original/f2e4b773a0/1567592883?v=1", "A Place Called Perfect "," Author", "description", 132, 3.8),
    new BookData("https://mir-s3-cdn-cf.behance.net/project_modules/disp/9ff4c287132211.5daee6dfaf15a.jpg", "To justifie the wayes of God To Men ", "Author", "description", 145, 3.2),
    new BookData("http://www.humanoids.com/assets/CatalogueArticle/761/341112604_BookOfChaos_Cover_Rough_8705_zoomed.jpg", " The book of chaos", "Author"," description", 186, 4.2),
    new BookData("https://i0.wp.com/candidcover.net/wp-content/uploads/81eoHi7V9DL.jpg?fit=1400%2C2116&ssl=1", "Five feet apart"," Author", "description", 208, 4.8),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("BookStore"),
        leading: IconButton(icon: Icon(Icons.book),onPressed: (){

        },),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,  MaterialPageRoute(builder: (context) =>  LoginScreen()));
          }, icon: Icon(Icons.logout))
        ],
      ),
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
                    Book(books[0]),
                    Book(books[1]),
                    Book(books[2]),
                    Book(books[3]),
                    Book(books[0]),
                    Book(books[1]),
                    Book(books[2]),
                    Book(books[3]),
                    Book(books[0]),
                    Book(books[1]),
                    Book(books[2]),
                    Book(books[3]),
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
                    newbook(books[3]),
                    newbook(books[1]),
                    newbook(books[2]),
                    newbook(books[0]),
                    newbook(books[1]),
                    newbook(books[2]),
                    newbook(books[0]),
                    newbook(books[1]),
                    newbook(books[2]),
                    newbook(books[0]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, size: 35),
          onPressed: () =>{}
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        onTap: (value) {
          if (value == 0) Navigator.push(context,  MaterialPageRoute(builder: (context) =>  SearchScreen()));
          // if (value == 1) Navigator.of(context).push(...);
          if (value == 2) Navigator.push(context,  MaterialPageRoute(builder: (context) =>  Account()));
        },
        items: [
        BottomNavigationBarItem(
          backgroundColor: kPrimaryColor,
          icon: Icon(Icons.home),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
            label: "Chart"
        ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "my Account"
          ),
      ],
      ),
    );
  }

}