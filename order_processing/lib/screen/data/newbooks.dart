import 'package:flutter/material.dart';
import 'package:order_processing/Constants.dart';
import 'package:order_processing/screen/data/book.dart';
import 'package:order_processing/component/isadmin.dart';

import '../EditBook.dart';
Widget newbook(BookData book,BuildContext context)
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
              image: NetworkImage(book.bookcover),
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
                 book.bookname,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight:FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                 book.Author,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on,color: kPrimaryColor,),
                    Text(book.Price.toString()),
                    SizedBox(width: 20.0),
                    Icon(Icons.numbers_sharp,color: kPrimaryColor,),
                    Text(book.Id.toString()),
                  ],
                )
              ],
            )
        ),
        IconButton(onPressed: (){
          // Navigator.push(context,  MaterialPageRoute(builder: (context) =>  EditBook()));
        }, icon: Icon(Icons.shopping_cart,color: kPrimaryColor,)),
        IconButton(onPressed: (){
          EditBook.book = book;
          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  EditBook()));
        }, icon: Icon(Icons.edit,color: kPrimaryColor,))
      ],
    ),
  );
}