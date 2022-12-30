import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'package:order_processing/component/isadmin.dart';
import 'package:order_processing/screen/MainApp.dart';

import '../../Book.dart';
import '../EditBook.dart';
Widget showBook(Book book,BuildContext context)
{

  return Container(
  width: double.infinity,
    height: 150.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8.0),
          height: 128.0,
          width: 83.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(book.photoUrl),
              fit: BoxFit.cover,

            ),

          ),
        ),
        Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 book.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight:FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                 book.author_name,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on,color: kPrimaryColor,),
                    Text(book.price.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.numbers_sharp,color: kPrimaryColor,),
                    Text(book.ISPN.toString()),
                  ],
                ),
              ],
            )
        ),
        IconButton(onPressed: (){
          var myListFiltered = MainApp.cartBooks.where((x) => x.title == book.title);
          if (myListFiltered.isNotEmpty) {
            myListFiltered.first.quantity++;
          } else {
            MainApp.cartBooks.add(book);
            MainApp.cartItemsNo++;
            book.quantity++;
          }
          MainApp.update();

        }, icon: Icon(Icons.shopping_cart,color: kPrimaryColor,)),
        MainApp.Manger?IconButton(onPressed: (){
          EditBook.book = book;
          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  EditBook()));
        }, icon: Icon(Icons.edit,color: kPrimaryColor,)):Container()
      ],
    ),
  );
}