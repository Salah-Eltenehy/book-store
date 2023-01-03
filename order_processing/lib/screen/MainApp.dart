import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_processing/Constants.dart';
import 'package:badges/badges.dart';
import 'package:order_processing/shared/DioHelper.dart';
import '../Book.dart';
import '../modules/orders/Orders.dart';
import 'Account.dart';
import 'SearchScreen.dart';
import 'package:order_processing/modules/cart/CartScreen.dart';
import 'package:order_processing/shared/network/local/Cachhelper.dart';

import 'login.dart';

class MainApp extends StatefulWidget {
  static int currentPage = 0;
  static List<Book> cartBooks=[];
  static List<Book> orderBooks=[];
  static bool Manger = true;
  static List<Book> books = [];
  static intializeBooks() async {
    int id=await CachHelper.getData(key: 'id');
    //TODO : add url of the request and the form of the data
    await DioHelper.getData(url: '').then((value) {
      orderBooks=value.data;
    });
    books=[
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
    orderBooks.add(books[0]);
  }
  static final _MainAppState _currentState = _MainAppState();

  static update() => _currentState.setState(() {});

  @override
  _MainAppState createState() => _currentState;
}

class _MainAppState extends State<MainApp> {
  late List<BottomNavigationBarItem> bottomBarButtons;
  @override
  Widget build(BuildContext context) {
    if (MainApp.Manger) {
      bottomBarButtons = [
        BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: Icon(Icons.home),
            label: "Home"),
        BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: MainApp.cartBooks.isNotEmpty
                ? Badge(
                    showBadge: true,
                    badgeContent: Text("${MainApp.cartBooks.length}",
                        style: const TextStyle(color: Colors.white)),
                    animationType: BadgeAnimationType.scale,
                    shape: BadgeShape.circle,
                    //position: BadgePosition.center(),
                    child: const Icon(Icons.shopping_cart),
                  )
                : const Icon(Icons.shopping_cart),
            label: "Cart"),
        BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: Icon(Icons.person),
            label: "my Account"),
        BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: MainApp.orderBooks.isNotEmpty
                ? Badge(
                    showBadge: true,
                    badgeContent: Text("${MainApp.orderBooks.length}",
                        style: const TextStyle(color: Colors.white)),
                    animationType: BadgeAnimationType.scale,
                    shape: BadgeShape.circle,
                    //position: BadgePosition.center(),
                    child: const Icon(Icons.menu_book_sharp),
                  )
                : const Icon(Icons.menu_book_sharp),
            label: "Orders"),
      ];
    } else {
      bottomBarButtons = [
        BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: Icon(Icons.home),
            label: "Home"),
        BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: MainApp.cartBooks.isNotEmpty
                ? Badge(
                    showBadge: true,
                    badgeContent: Text("${MainApp.cartBooks.length}",
                        style: const TextStyle(color: Colors.white)),
                    animationType: BadgeAnimationType.scale,
                    shape: BadgeShape.circle,
                    //position: BadgePosition.center(),
                    child: const Icon(Icons.shopping_cart),
                  )
                : const Icon(Icons.shopping_cart),
            label: "Cart"),
        BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: Icon(Icons.person),
            label: "my Account"),
      ];
    }
    return MaterialApp(
        title: 'Flutter Animated Login',
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          '/login': (context) => LoginScreen(),
          '/app': (context) =>Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              title: Text("BookStore"),
              leading: Container(),
              actions: [
                IconButton(
                    onPressed: () {
                      MainApp.cartBooks.clear();
                      MainApp.books.clear();
                      Navigator.popAndPushNamed(context, "/login");
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
                : OrdersScreen(),
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

          ),
        },
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
        ),
      );
  }
}
