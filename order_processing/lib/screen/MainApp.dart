import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'package:order_processing/screen/login.dart';

import '../modules/orders/Orders.dart';
import 'Account.dart';
import 'AddBook.dart';
import 'SearchScreen.dart';
import 'component/Showingbook.dart';
import 'data/book.dart';
import 'package:order_processing/modules/cart/CartScreen.dart';
import 'data/newbooks.dart';
class MainApp extends StatefulWidget {
  static int currentPage=0;
  static List<BookData> books = [
    new BookData("https://imgv2-2-f.scribdassets.com/img/word_document/353388341/original/f2e4b773a0/1567592883?v=1", "A Place Called Perfect "," Author", "description", "132 L.E" , "10"),
    new BookData("https://mir-s3-cdn-cf.behance.net/project_modules/disp/9ff4c287132211.5daee6dfaf15a.jpg", "To justifie the wayes of God To Men ", "Author", "description"," 145 L.E" , "11"),
    new BookData("http://www.humanoids.com/assets/CatalogueArticle/761/341112604_BookOfChaos_Cover_Rough_8705_zoomed.jpg", " The book of chaos", "Author"," description", "186 L.E" , "12"),
    new BookData("https://i0.wp.com/candidcover.net/wp-content/uploads/81eoHi7V9DL.jpg?fit=1400%2C2116&ssl=1", "Five feet apart"," Author", "description", "208 L.E" , "99"),

  ];
  @override
  _MainAppState  createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

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
      body:(MainApp.currentPage==0)
        ?SearchScreen()
        :(MainApp.currentPage==1)
          ?CartScreen()
          :(MainApp.currentPage==2)
            ?OrdersScreen()
            :Account(),
      // body:Account(),
      // SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(
      //       vertical: 16.0,horizontal: 18.0
      //     ),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [TextField(
      //         decoration: InputDecoration(
      //           filled: true,
      //           fillColor: kBackgroundColor,
      //           prefixIcon: Icon(Icons.search),
      //           contentPadding: EdgeInsets.all(8.0),
      //           hintText: "Search your favorite Book... ",
      //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),
      //           borderSide: BorderSide.none,
      //           )
      //           ,
      //         ),
      //       ),
      //       SizedBox(
      //         height: 20.0,
      //       ),
      //
      //         Text("Top Selling",style: TextStyle(
      //           fontSize: 20.0,
      //         ),
      //         ),
      //         SizedBox(
      //           height: 12.0,
      //         ),
      //
      //         Container(
      //           width: double.infinity,
      //           height: 280.0,
      //           child: ListView(
      //             scrollDirection: Axis.horizontal,
      //             children: [
      //               Book(books[0]),
      //               Book(books[1]),
      //               Book(books[2]),
      //               Book(books[3]),
      //               Book(books[0]),
      //               Book(books[1]),
      //               Book(books[2]),
      //               Book(books[3]),
      //               Book(books[0]),
      //               Book(books[1]),
      //               Book(books[2]),
      //               Book(books[3]),
      //             ],
      //           ),
      //         ),
      //         Text("See Also...",style: TextStyle(
      //           fontSize: 20.0,
      //         ),
      //         ),
      //         SizedBox(
      //           height: 12.0,
      //         ),
      //         Container(
      //            width: double.infinity,
      //            height: 600.0,
      //           child: ListView(
      //             children: [
      //               newbook(books[3],context),
      //               newbook(books[1],context),
      //               newbook(books[2],context),
      //               newbook(books[0],context),
      //               newbook(books[1],context),
      //               newbook(books[2],context),
      //               newbook(books[0],context),
      //               newbook(books[1],context),
      //               newbook(books[2],context),
      //               newbook(books[0],context),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),









      //////////////////////////////Account(),SearchScreen()

      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: MainApp.currentPage,
        onTap: (value) {
          setState(() {
            MainApp.currentPage=value;
          });
        },
        items: [
        BottomNavigationBarItem(
          backgroundColor: kPrimaryColor,
          icon: Icon(Icons.home),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
            label: "Cart"
        ),
          BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_sharp),
            label: "Orders"
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