import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'package:badges/badges.dart';
import '../Book.dart';
import '../modules/orders/Orders.dart';
import 'Account.dart';
import 'SearchScreen.dart';
import 'package:order_processing/modules/cart/CartScreen.dart';

class MainApp extends StatefulWidget {
  static int currentPage = 0;
  static int cartItems = 5;
  static int orders = 1;
  static bool Manger = false;
  static List<Book> books = [
    new Book(
        "0123456789012",
        "A Place Called Perfect ",
        " Ziad zidan",
        "Animals",
        "Dar Elnahda",
        2020,
        132.0,
        10,
        "https://imgv2-2-f.scribdassets.com/img/word_document/353388341/original/f2e4b773a0/1567592883?v=1"),
    new Book(
        "0123456789012",
        "To justifie the wayes of God To Men ",
        " Jason Stathim",
        "Animals",
        "Dar Elnahda",
        2021,
        145.0,
        11,
        "https://mir-s3-cdn-cf.behance.net/project_modules/disp/9ff4c287132211.5daee6dfaf15a.jpg"),
    new Book(
        "0123456789012",
        "The book of chaos ",
        " Tim Drake",
        "Animals",
        "Dar Elnahda",
        2015,
        186.0,
        12,
        "http://www.humanoids.com/assets/CatalogueArticle/761/341112604_BookOfChaos_Cover_Rough_8705_zoomed.jpg"),
    new Book(
        "0123456789012",
        "Five feet apart ",
        " Kratos",
        "Animals",
        "Dar Elnahda",
        2010,
        208.0,
        99,
        "https://i0.wp.com/candidcover.net/wp-content/uploads/81eoHi7V9DL.jpg?fit=1400%2C2116&ssl=1"),
  ];

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<BottomNavigationBarItem> bottomBarButtons =[
  BottomNavigationBarItem(
  backgroundColor: kPrimaryColor,
  icon: Icon(Icons.home),
  label: "Home"),
  BottomNavigationBarItem(
  icon: MainApp.cartItems != 0
  ? Badge(
  showBadge: true,
  badgeContent: Text("${MainApp.cartItems}",
  style: const TextStyle(color: Colors.white)),
  animationType: BadgeAnimationType.scale,
  shape: BadgeShape.circle,
  //position: BadgePosition.center(),
  child: const Icon(Icons.shopping_cart),
  )
      : const Icon(Icons.shopping_cart),
  label: "Cart"),
  BottomNavigationBarItem(
  icon: Icon(Icons.person), label: "my Account"),
  ];

  @override
  Widget build(BuildContext context) {
    if (MainApp.Manger){
      bottomBarButtons.add(  BottomNavigationBarItem(
          icon: MainApp.orders != 0
              ? Badge(
            showBadge: true,
            badgeContent: Text("${MainApp.orders}",
                style: const TextStyle(color: Colors.white)),
            animationType: BadgeAnimationType.scale,
            shape: BadgeShape.circle,
            //position: BadgePosition.center(),
            child: const Icon(Icons.menu_book_sharp),
          )
              : const Icon(Icons.menu_book_sharp),
          label: "Orders"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("BookStore"),
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: (MainApp.currentPage == 0)
          ? SearchScreen()
          : (MainApp.currentPage == 1)
              ? CartScreen()
              : (MainApp.currentPage == 2)
                  ? Account()
                  : MainApp.Manger
                    ?OrdersScreen()
                    :null,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: MainApp.currentPage,
        onTap: (value) {
          setState(() {
            MainApp.currentPage = value;
          });
        },
        items: bottomBarButtons,
      ),
      // GNav(
      //   gap: 5,
      //   activeColor: Colors.white,
      //   color: kPrimaryColor,
      //   tabBackgroundColor: kPrimaryColor,
      //   duration: const Duration(milliseconds: 300),
      //   // backgroundColor: kPrimaryColor,
      //   // unselectedItemColor: Colors.white,
      //   // selectedItemColor: Colors.white,
      //   selectedIndex: MainApp.currentPage,
      //   onTabChange: (value) {
      //     setState(() {
      //       MainApp.currentPage=value;
      //     });
      //   },
      //   tabs: [
      //     GButton(
      //         icon: Icons.home,
      //         text: "Home"
      //     ),
      //     GButton(
      //         icon: Icons.shopping_cart,
      //         text: "Cart"
      //     ),
      //     GButton(
      //         icon: Icons.menu_book_sharp,
      //         text: "Orders"
      //     ),
      //     GButton(
      //         icon: Icons.person,
      //         text: "my Account"
      //     ),
      //   ],
      // ),
    );
  }
}
